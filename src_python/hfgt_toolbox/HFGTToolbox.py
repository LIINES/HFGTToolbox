"""
Copyright (c) 2018-2026 Engineering Systems Analytics LLC
@author:    Amro M. Farid, Michael Stewart, Chris Sharman, Papa Kwesi Aggrey, Ehsan Ghorbani, Amirreza Hosseini,
            Megan Harris, Mehdi Naderi, Inas Khayal, Malak Damdoum
@version: 4.7.6
@Note:  Version 4.0 is a major release constituting a full rewrite of the entire code base.
@Note:  See Bitbucket Commit History for an understanding the contributions of each author.
@Note:  Many changes were made from Dr. Farid's computer in collaboration with members of the author list above.
@Acknowledgement:  Thanks goes to Dr. Amro M. Farid, Dr. Wester C. H. Schoonenberg, and Dr. Dakota Thompson as the principal
                    authors of Versions 1, 2, 3 respectively.
@Modified: Nov 10 2026
@ Provided under the Creative Commons 4.0 License
Developed with Python 3.11.9
"""
import sys  # Needed for the parent function
import os, subprocess, shutil, time, copy, json, csv
import pathlib as pl
from datetime import datetime
import xml.etree.ElementTree as ET
from enum import Enum
# These require specific installation
import numpy as np          # Version 2.2.6
import pandas as pd         # Version 2.3.2
import geopandas as gpd     # Version 1.1.1
import regex                # Version 2025.7.34
import yaml                 # Version 6.0.3
# Scipy.sparse Version 1.15.3
from scipy.sparse import (coo_array, csc_array, dok_array, block_diag, hstack, vstack, kron, diags_array, issparse, bmat, eye, sparray)
# For 2-D sparse matricces.  Use COO by default, CSC for vector operations, and DOK for element access
# Sparse Version 0.16.0
from sparse import DOK # For N-D sparse tensors, DOK is the easiest way to construct the tensor
from sparse import COO # For N_D sparse tensors, COO is the default storage format of the toolbox
from sparse import concatenate

from juliacall import Main as jl
from contextlib import redirect_stdout
import io

# Logging Modules
from loguru import logger   # Version 0.7.3
from typing import Optional, List # Type hinting
from .logging import update_logging_level, add_file_logger, log_entry_exit_info, log_entry_exit_trace
# Add directory to path so that relative imports work when functions from this file
# are called via outside modules
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
# Performance Measurement Modules
import cProfile
import pstats

## Main Analytical Function
def runHFGTAnalysis(inputFilePath: str,
                    outputDirectory: str = '3_PyHFGT_Output_Data/',
                    juliaOutputDirectory: str = '4_JuliaHFGT_Output_Data/'):
    """
    Runs HFGT analysis using the provided input file path.
    
    Args:
        inputFilePath:  path to input data file.
        outputDirectory (optional, str): The output directory to output to.
        juliaOutputDirectory (optional, str): The julia output directory.
    
    Returns:
        myLFES: LFES data structure with completed analytical calculations
    """
    # These global variables take default values now, and will be changed once the input file has been read.
    # They will NEVER be changed after that!
    global inputDataFormat;     inputDataFormat = None
    global analysisMethod;      analysisMethod = 'default'
    update_logging_level("SUCCESS")

    inputFilePath = pl.Path(inputFilePath)              # Convert input file path string to Path object.
    print(f"Running HFGT Analysis on {inputFilePath} ...")
    # Add a file logger so that logs are writen
    # to the /logs folder
    # add_file_logger(inputFilePath.stem)
    startTime = time.time()                             # Begin Timer
    # Stage 1:  Populate myLFES with the inputData
    myLFES = importInputData(inputFilePath)
    # Configure the outputDirectory and juliaOutputDirectory of
    # the newly created LFES instance.
    myLFES = configureLFESOutputPaths(myLFES, outputDirectory, juliaOutputDirectory)
    logger.success('Phase 1 Success! Import Complete!  Total computation time taken: %f' % (time.time() - startTime))
    # Stage 2:  Conduct HFGT Structural Analysis
    myLFES.produceFinalLFES()                           # Product the Final LFES with all structural calculations
    logger.success('Phase 2 Success! Analysis Complete!  Total computation time taken: %f' % (time.time() - startTime))
    # Stage 3:  Export Data with the Correct Format
    saveMyData(myLFES)
    logger.success('Phase 3 Success! Data Saved!  Total computation & writing time taken: %f' % (time.time() - startTime))
    # Stage 4:  Conduct Behavioral Analysis
    if analysisMethod == 'default': pass
    elif analysisMethod == 'SoSResilience':
        # This is a placeholder for the integration with the associated Julia code.  Not done yet.
        pass
    elif analysisMethod == 'HFNMCF':
        # Method 1:  This is the new method that make use of Julia Call
        juliaCodePath = pl.Path(os.getcwd()) / "src_julia" / "HFNMCFTools"
        try:
            if not juliaCodePath.is_dir():
                msg = f"HFNMCFTools package directory not found: {juliaCodePath}"
                logger.error(msg)
                raise FileNotFoundError(msg)
            logger.info("Solving Optimized HFNMCF Problem...")
            jl.seval(f"""
            import Pkg
            Pkg.activate(raw"{juliaCodePath}")
            using HFNMCFTools
            """)
            juliaOutput = io.StringIO()
            with redirect_stdout(juliaOutput):
                jl.HFNMCFTools.optHFNMCF(str(myLFES.outputFilePath))
            logger.success("Success! Optimized HFNMCF Problem! %f" % (time.time() - startTime))
            logger.info(juliaOutput.getvalue())
            myLFES = loadMyData(myLFES.juliaOutputFilePath)
        except Exception as e:
            logger.error("Failed to solve Optimized HFNMCF Problem!")
            logger.error(str(e))
            logger.exception("Full exception traceback:")
            raise

        # # Method 2:  This methods runs the julia command directly from the terminal command line.
        # juliaCodePath = pl.Path(os.getcwd() + '/src_julia/runHFNMCF.jl')
        # if juliaCodePath.is_file():
        #     logger.info("Solving Optimized HFNMCF Problem...")
        #     try:
        #         juliaCMD = ['julia', str(juliaCodePath),  './' + str(myLFES.outputFilePath)]
        #         result = subprocess.run(juliaCMD,capture_output=True,text=True,check=True)
        #         logger.info("Success! Optimized HFNMCF Problem! %f" % (time.time() - startTime))
        #         logger.info(result.stdout)
        #         myLFES = loadMyData(myLFES.juliaOutputFilePath)
        #     except subprocess.CalledProcessError as e:
        #         logger.error("Optimization Failed!")
        #         logger.error("Command: {}", e.cmd)
        #         logger.error("Return code: {}", e.returncode)
        #         logger.error("STDOUT:\n{}", e.stdout)
        #         logger.error("STDERR:\n{}", e.stderr)
        #         raise
        # else:
        #     logger.warning("optHFNMCF.jl is not in the src_julia folder.")
        myLFES.dataState = ['Behavioral-Optimization']
        saveMyData(myLFES)
    elif analysisMethod == 'timedEvents':
        myLFES.engSysNet.XS = coo_array((myLFES.operand.number * myLFES.buffer.number, myLFES.timeKeeper.numEvents), dtype=int)
        for k in range(myLFES.timeKeeper.numEvents-1):
            temp = (myLFES.engSysNet.XS.tocsc()[:,k] + myLFES.engSysNet.MFull.dot(myLFES.engSysNet.UFull.tocsc()[:,k])).tocoo()
            myLFES.engSysNet.XS.row  = np.append(myLFES.engSysNet.XS.row, temp.row)
            myLFES.engSysNet.XS.col  = np.append(myLFES.engSysNet.XS.col, temp.col)
            myLFES.engSysNet.XS.data = np.append(myLFES.engSysNet.XS.data, temp.data)
        myLFES.dataState = ['Behavioral-Simulation']
        saveMyData(myLFES)
    else: pass
    logger.success('Phase 4 Success! ' + analysisMethod.capitalize() +
                   ' Analysis Complete! Total computation & writing time taken: %f' % (time.time() - startTime))
    return myLFES


## Helper Classes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class AnalysisMethod(Enum):
    DEFAULT        = "default"
    ANALYZESOS     = "SoSResilience"
    HFNCMCF        = "HFNMCF"
    TIMEDEVENTS    = "timedEvents"
class DataState(Enum):
    RAW        = "raw"
    STRUCTURAL = "structural"
    BEHAVIORAL = "Behavioral-Simulation"
    OPTIMAL    = "Behavioral-Optimization"
class InputDataFormat(Enum):
    DEFAULTXML    = "defaultXML"
    SYSML         = "sysml"
class OperandType(Enum):
    MATTER      = "matter"
    ENERGY      = "energy"
    INFORMATION = "information"
    PEOPLE      = "people"
    LIFE        = "life"
    MONEY       = "money"
class OutputFileType(Enum):
    JSON  = "json"
    SYSML = "sysml"
class PlaceType(Enum):
    SOURCE      = "source"
    MUSTPRODUCE = "must produce"
    SINK        = "sink"
    INTERNAL    = "internal"
# class VarDomain(Enum):
#     NONE    = None
#     ZERO    = "zero"
#     BINARY  = "binary"
#     INTEGER = "integer"
#     REAL    = "real"
#     INTEGER_POSITIVE = "integer+"
#     REAL_POSITIVE    = "real+"
# class VarDomainEnabled(Enum):
#     NONE    = None
#     ZERO    = "zero"
#     BINARY  = "binary"
#     INTEGER = "integer"
#     REAL    = "real"
#     INTEGER_POSITIVE = "integer+"
#     REAL_POSITIVE    = "real+"
class GenericClass():
    @log_entry_exit_trace
    def appendInputDataAttributes(self, myDict, myRequiredKeys=set()):
        """
        This function inserts values from a dictionary to an object if the object has a variable with the same name
        as that of a key in the dictionary.  The function provides extensive error-checking functionality on both myObj
        and myDict.  The actual appending happens with one append inside a FOR loop.
            
        Args:
            self: object being filled in
            myDict: dictionary with desired value
            myRequiredKeys: an optional list of keys that must be in the dictionary
        """
        myDictKeys = set(myDict.keys())
        myObjKeys = set(s.lstrip('_') if s.startswith('_') else s for s in vars(self).keys())
        # Try block:  Check if all the required keys are in the data...
        try:
            if myDictKeys.issuperset(myRequiredKeys):
                # Check if the object has all keys in the data...
                missingKeys = myDictKeys - myObjKeys
                if len(missingKeys) > 0:
                    for myKey in missingKeys:
                        logger.info("Warning! " + myKey + " exists in data but not defined in " + type(self).__name__ + "! Proceeding cautiously...")
                        setattr(self, myKey, [])

                # Check if the attributes in myObj are the correct length
                listLength = len(getattr(self, list(myDictKeys)[0]))
                for myKey in myDictKeys:
                    if len(getattr(self, myKey)) != listLength:
                        getattr(self, myKey).extend([None] * (listLength - len(getattr(self, myKey))))

                # Finally append the data!
                self.insertAttributeDataFromDict(myDict)
            else:
                raise ValueError("Fail! The following required keys are missing:", sorted(list(myRequiredKeys - myDictKeys)), "in ",
                  myDict[list(myDict.keys())[0]], ".  Abort! Abort!")
        except ValueError as e: logger.error(f"Error: {e}"); sys.exit(1)
    @log_entry_exit_trace
    def insertAttributeDataFromDict(self,myDict,opt='append'):
        """
        This function inserts values from a dictionary/object to an object if the object has a variable with the same name
        as that of a key in the dictionary.  The function provides extensive error-checking functionality on both myObj
        and myDict.  The insertion can be either an append or an extend depending on opt.  It happens inside a FOR loop.
            
        Args:
            self: GenericClass object
            myDict: dictionary with desired value
            opt: either 'append' or 'extend'
        """
        for myKey, myValue in myDict.items():
            if isinstance(myValue, str) and myValue == '':
                logger.info('Warning! Atttribute value is empty in ' + myKey + ' key in ' + type(self).__name__)
            if not hasattr(self, myKey):
                logger.info('Warning! ' + myKey + ' does not exist in ' + type(self).__name__ + '! Proceeding cautiously...')
                setattr(self, myKey, [])
            if isinstance(getattr(self, myKey), list):
                if opt == 'append':
                    # Need to eliminate any spaces that come immediately after a comma.
                    if isinstance(myValue, str):
                        myValue = regex.sub(r",\s+", ",", myValue)
                    # !!! Note: getattr(self, myKey).append(myValue) bypasses enum value checking!
                    # setattr() invokes enum value checking!
                    setattr(self,myKey, getattr(self, myKey) + [myValue])
                elif opt == 'extend':
                    # !!! Note: getattr(self, myKey).extend(myValue) bypasses enum value checking!
                    # setattr() invokes enum value checking!
                    setattr(self,myKey,getattr(self, myKey) + list(myValue))
            else:
                logger.warning("Warning! " + myKey + " is not a list! Proceeding cautiously...")
        self.fillAttributesWithNones(list(myDict.keys()))
    @log_entry_exit_trace
    def fillAttributesWithNones(self,myDictKeys):
        listLength = max((len(val) for key in myDictKeys if isinstance((val := getattr(self, key)), list)), default=1)
        myDictKeys = set(myDictKeys)
        myObjKeys = set(s.lstrip('_') if s.startswith('_') else s for s in vars(self).keys())
        neglectedKeys = myObjKeys - myDictKeys
        # Fill in the empty fields...
        for myKey in neglectedKeys:
            if isinstance(getattr(self, myKey), list):
                getattr(self, myKey).extend([None] * (listLength - len(getattr(self, myKey))))
    @log_entry_exit_trace
    def validateAttributeData(self):
        # Section 1:  Checking for Required Keys
        tempKeys = list(getattr(self.requiredKeys,analysisMethod))
        for k in range(len(tempKeys)):
            # Extracting tempValue for simplicity.  Remember LFES attributes are not encased in a list.
            if isinstance(self,LFES):tempValue = [getattr(self, tempKeys[k])]
            else: tempValue = getattr(self, tempKeys[k])
            # Try block:  checking if all attributes are lists with the correct length
            try:
                if len(tempValue) != self.number:
                    raise ValueError("Error! " + type(self).__name__ + " + " + self.name[k] +
                                     ' does not have the right number of ' + self.validator.keys[k] + ' values!')
            except ValueError as e: logger.error(f"Error: {e} Abort! Abort!"); sys.exit(1)
            # Try block:  check if all the required keys are present.
            try:
                tempIdx = [idx for idx, v in enumerate(tempValue) if v is None]
                if len([idx for idx, v in enumerate(tempValue) if v is None]) > 0:
                    idxStr = ', '.join(str(i) for i in tempIdx)
                    raise ValueError(f"Fail!  {tempKeys[k]}  is a required key in {type(self).__name__}.  Check indices: {idxStr}!")
            except ValueError as e: logger.error(f"{e}  Abort! Abort!"); sys.exit(1)
        # Section 2:  Validating Keys
        for k in range(len(self.validator.keys)):
            if isinstance(self,LFES):tempValue = [getattr(self, self.validator.keys[k])]
            else: tempValue = getattr(self, self.validator.keys[k])
            tempKey = self.validator.keys[k]
            if self.validator.keyTypes[k] == 'int':
                setattr(self, self.validator.keys[k], [int(x) if x not in (None, "") else None for x in tempValue])
            elif self.validator.keyTypes[k] == 'bool':
                setattr(self, self.validator.keys[k], [boolify(x) if x not in (None, "") else None for x in tempValue])
            elif self.validator.keyTypes[k] == 'float':
                setattr(self, self.validator.keys[k], [float(x) if x not in (None, "") else None for x in tempValue])
            elif self.validator.keyTypes[k] == 'floatVector':
                myValue = [[float(x.strip()) for x in s.split(',')] if s not in (None, "") else None for s in tempValue]
                setattr(self,self.validator.keys[k],myValue)
            elif self.validator.keyTypes[k] == 'floatMatrix':
                myValue = [''] * len(tempValue)
                for k1 in range(len(tempValue)):
                    if tempValue[k1] not in (None,""):
                        myValue[k1] = np.array([[float(x.strip()) for x in s.split(',')] for s in tempValue[k1].split(';')])
                    else: myValue[k1] = None
                setattr(self, self.validator.keys[k], myValue)
            if self.validator.keyTypes[k] == 'string':
                setattr(self, self.validator.keys[k], [x if x not in (None, "") else None for x in tempValue])
            elif self.validator.keyTypes[k] == 'strVector':
                setattr(self, self.validator.keys[k], [[x.strip() for x in s.split(',')] if s not in (None, "") else None for s in tempValue])
            else: pass
        if isinstance(self, LFES):
                for myKey in self.validator.keys: setattr(self, myKey, getattr(self, myKey)[0])
    # @property
    # def varDomain(self) -> VarDomain | list[VarDomain]:
    #     return self._varDomain
    # @varDomain.setter
    # def varDomain(self,myValue):
    #     # Try Block:  checking for type correctness of myValue.
    #     try:
    #         if isinstance(myValue, VarDomain): self._varDomain = myValue
    #         elif isinstance(myValue, str):
    #             # Try Block:  checking for type correctness of myValue.
    #             try: self._varDomain = VarDomain(myValue) # allow strings, but validate them
    #             except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in VarDomain]}"); sys.exit1(1)
    #         elif isinstance(myValue, list):
    #             tempList = [None] * len(myValue)
    #             for k in range(len(myValue)):
    #                 try:
    #                     if isinstance(myValue[k],VarDomain):
    #                         tempList[k] = myValue[k]
    #                     elif myValue[k] == None:
    #                         tempList[k] = myValue[k]
    #                     elif isinstance(myValue[k], str):
    #                         temp = myValue[k].split(',')
    #                         tempList[k] = [VarDomain(x) for x in temp]
    #                     elif isinstance(myValue[k],list):
    #                         tempList[k] = [VarDomain(x) for x in myValue[k]]
    #                     else:
    #                         raise TypeError(f"VarDomain() can only take a VarDomain, str, or list! Invalid type at index {k}: {type(myValue[k]).__name__}")
    #                 except Exception as e: logger.error(f"{e}"); sys.exit(1)
    #             self._varDomain = tempList
    #         else: raise TypeError("VarDomain must be an VarDomain enum, valid string, or valid list.")
    #     except TypeError as e: logger.error(f"TypeError: {e}"); sys.exit(1)

    # @property
    # def varDomainEnabled(self) -> VarDomainEnabled | list[VarDomainEnabled]:
    #     return self._varDomainEnabled
    # @varDomainEnabled.setter
    # def varDomainEnabled(self,myValue):
    #     # Try Block:  checking for type correctness of myValue.
    #     try:
    #         if isinstance(myValue, VarDomainEnabled): self._varDomainEnabled = myValue
    #         elif isinstance(myValue, str):
    #             # Try Block:  checking for type correctness of myValue.
    #             try: self._varDomainEnabled = VarDomainEnabled(myValue) # allow strings, but validate them
    #             except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in VarDomainEnabled]}"); sys.exit1(1)
    #         elif isinstance(myValue, list):
    #             tempList = [None] * len(myValue)
    #             for k in range(len(myValue)):
    #                 try:
    #                     if isinstance(myValue[k],VarDomainEnabled):
    #                         tempList[k] = myValue[k]
    #                     elif myValue[k] == None:
    #                         tempList[k] = myValue[k]
    #                     elif isinstance(myValue[k], str):
    #                         temp = myValue[k].split(',')
    #                         tempList[k] = [VarDomainEnabled(x) for x in temp]
    #                     elif isinstance(myValue[k],list):
    #                         tempList[k] = [VarDomainEnabled(x) for x in myValue[k]]
    #                     else:
    #                         raise TypeError(f"VarDomainEnabled() can only take a VarDomainEnabled, str, or list! Invalid type at index {k}: {type(myValue[k]).__name__}")
    #                 except Exception as e: logger.error(f"{e}"); sys.exit(1)
    #             self._varDomainEnabled = tempList
    #         else: raise TypeError("VarDomainEnabled must be an VarDomainEnabled enum, valid string, or valid list.")
    #     except TypeError as e: logger.error(f"TypeError: {e}"); sys.exit(1)
class RequiredKeys(GenericClass):
    """A class representing the required keys for
    different scenarios (default, Systems of Systems Resilience,
    Heterofunctional Network Minimum Cost Flow). Each is represented as a list, and
    updated via parent instances as needed. These RequiredKeys are used for the 
    purpose of validating the input data for a particular scenario.

    Attributes:
        default(list): The required keys for the default problem.
        SoSResilience(list): The required keys for the Systems of Systems resilience problem.
        HFNMCF(list): The required keys for the Heterofunctional Network Minimum Cost Flow problem.
    """
    def __init__(self):
        self.default       = []
        self.SoSResilience = []
        self.HFNMCF        = []
        self.timedEvents   = []
class Validator(GenericClass):
    def __init__(self):
        self.keys = []
        self.keyTypes = []
class SparseMAT():
    def __init__(self,myInput=None):
        if isinstance(myInput,DOK):
            self.coords = [[int(x) for x in myKey] for myKey in myInput.data.keys()]
            self.data =  [int(x) if x.is_integer() else float(x) for x in myInput.data.values()]
            self.sparseType = type(myInput).__name__
            self.shape = list(myInput.shape)
            self.nnz = myInput.nnz
            self.ndim = myInput.ndim
            pairs = sorted(zip(self.coords, self.data))
            self.coords = [a for a, b in pairs]
            self.data = [b for a, b in pairs]
        elif isinstance(myInput,(COO,coo_array)):
            self.coords = [[int(x) for x in row] for row in zip(*myInput.coords)]
            self.data = [int(x) if x.is_integer() else float(x) for x in myInput.data]
            self.sparseType = type(myInput).__name__
            self.shape = list(myInput.shape)
            self.nnz = myInput.nnz
            self.ndim = myInput.ndim
            pairs = sorted(zip(self.coords, self.data))
            self.coords = [a for a, b in pairs]
            self.data = [b for a, b in pairs]
        else:
            self.coords     = []
            self.data       = []
            self.shape      = []
            self.nnz        = []
            self.ndim       = []
            self.sparseType = []
## LFES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class LFES(GenericClass):
    """Represents all the components in the HFGT toolbox LFES structure"""
    def __init__(self):
        self.requiredKeys = RequiredKeys()      # The Required Keys for the LFES Class
        # Primitive data attributes for validation.  See validateAttributeData()
        self._analysisMethod = []               # Analysis Method String. See AnalysisMethod enumeration for choices.
        self._dataState = []                    # LFES dataState goes from "raw" to "structural" to either "Behavioral-Simulation"
        self._inputDataFormat = []              # Input Data Format String. See InputDataFormat enumeration for choices.
        self.name = []                          # The name of the LFS
        self._outputFileType = []               # The output filetype.  Currently, only JSON and SysML are supported.
        self.refArchitecture = []               # The reference architecture to which the myLFES instances adheres.
        self.scenario = []                      # The name of the computational experiment that is being run.
        self.verboseMode = []                   # True/False. Provides more or less information to the standard output during runtime.
        self.requiredKeys.default = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys())-{'requiredKeys'}}
        self.requiredKeys.SoSResilience = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys()) - {'requiredKeys'}}
        self.requiredKeys.timedEvents = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys())-{'requiredKeys'}}

        self.optimizer = []
        self.deltaT = []
        self.simHorizon = []

        self.hasESN_STF1 = []
        self.hasESN_STF2 = []
        self.hasESNEnablingConstraint = []
        self.hasESN_Duration = []

        self.hasBufferLinearCost = []
        self.hasBufferQuadCost = []
        self.hasBufferUpperBound = []
        self.hasBufferLowerBound = []
        self.hasBufferInitCond = []
        self.hasBufferFinalCond = []

        self.hasProcessLinearCostFlowNeg = []
        self.hasProcessLinearCostFlowPos = []
        self.hasProcessLinearCostStock = []

        self.hasProcessQuadCostFlowNeg = []
        self.hasProcessQuadCostFlowPos = []
        self.hasProcessQuadCostStock = []

        self.hasProcessUpperBoundFlowNeg = []
        self.hasProcessUpperBoundFlowPos = []
        self.hasProcessUpperBoundStock = []

        self.hasProcessLowerBoundFlowNeg = []
        self.hasProcessLowerBoundFlowPos = []
        self.hasProcessLowerBoundStock = []

        self.hasProcessInitCond = []
        self.hasProcessFinalCond = []
        self.hasProcessUpperBoundRamp = []
        self.hasProcessLowerBoundRamp = []
        self.hasProcessDuration = []
        self.hasProcessValues = []
        self.requiredKeys.HFNMCF = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys())-{'requiredKeys'}}

        self.subAnalysisMethod = []
        # Primitive data attributes for calculation
        self.number = 1
        self.runCode = []
        # Non-primitive data attributes for calculation
        self.view = []
        self.analytics = Analytics()
        self.buffer = Buffer()
        self.decisionMaker = DecisionMaker()
        self.engSysNet = PetriNet()
        self.holdingProcess = HoldingProcess()
        self.independentBuffer = IndependentBuffer()
        self.inputFilePath = pl.Path('')
        self.operand = Operand()
        self.outputDirectory = pl.Path('3_PyHFGT_Output_Data/')
        self.juliaOutputFilePath = pl.Path('./4_JuliaHFGT_Output_Data/')  # In stand alone Julia, this needs to be ../4-JuliaHFGT...
        self.outputFilePath = pl.Path('')
        self.physicalResource = PhysicalResource()
        self.sosService = Operand()
        self.systemConcept = SystemConcept()
        self.systemProcess = SystemProcess()
        self.timeKeeper = TimeKeeper()
        self.transformProcess = TransformProcess()
        self.transformationResource = TransformationResource()
        self.transportProcess = TransportProcess()
        self.transportationResource = TransportationResource()

        # Primitive attributes for validation
        self.validator = Validator()
        self.validator.keys = ['deltaT', 'simHorizon', 'hasESN_STF1', 'hasESN_STF2', 'hasESN_Duration', 'hasESNEnablingConstraint',
                               'hasBufferLinearCost','hasBufferQuadCost','hasBufferUpperBound', 'hasBufferLowerBound', 'hasBufferFinalCond','hasBufferInitCond',
                               'hasProcessLinearCostFlowNeg', 'hasProcessLinearCostFlowPos', 'hasProcessLinearCostStock',
                               'hasProcessQuadCostFlowNeg', 'hasProcessQuadCostFlowPos', 'hasProcessQuadCostStock',
                               'hasProcessUpperBoundFlowNeg', 'hasProcessUpperBoundFlowPos', 'hasProcessUpperBoundStock',
                               'hasProcessLowerBoundFlowNeg', 'hasProcessLowerBoundFlowPos','hasProcessLowerBoundStock',
                               'hasProcessInitCond', 'hasProcessFinalCond', 'hasProcessDuration','hasProcessValues','hasProcessUpperBoundRamp','hasProcessLowerBoundRamp']
        self.validator.keyTypes = ['int', 'int','bool','bool', 'bool', 'bool',
                                   'bool','bool', 'bool','bool', 'bool', 'bool',
                                   'bool','bool','bool',
                                   'bool','bool','bool',
                                   'bool', 'bool', 'bool',
                                   'bool', 'bool', 'bool',
                                   'bool','bool','bool','bool','bool','bool']
    @property
    def analysisMethod(self) -> AnalysisMethod | list[AnalysisMethod]:
        return self._analysisMethod
    @analysisMethod.setter
    def analysisMethod(self, myValue):
        # Try Block:  checking for type correctness of myValue.
        try:
            if isinstance(myValue, AnalysisMethod): self._analysisMethod = myValue
            elif isinstance(myValue, str):
                # Try Block:  checking for value correctness of myValue.
                try: self._analysisMethod = AnalysisMethod(myValue) # allow strings, but validate them
                except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in AnalysisMethod]}"); sys.exit1(1)
            elif isinstance(myValue, list):
                self._analysisMethod = [AnalysisMethod(v) for v in myValue]
            else: raise TypeError("AnalysisMethod must be an AnalysisMethod enum, valid string, or valid list.")
        except TypeError as e: logger.error(f"TypeError: {e}"); sys.exit(1)
    @property
    def dataState(self) -> OperandType | list[OperandType]:
        return self._dataState
    @dataState.setter
    def dataState(self, myValue):
        # Try Block:  checking for type correctness of myValue.
        try:
            if isinstance(myValue, DataState): self._dataState = myValue
            elif isinstance(myValue, str):
                # Try Block:  checking for value correctness of myValue.
                try: self._dataState = DataState(myValue) # allow strings, but validate them
                except ValueError: logger.error(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in OperandType]}"); sys.exit(1)
            elif isinstance(myValue, list):
                self._dataState = [DataState(v) for v in myValue]
            else: raise TypeError("DataState must be a DataState enum, valid string, or valid list.")
        except TypeError as e: logger.error(f"Type error: {e}"); sys.exit(1)
    @property
    def inputDataFormat(self) -> InputDataFormat | list[InputDataFormat]:
        return self._inputDataFormat
    @inputDataFormat.setter
    def inputDataFormat(self, myValue):
        # Try Block:  checking for type correctness of myValue.
        try:
            if isinstance(myValue, InputDataFormat): self._inputDataFormat = myValue
            elif isinstance(myValue, str):
                # Try Block:  checking for value correctness of myValue.
                try: self._inputDataFormat = InputDataFormat(myValue) # allow strings, but validate them
                except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in InputDataFormat]}"); sys.exit1(1)
            elif isinstance(myValue, list): self._inputDataFormat = [InputDataFormat(v) for v in myValue]
            else: raise TypeError("InputDataFormat must be an InputDataFormat enum, valid string, or valid list.")
        except TypeError as e: logger.error(f"Type error: {e}"); sys.exit(1)
    @property
    def outputFileType(self) -> OutputFileType | list[OutputFileType]:
        return self._outputFileType
    @outputFileType.setter
    def outputFileType(self, myValue):
        # Try Block:  checking for type correctness of myValue.
        try:
            if isinstance(myValue, OutputFileType): self._outputFileType = myValue
            elif isinstance(myValue, str):
                # Try Block:  checking for value correctness of myValue.
                try: self._outputFileType = OutputFileType(myValue) # allow strings, but validate them
                except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in OutputFileType]}"); sys.exit(1)
            elif isinstance(myValue, list): self._outputFileType = [OutputFileType(v) for v in myValue]
            else: raise TypeError("OutputFileType must be an OutputFileType enum, valid string, or valid list.")
        except TypeError as e: logger.error(f"Type error: {e}"); sys.exit(1)
    @log_entry_exit_trace
    def populateInputData(self):
        """
        This function populates this LFES's attributes with data loaded from
        either an XML or SysML file. The data is loaded from this LFES's inputFilePath,
        validated, and then used to populate the myKeys attribute.

        After the data is loaded, the standardizeInputFilePath() function is called.
        This builds a standardized filename, based on several of this LFES' attributes
        e.g. scenario, runCode, etc. During this step, if the inputFilePath does not follow
        this standard naming convention, the input file is copied into an
        Archive/ folder and the input file is renamed to the standardized name.
        inputFilePath is then adjusted to this standardised name.

        Several globals are set during the execution of this function, based on the
        corresponding entries in the input data file:
         - analysisMethod
         - inputDataFormat
        These are stored as globals in order to avoid needing to pass them around to
        many other functions.

        The logging level is set to DEBUG from here onwards if verboseMode = True.

        Raises:
            ValueError: If any errors arise, for example an unexpected file type, LFES name
                containing whitespace characters, etc. A ValueError is also raised if the
                input data does not contain any operands.

        """
        global analysisMethod
        global inputDataFormat
        # # Try Block:  checking for XML or SysML data
        try:
            suffix = self.inputFilePath.suffix.lower()
            if suffix == '.xml':
                # For XML files ONLY, setup the values of the high-level attributes
                _, xmlTree, _ = importXMLData(str(self.inputFilePath.absolute()))                       # Import all the XML Data
                # Try block:  safely imports the analysisMethod attribute
                try: self.analysisMethod = xmlTree.attrib['analysisMethod']
                except KeyError: raise ValueError("Fail! The LFES element has no analysis method! Abort! Abort!"); sys.exit(1)
                # !!! Note: Safely changing GLOBAL analysisMethod & inputDataFormat once and forever
                analysisMethod = self.analysisMethod.value
                requiredKeys = getattr(self.requiredKeys, analysisMethod) - {'analysisMethod'}
                del xmlTree.attrib['analysisMethod']
                self.appendInputDataAttributes(xmlTree.attrib, requiredKeys)
            elif suffix == '.sysml':
                # For SysML files ONLY, setup the values of the high-level attributes.
                mySysMLDict = importSysMLFile(self.inputFilePath)
                validateSysMLDict(mySysMLDict, 'instantiated', None)
                if 'view' in mySysMLDict: mySysMLDict['part'][0]['view'] = mySysMLDict['view']
                logger.info("Throwing away part definition data. Proceeding with only the first part instance!")
                mySysMLDict = mySysMLDict['part'][0]
                self.appendInputDataAttributes(mySysMLDict)  # For SysML Files, fill in all the LFES attributes.
                # !!! Note: Safely changing GLOBAL analysisMethod once and forever
                analysisMethod = self.analysisMethod[0].value
                delattr(self, "myClass")
            else: raise ValueError(f"Unsupported input file type: '{suffix}'")
        except ValueError as e: logger.error(e); sys.exit(1)
        # For both XML files and SysML files, take these common actions.
        # Pulling myLFES data attributes out of lists.
        myKeys = set(s.lstrip('_') if s.startswith('_') else s for s in vars(self).keys())
        for myKey in myKeys:
            if isinstance(getattr(self,myKey),list):
                setattr(self,myKey,getattr(self,myKey)[0])
        # If verboseMode is True, restart the console logger at the TRACE level.
        # The file logger (which outputs to logs/) remains unchanged.
        self.verboseMode = boolify(self.verboseMode)
        # !!! Note:  Safely changing GLOBAL inputDataFormat once and forever
        inputDataFormat = self.inputDataFormat.value
        # Try Block:  The LFES name must not contain any whitespace characters.
        try:
            if regex.search(r"\s", self.name): raise ValueError("Fail! LFES name must not have whitespace characters!")
        except ValueError as e: logger.error(f"{e} Abort! Abort!"); sys.exit(1)
        self.standardizeInputFilePath()
        if 'defaultXML' in inputDataFormat: self.populateXMLDataDefault(xmlTree)
        elif 'sysml' in inputDataFormat: self.populateSysMLData()
        else: pass
        # Try Block:  Checking for the presence of operands in the input file
        try:
            if len(self.operand.operandName) == 0: raise ValueError("Fail! No operands have been defined in this system!")
        except ValueError as e: logger.error(f"{e} Abort! Abort!"); sys.exit(1)
        if len(self.transformationResource.transformationResourceName) == 0:
            logger.warning("Warning!  No transformation resources have been defined in this system! Closed system! Proceeding cautiously ...")
        if len(self.transportationResource.transportationResourceName) == 0:
            logger.warning("Warning!  No transportation resources have been defined in this system! All transportations done by buffers! Proceeding cautiously ...")
    @log_entry_exit_trace
    def produceFinalLFES(self):
        """
        This method acts upon the myLFES instance produced by populateXMLData() and computes the HFGT mathematical
        models.

        Upon completion, this LFES will be complete, containing HFGT mathematical models
            
        Args:
            myLFES: Instantiated myLFES object with HFGT meta-elements already set-up
        """
        logger.success("Carrying out HFGT calculations ...")
        self.validateAttributeData()
        # Calculate Operand Net Data
        self.operand.calcOperand()
        # Get the Configuration of the Analysis Method
        configAnalysisMethod = self.getConfigAnalysisMethod()
        # Calculate Transformation Resource Data
        self.transformationResource.calcResource(configAnalysisMethod,self.transportProcess,self.transformProcess)
        # Calculate Independent Buffer Data
        self.independentBuffer.calcResource(configAnalysisMethod,self.transportProcess)
        # Calculate Buffers from transformation resources and independent buffer names
        self.joinResources('Buffers')
        # Calculate Transportation Resource Data
        self.transportationResource.calcResource(configAnalysisMethod,self.transportProcess)
        # Calculate Resources from transformation resources, independent buffers, and transportation resource names
        self.joinResources('PhysicalResources')
        # Calculate Decision-Maker Data
        self.decisionMaker.calcDecisionMakers()
        # Calculate Decision-Maker Adjacency Matrix
        self.decisionMaker.calcDecisionMakerAdjacency()
        # Pack Sets of System Processes
        self.packSetSystemProcess()
        # Pack the Time Keeper
        self.timeKeeper.value = sorted(self.timeKeeper.value)
        self.timeKeeper.idx = list(range(len(self.timeKeeper.value)))
        self.timeKeeper.numEvents = len(self.timeKeeper.idx)
        # Calculate the entire system concept
        self.calcSystemConcept()
        # Calculate System-of-Systems Service Net
        if analysisMethod == 'SoSResilience':
            self.sosService = self.operand.calcSoSService()
        # Calculate Operand Feasibility Matrices
        self.calcOperandNetFeasibility()
        # Calculate Decision-Maker Agency Matrix
        self.calcDecisionMakerAgencyMatrix()
        # Calculate Hetero-functional Incidence Tensors
        self.calcHeterofunctionalIncidenceTensor()
        # Calculate Engineering System Net
        self.calcEngineeringSystemNet()
        # Calculate Hetero-functional Adjacency Matrix ARho
        self.calcHeterofunctionalAdjacencyMatrix()
        # Calculate System Adjacency Matrix
        self.calcSystemAdjacencyMatrix()
        self.dataState = 'structural'
    # Functions for populateXMLData()~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @log_entry_exit_trace
    def standardizeInputFilePath(self):
        inputFilePath = self.inputFilePath

        # Run git log to retrieve the date (YYYY-MM-DD) and save it as the runCode string.
        # If this is not a git repository, the words "not a git repository" will appear
        # in this output, and the user will be asked if they want to proceed.
        if not isGitRepo():
            flag = input('Warning! Executing without Git Version Control!  Proceed?(y/n)')
            # Try Block:  checking for GIT usage.
            try:
                if flag.lower() == 'y':
                    self.runCode = datetime.today().strftime('%Y-%m-%d') + '-NoGit'
                else:
                    raise RuntimeError("Wise Choice! Git is an essential part of computational research!")
            except RuntimeError as e:
                logger.error(e); sys.exit(1)
        else:
            subprocess_output = subprocess.check_output('git log -1 --pretty=format:"%ad" --date="short"', shell=True, text=True)
            self.runCode = subprocess_output

        standardName = self.name + '-' + self.inputDataFormat.value.title() + '-' +  self.scenario.title() + '-' +  self.runCode.title() + inputFilePath.suffix
        # Check if ENABLE_ARCHIVING is true (the default).
        # If it has been set to false, such as during the tests, do not archive.
        if inputFilePath.name != standardName and os.getenv("ENABLE_ARCHIVING", "True").lower() != "false":
            archiveTarget = (inputFilePath.parent).joinpath('Archive/').joinpath(inputFilePath.name)
            shutil.copy2(inputFilePath, archiveTarget)
            standardTarget = (inputFilePath.parent).joinpath(standardName)
            inputFilePath.rename(standardTarget)
            self.inputFilePath = standardTarget
    @log_entry_exit_trace
    def populateSysMLData(self):
        logger.info('Handling file with default SysML file format ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
        self.processSysMLParts()
        self.processSysMLItems()
        self.setupSysMLOperand()
        self.setupTransformationResources()
        self.setupIndependentBuffers()
        self.setupTransportationResources()
        self.decisionMaker = objectify(self.decisionMaker)
        self.decisionMaker.setupDecisionMakers()
        delattr(self,'myName')
    @log_entry_exit_trace
    def populateXMLDataDefault(self,xmlTree):
        logger.info('Handling file with default XML file format ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
        for xmlBranch in xmlTree:  # Loop over resource-operand layer
            logger.trace('Started ', xmlBranch.tag,' Object~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
            # Try Block:  checking for Level 1 XML element names.
            try:
                if xmlBranch.tag == "Operand": self.operand.setupOperand(xmlBranch)
                elif xmlBranch.tag == "TransformationResource": self.setupTransformationResources(xmlBranch)
                elif xmlBranch.tag == "IndependentBuffer": self.setupIndependentBuffers(xmlBranch)
                elif xmlBranch.tag == "TransportationResource": self.setupTransportationResources(xmlBranch)
                elif xmlBranch.tag == "DecisionMaker": self.decisionMaker.setupDecisionMakers(xmlBranch)
                else: raise ValueError(f"The XML tag '{xmlBranch.tag}' in the Resource-Operand Layer is invalid! Abort! Abort!")
            except ValueError as e: logger.error(e); sys.exit(1)
            logger.trace('Finished ', xmlBranch.tag,' Object~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    @log_entry_exit_trace
    def processSysMLParts(self):
        if hasattr(self, "part"):
            partTypes = np.array([item['myClass'] for item in self.part])
            uniquePartTypes = np.unique(partTypes).tolist()
            for elem in uniquePartTypes:
                idxList = (np.where(partTypes == elem)[0]).tolist()
                tempList = [self.part[k] for k in idxList]
                if 'action' in tempList[0].keys():
                    for k in range(len(tempList)):
                        tempList[k]['action'] = transposeListOfDicts(tempList[k]['action'])
                myDict = transposeListOfDicts(tempList)
                setattr(self, lowerCaseFirstLetter(elem), myDict)
            delattr(self,'part')
    @log_entry_exit_trace
    def processSysMLItems(self):
        itemTypes = np.array([item['myClass'] for item in self.item])
        uniqueItemTypes = np.unique(itemTypes).tolist()
        for elem in uniqueItemTypes:
            idxList = (np.where(itemTypes == elem)[0]).tolist()
            tempList = [self.item[k] for k in idxList]
            tempDict = transposeListOfDicts(tempList)
            setattr(self, lowerCaseFirstLetter(elem), tempDict)
        delattr(self, 'item')
    @log_entry_exit_trace
    def convertLFES2SysMLDict(self):
        mySysMLDict = {"view": [], "part def": [], "item def": [], "action def": [], "part": []}
        mySysMLDict = self.extractSysMLViews(mySysMLDict)
        mySysMLDict = self.extractSysMLDefs(mySysMLDict,'part def')
        mySysMLDict = self.extractSysMLDefs(mySysMLDict,'item def')
        mySysMLDict = self.extractSysMLDefs(mySysMLDict,'action def')
        mySysMLDict = self.extractSysMLParts(mySysMLDict)
        return mySysMLDict
    @log_entry_exit_trace
    def extractSysMLViews(self,mySysMLDict):
        mySysMLDict['view'] = self.view
        return mySysMLDict
    @log_entry_exit_trace
    def extractSysMLDefs(self,mySysMLDict,opt):
        # Warning!  This code does not yet handle SysML Defs that have default values!
        if opt == 'part def':
            tempDict = {stripUnderscores(key): '' for key in vars(self)}
            tempDict = tempDict | {'myName': type(self).__name__ , 'myParentClass':''}
            mySysMLDict['part def'].append(tempDict)
            if self.dataState.value == 'raw': myKeys = ['transformationResource', 'independentBuffer', 'transportationResource']
            else:
                logger.warning('Warning!  Only the raw data state is currently implemented! Proceeding cautiously ...')
                myKeys = [k for k, v in vars(self).items() if isinstance(v, list)]
        elif opt == 'item def':
            myKeys = ['operand']
        elif opt == 'action def':
            myKeys = ['transformProcess', 'transportProcess']
        else: pass
        for myKey in myKeys:
            tempDict = {stripUnderscores(key): '' for key in vars(getattr(self, myKey))}
            tempDict = tempDict | {'myName': type(getattr(self, myKey)).__name__, 'myParentClass': ''}
            mySysMLDict[opt].append(tempDict)
        return mySysMLDict
    @log_entry_exit_trace
    def extractSysMLParts(self, mySysMLDict):
        self.myClass = type(self).__name__
        mySysMLDict['part'] = [dict()]
        # Handling LFES
        myKeys = stripUnderscores(list(vars(self).keys()))
        calculatedKeys = ['outputDirectory','outputFilePath','runCode','view']
        mySysMLDict['part'][0]['part'] = []
        mySysMLDict['part'][0]['item'] = []
        tempList = ['operand','transformationResource','independentBuffer','transportationResource']
        myKeys = tempList + sorted(set(myKeys) - set(tempList))
        for myKey in myKeys:
            if myKey in calculatedKeys: pass
            elif myKey == 'inputDataFormat':
                mySysMLDict['part'][0]['inputDataFormat'] = 'sysml'
            elif myKey == 'name':
                mySysMLDict['part'][0]['myName'] = self.name
                mySysMLDict['part'][0]['name'] = self.name
            elif isinstance(getattr(self,myKey),(str,list)):
                mySysMLDict['part'][0][myKey] = getattr(self,myKey)
            elif isinstance(getattr(self,myKey),bool):
                mySysMLDict['part'][0][myKey] = lowerCaseFirstLetter(str(getattr(self, myKey)))
            elif isinstance(getattr(self,myKey),Enum):
                mySysMLDict['part'][0][myKey] = getattr(self,myKey).value
            elif isinstance(getattr(self,myKey),Operand):
                myOperands = getattr(self,myKey)
                mySysMLDict['part'][0]['item'].extend(myOperands.extractSysMLOperands())
            elif isinstance(getattr(self,myKey),(TransformationResource,IndependentBuffer,TransportationResource)):
                myResources = getattr(self,myKey)
                mySysMLDict['part'][0]['part'].extend(myResources.extractSysMLResources())
            elif isinstance(getattr(self, myKey), DecisionMaker):
                myDecisionMakers = getattr(self, myKey)
                mySysMLDict['part'][0]['part'].extend(myDecisionMakers.extractSysMLDecisionMakers())
            else: pass
        return mySysMLDict
    @log_entry_exit_trace
    def setupSysMLOperand(self):
        if 'part' in self.operand:
            # Translate parts into pnPlaces and pnTransitions and delete
            self.operand['pnPlaces'] = [None] * len(self.operand['part'])
            self.operand['pnTransitions'] = [None] * len(self.operand['part'])
            for k in range(len(self.operand['part'])):
                tempDict = self.operand['part'][k]
                # Calculate the Operand Net Places
                tempList = pd.DataFrame(tempDict).to_dict(orient='records')
                tempList = cleanNonesFromListofDicts([x for x in tempList if x['myClass'] == 'OperandPlace'])
                if tempList:
                    self.operand['pnPlaces'][k] = transposeListOfDicts(tempList)
                else:
                    self.operand['pnPlaces'] = None
                # Calculate the Operand Net Transitions
                tempList = pd.DataFrame(tempDict).to_dict(orient='records')
                tempList = cleanNonesFromListofDicts([x for x in tempList if x['myClass'] == 'OperandTransition'])
                if tempList:
                    self.operand['pnTransitions'][k] = transposeListOfDicts(tempList)
                else:
                    self.operand['pnTransitions'] = None
            del self.operand['part']
        self.operand = objectify(self.operand)
        myDictKeys = [k for k, v in vars(self.operand).items() if isinstance(v, list) and v]
        self.operand.fillAttributesWithNones(myDictKeys)
        delattr(self.operand, "myName")

        for k in range(len(self.operand.pnPlaces)):
            if isinstance(self.operand.pnPlaces[k], OperandPlace):
                myDictKeys = [k for k, v in vars(self.operand.pnPlaces[k]).items() if isinstance(v, list) and v]
                self.operand.pnPlaces[k].fillAttributesWithNones(myDictKeys)
                delattr(self.operand.pnPlaces[k], 'myName')
            if isinstance(self.operand.pnTransitions[k], OperandTransition):
                myDictKeys = [k for k, v in vars(self.operand.pnTransitions[k]).items() if isinstance(v, list) and v]
                self.operand.pnTransitions[k].fillAttributesWithNones(myDictKeys)
                delattr(self.operand.pnTransitions[k], 'myName')
    @log_entry_exit_trace
    def setupTransformationResources(self, myRoot=None):
        """
        This method sets up the transformation resources in the myLFES object as part of the populateXMLData() method.

        Upon completion, this LFES will be an instantiated Large Flexible Engineering System object
        ready to compute HFGT mathematical models.
        
        Args:
            myRoot: An element tree object that contains the input XML file data.
        """
        if 'defaultXML' in inputDataFormat:
            myRequiredKeys = getattr(self.transformationResource.requiredKeys, analysisMethod)
            self.transformationResource.appendInputDataAttributes(myRoot.attrib,myRequiredKeys)
            for myChild in myRoot:
                # Try Block:  checking for level 2 XML element names.
                try:
                    if myChild.tag == 'TransformationProcess':
                        if self.transformationResource.transformProcess[-1] is None:
                            self.transformationResource.transformProcess[-1] = TransformProcess()
                        myRequiredKeys = getattr(self.transformationResource.transformProcess[-1].requiredKeys, analysisMethod)
                        self.transformationResource.transformProcess[-1].appendInputDataAttributes(myChild.attrib,myRequiredKeys)
                        self.systemConcept.DOFM += 1
                    elif myChild.tag == 'TransportationProcess':
                        if self.transformationResource.transportProcess[-1] is None:
                            self.transformationResource.transportProcess[-1] = TransportProcess()
                        myRequiredKeys = getattr(self.transformationResource.transportProcess[-1].requiredKeys, analysisMethod)
                        self.transformationResource.transportProcess[-1].appendInputDataAttributes(myChild.attrib, myRequiredKeys)
                        self.systemConcept.DOFHRef += 1
                    else:
                        raise ValueError(f"The XML tag '{myChild.tag}' in the TransformationResource Layer is invalid!")
                except ValueError as e: logger.error(f"Fail! {e} Abort! Abort!"); sys.exit(1)
            # Try Block:  checking all transformation resources have at least one transformation process.
            try:
                if self.transformationResource.transformProcess[-1] == None:
                    raise ValueError(
                        f"Error! Transformation resource '{self.transformationResource.transformationResourceName[-1]}' "
                        "does not have any transformation processes!"
                    )
            except ValueError as e: logger.error(f"{e} Abort! Abort!"); sys.exit(1)
            if self.transformationResource.transportProcess[-1] == None:
                logger.info("Warning!  Transformation resource ", self.transformationResource.transformationResourceName[-1],
                      " does not have any transportation processes! Proceeding cautiously...")
        elif 'sysml' in inputDataFormat:
            if isinstance(self.transformationResource,dict):
                try:
                    if 'action' not in self.transformationResource:
                        raise KeyError(f"Fail! No transformation resources have any actions/processes! Revise input SysML file accordingly!")
                except KeyError as e: logger.error(f"{e} Abort! Abort!"); sys.exit(1)
                # Translate actions into Transformation & Transportation Processes and delete
                self.transformationResource['transformProcess'] = [None] * len(self.transformationResource['action'])
                self.transformationResource['transportProcess'] = [None] * len(self.transformationResource['action'])
                for k in range(len(self.transformationResource['action'])):
                    tempDict = self.transformationResource['action'][k]
                    # Calculate the Transformation Processes
                    tempList = pd.DataFrame(tempDict).to_dict(orient='records')
                    tempList = cleanNonesFromListofDicts([x for x in tempList if x['myClass'] == 'TransformProcess'])
                    if tempList:
                        self.transformationResource['transformProcess'][k] = transposeListOfDicts(tempList)
                    else: self.transformationResource['transportProcess'][k] = None
                    # Calculate the Transportation Processes
                    tempList = pd.DataFrame(tempDict).to_dict(orient='records')
                    tempList = cleanNonesFromListofDicts([x for x in tempList if x['myClass'] == 'TransportProcess'])
                    if tempList:
                        self.transformationResource['transportProcess'][k] = transposeListOfDicts(tempList)
                    else: self.transformationResource['transportProcess'][k] = None
                # Translate Dictionary into Objects
                self.transformationResource = objectify(self.transformationResource)
                # # Reformat varDomain (Buffer) data
                # self.transformationResource.varDomain = [[x] for x in self.transformationResource.varDomain]
                # Fill Empty Transformation Resource Keys and delete unnecessary keys
                myDictKeys = [k for k, v in vars(self.transformationResource).items() if isinstance(v, list) and v]
                self.transformationResource.fillAttributesWithNones(myDictKeys)
                delattr(self.transformationResource, 'action')
                delattr(self.transformationResource, 'myName')

                for k in range(len(self.transformationResource.transformProcess)):
                    if isinstance(self.transformationResource.transformProcess[k], TransformProcess):
                        # self.transformationResource.transformProcess[k].varDomain = [[x] for x in self.transformationResource.transformProcess[k].varDomain]
                        myDictKeys = [k for k, v in vars(self.transformationResource.transformProcess[k]).items() if isinstance(v, list) and v]
                        self.transformationResource.transformProcess[k].fillAttributesWithNones(myDictKeys)
                        self.systemConcept.DOFM += len(self.transformationResource.transformProcess[k].name)
                        delattr(self.transformationResource.transformProcess[k], 'myName')
                    if isinstance(self.transformationResource.transportProcess[k], TransportProcess):
                        # self.transformationResource.transportProcess[k].varDomain = [[x] for x in self.transformationResource.transportProcess[k].varDomain]
                        myDictKeys = [k for k, v in vars(self.transformationResource.transportProcess[k]).items() if isinstance(v, list) and v]
                        self.transformationResource.transportProcess[k].fillAttributesWithNones(myDictKeys)
                        self.systemConcept.DOFHRef += len(self.transformationResource.transportProcess[k].name)
                        delattr(self.transformationResource.transportProcess[k], 'myName')
                        self.transformationResource.transportProcess[k].ref = self.transformationResource.transportProcess[k].refinement
                        delattr(self.transformationResource.transportProcess[k], 'refinement')
            else: pass # --> This condition only happens if there are no transformation resources.
    @log_entry_exit_trace
    def setupIndependentBuffers(self, myRoot=None):
        """
        This method sets up the independent buffers in the myLFES object as part of the populateXMLData() method.
        
        Upon completion, this LFES will be an instantiated Large Flexible Engineering System object ready
        to compute HFGT mathematical models
            
        Args:
            myRoot: An element tree object that contains the input XML file data.
        """
        if 'defaultXML' in inputDataFormat:
            myRequiredKeys = getattr(self.independentBuffer.requiredKeys, analysisMethod)
            self.independentBuffer.appendInputDataAttributes(myRoot.attrib,myRequiredKeys)
            for myChild in myRoot:
                # Try Block:  checking for level 2 XML element names.
                try:
                    if myChild.tag == 'TransportationProcess':
                        if self.independentBuffer.transportProcess[-1] is None:
                            self.independentBuffer.transportProcess[-1] = TransportProcess()
                        myRequiredKeys = getattr(self.independentBuffer.transportProcess[-1].requiredKeys, analysisMethod)
                        self.independentBuffer.transportProcess[-1].appendInputDataAttributes(myChild.attrib, myRequiredKeys)
                        self.systemConcept.DOFHRef += 1
                    else:
                        raise ValueError(f"The XML tag '{myChild.tag}' in the Independent Buffer Layer is invalid!")
                except ValueError as e: logger.error(f"Fail! {e} Abort! Abort!"); sys.exit(1)
            if self.independentBuffer.transportProcess[-1] == None:
                logger.warning("Warning!  Independent buffer ", self.independentBuffer.name[-1],
                      " does not have any transportations processes! Proceeding cautiously...")
        elif 'sysml' in inputDataFormat:
            if isinstance(self.independentBuffer, dict):
                # Translate actions into Transportation Processes and delete
                if 'action' in self.independentBuffer:
                    self.independentBuffer['transportProcess'] = copy.deepcopy(self.independentBuffer['action'])
                    del self.independentBuffer['action']
                # Translate Dictionary into Objects
                self.independentBuffer = objectify(self.independentBuffer)
                # # Reformat varDomain (Buffer) data
                # self.independentBuffer.varDomain = [[x] for x in self.independentBuffer.varDomain]
                # Fill Empty Independent Buffer Keys and delete unnecessary keys
                myDictKeys = [k for k, v in vars(self.independentBuffer).items() if isinstance(v, list) and v]
                self.independentBuffer.fillAttributesWithNones(myDictKeys)
                delattr(self.independentBuffer, 'myName')
                # Loop over independent buffers to fix their transportation processes
                for k in range(len(self.independentBuffer.transportProcess)):       #Looping over transportation resources
                    if isinstance(self.independentBuffer.transportProcess[k], TransportProcess):
                        # self.independentBuffer.transportProcess[k].varDomain = [[x] for x in self.independentBuffer.transportProcess[k].varDomain]
                        myDictKeys = [k for k, v in vars(self.independentBuffer.transportProcess[k]).items() if isinstance(v, list) and v]
                        self.independentBuffer.transportProcess[k].fillAttributesWithNones(myDictKeys)
                        self.systemConcept.DOFHRef += len(self.independentBuffer.transportProcess[k].name)
                        delattr(self.independentBuffer.transportProcess[k], 'myName')
                        self.independentBuffer.transportProcess[k].ref = self.independentBuffer.transportProcess[k].refinement
                        delattr(self.independentBuffer.transportProcess[k],'refinement')
            else: pass #--> This condition only happens if there are no independent buffers
        else: pass
    @log_entry_exit_trace
    def setupTransportationResources(self, myRoot=None):
        """
        This method sets up the transportation resources in the myLFES object as part of the populateXMLData() method.
        
        Upon completion, this LFES will be an instantiated Large Flexible Engineering System object ready
        to compute HFGT mathematical models.

        Args:
            myRoot: An element tree object that contains the input XML file data.
        """
        if 'defaultXML' in inputDataFormat:
            myRequiredKeys = getattr(self.transportationResource.requiredKeys, analysisMethod)
            self.transportationResource.appendInputDataAttributes(myRoot.attrib,myRequiredKeys)
            for myChild in myRoot:
                # Try Block:  check for level 2 XML element names.
                try:
                    if myChild.tag == 'TransportationProcess':
                        if self.transportationResource.transportProcess[-1] is None:
                            self.transportationResource.transportProcess[-1] = TransportProcess()
                        myRequiredKeys = getattr(self.transportationResource.transportProcess[-1].requiredKeys, analysisMethod)
                        self.transportationResource.transportProcess[-1].appendInputDataAttributes(myChild.attrib,myRequiredKeys)
                        self.systemConcept.DOFHRef += 1
                    else:
                        raise ValueError(f"The XML tag '{myChild.tag}' in the TransportationResource Layer is invalid!")
                except ValueError as e: logger.error(f"Fail! {e} Abort! Abort!"); sys.exit(1)
            if len(self.transportationResource.transportProcess[-1].name) == 0:
                logger.error("Error!  Transportation resource ", self.transportationResource.name[-1],
                      " does not have any transportations processes! Abort! Abort!")
                sys.exit(1)
        elif 'sysml' in inputDataFormat:
            if isinstance(self.transportationResource, dict):
                try:
                    if 'action' not in self.transportationResource:
                        raise KeyError(f"Fail! No transportation resources have any actions/processes! Revise input SysML file accordingly!")
                except KeyError as e: logger.error(f"{e} Abort! Abort!"); sys.exit(1)
                # Translate actions into Transportation Processes and delete
                self.transportationResource['transportProcess'] = copy.deepcopy(self.transportationResource['action'])
                del self.transportationResource['action']
                # Translate Dictionary into Objects
                self.transportationResource = objectify(self.transportationResource)
                # Fill Empty Transportation Resource Keys and delete unnecessary keys
                myDictKeys = [k for k, v in vars(self.transportationResource).items() if isinstance(v, list) and v]
                self.transportationResource.fillAttributesWithNones(myDictKeys)
                delattr(self.transportationResource, "myName")
                # Loop over transportation resources to fix their transportation processes
                for k in range(len(self.transportationResource.transportProcess)):
                    if isinstance(self.transportationResource.transportProcess[k], TransportProcess):
                        # self.transportationResource.transportProcess[k].varDomain = [[x] for x in self.transportationResource.transportProcess[k].varDomain]
                        myDictKeys = [k for k, v in vars(self.transportationResource.transportProcess[k]).items() if isinstance(v, list) and v]
                        self.transportationResource.transportProcess[k].fillAttributesWithNones(myDictKeys)
                        self.systemConcept.DOFHRef += len(self.transportationResource.transportProcess[k].name)
                        delattr(self.transportationResource.transportProcess[k],'myName')
                        self.transportationResource.transportProcess[k].ref = self.transportationResource.transportProcess[k].refinement
                        delattr(self.transportationResource.transportProcess[k],'refinement')
            else: pass #--> This condition only happens if there are no transportation resources
    # Functions for produceFinalLFES()~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @log_entry_exit_trace
    def getConfigAnalysisMethod(self):
        configAnalysisMethod = GenericClass()
        myKeys = [x for x in self.requiredKeys.HFNMCF if "Buffer" in x or "Process" in x]
        for myKey in myKeys: setattr(configAnalysisMethod, myKey, getattr(self, myKey))
        configAnalysisMethod.numTransformationResources = len(self.transformationResource.transformationResourceName)
        configAnalysisMethod.numBuffers = configAnalysisMethod.numTransformationResources + len(self.independentBuffer.independentBufferName)
        return configAnalysisMethod
    @log_entry_exit_trace
    def joinResources(self,opt):
        """
        This method sets up, and collates the buffers in the myLFES object as part of the produceFinalLFES() method.
        
        Upon completion, this LFES will be an instantiated Large Flexible Engineering System object ready
        to compute HFGT mathematical models.

        Args:
            opt: An array of options.
        """
        if opt == 'Buffers':
            self.buffer.number = self.transformationResource.number + self.independentBuffer.number
            self.buffer.idx = list(range(self.buffer.number))
            self.buffer.idxBuffer = self.buffer.idx
            self.buffer.idxResource = self.buffer.idx
            setattr(self.buffer.requiredKeys,analysisMethod,
                    getattr(self.transformationResource.requiredKeys,analysisMethod) |
                    getattr(self.independentBuffer.requiredKeys,analysisMethod))
            safeKeys = {'number','idx','idxBuffer','idxResource','requiredKeys','validator'}
            myKeys = set(vars(self.buffer).keys())
            myKeys = myKeys - safeKeys
            objA = self.transformationResource
            objB = self.independentBuffer
        elif opt == 'PhysicalResources':
            self.physicalResource.number = self.buffer.number + self.transportationResource.number
            self.physicalResource.idx = list(range(self.physicalResource.number))
            self.physicalResource.idxResource = self.physicalResource.idx
            safeKeys = {'number','idx','idxBuffer','idxResource','requiredKeys','validator'}
            myKeys = set(vars(self.physicalResource).keys())
            myKeys = myKeys - safeKeys
            objA = self.buffer
            objB = self.transportationResource
        else: pass
        for myKey in myKeys:
            tempValue = getattr(objA,myKey) + getattr(objB, myKey)
            if opt == 'Buffers':
                setattr(self.buffer, myKey, tempValue)
            elif opt == 'PhysicalResources':
                setattr(self.physicalResource, myKey, tempValue)
            else: pass
    @log_entry_exit_trace
    def packSetSystemProcess(self):
        """
        This function computes the set of all possible REFINED transportation processes in the system.
        This set of processes includes storage at a certain buffer element and transportation from one buffer
        element to all other buffer elements present in the system.
        """
        # Pack Set of Transformation Processes
        operandLookUp = {s: i for s, i in zip(self.operand.operandName, self.operand.idx)}
        operandLookUp[''] = ''
        if self.systemConcept.DOFM > 0:
            if self.analysisMethod.value == 'timedEvents':
                self.timeKeeper.value = [float(x) for x in self.transformProcess.timeStamp]
            self.transformProcess.packProcessSet(self.operand.operandName)
            for k in range(self.transformationResource.number):
                if self.transformationResource.transformProcess[k] != None:
                    self.transformationResource.transformProcess[k].backPopulateTransformProcess(self.transformProcess,operandLookUp)
        else:
            logger.warning("Warning!  This LFES has no transformation capabilities!  It is a closed transportation system! Proceeding cautiously ...")
            self.transformProcess = TransformProcess()
            self.transformProcess.number = 0
            self.transformProcess.numberMax = 0
            self.transformProcess.MLPNeg = coo_array((self.operand.number, self.transformProcess.number), dtype=float)
            self.transformProcess.MLPPos = coo_array((self.operand.number, self.transformProcess.number), dtype=float)

        if self.systemConcept.DOFHRef > 0:
            # Pack Set of Holding Processes
            self.holdingProcess.populateHoldingProcess(self.transportProcess)
            self.holdingProcess.packProcessSet(self.operand.operandName)
            # Pack Set of REFINED Transportation Processes
            self.transportProcess.populateTransportProcess(self.buffer, self.holdingProcess)
            if self.analysisMethod.value == 'timedEvents':
                self.timeKeeper.value = self.timeKeeper.value + [float(x) for x in self.transportProcess.timeStamp]
            self.transportProcess.packSetTransportProcess(self.holdingProcess)
            self.transportProcess.idxProcess = [self.transformProcess.number + x for x in self.transportProcess.idx]
            for k in range(self.transformationResource.number):
                if self.transformationResource.transportProcess[k] != None:
                    self.transformationResource.transportProcess[k].backPopulateTransportProcess(self.transportProcess,operandLookUp)
            for k in range(self.independentBuffer.number):
                if self.independentBuffer.transportProcess[k] != None:
                    self.independentBuffer.transportProcess[k].backPopulateTransportProcess(self.transportProcess,operandLookUp)
            for k in range(self.transportationResource.number):
                if self.transportationResource.transportProcess[k] != None:
                    self.transportationResource.transportProcess[k].backPopulateTransportProcess(self.transportProcess,operandLookUp)
        else:
            logger.warning("Warning! This LFES has no transportation capabilities!  Nothing stored! Nothing transported!  Proceed cautiously...")
            self.holdingProcess = HoldingProcess()
            self.holdingProcess.number = 0
            self.transportProcess = TransportProcess()
            self.transportProcess.idx = self.transportProcess.idx
            self.transportProcess.numberMax = self.buffer.number ** 2
            self.transportProcess.numberRefMax = self.transportProcess.numberMax * self.holdingProcess.number
            self.transportProcess.numberRef = 0
            self.transportProcess.numberRefMax = 0
            self.transportProcess.MLPNeg = coo_array((self.operand.number, self.transportProcess.numberRefMax), dtype=float)
            self.transportProcess.MLPPos = coo_array((self.operand.number, self.transportProcess.numberRefMax), dtype=float)
        # Pack Set of System Processes
        self.systemProcess.MLPNeg = bmat([[self.transformProcess.MLPNeg, self.transportProcess.MLPNeg]])
        self.systemProcess.MLPPos = bmat([[self.transformProcess.MLPPos, self.transportProcess.MLPPos]])
        self.systemProcess.number = self.transformProcess.number + self.transportProcess.numberRef
        self.systemProcess.numberMax = self.transformProcess.number + self.transportProcess.numberRefMax

        myKeys = set(vars(self.systemProcess).keys())
        safeKeys = {"MLPNeg","MLPPos","number","numberMax","requiredKeys","validator"}
        myKeys = myKeys - safeKeys
        for myKey in myKeys:
            tempValue = getattr(self.transformProcess,myKey) + getattr(self.transportProcess, myKey)
            setattr(self.systemProcess, myKey, tempValue)
        self.systemProcess.idx = self.systemProcess.idxProcess
    @log_entry_exit_trace
    def calcSystemConcept(self):
        """
        This function calculates System Knowledge base JS, System Constraints Matrix KS, and System Concept AS.
        """
        # Initialize Knowledge Bases, Constraint, and System Concept Matrices: JM, JH, JHref, KM, KH, KHref, AM, AH, AHref
        self.initializeSystemConceptMatrices()
        # Calculate Transformation Knowledge Bases: JM, KM, AM
        self.calcTransformationSystemConcept()
        # Calculate Transportation Knowledge Bases: JH, KH, AH
        self.calcTransportationSystemConcept()
        # Calculate System Knowledge Base Sequence Independent DOF Measures Updates: DOFM, DOFH, DOFHref
        self.stackSystemConcepts()
        # Calculate Engineering System Net Firing Vectors
        self.calcEngSysNetFiringVectors()
        # Calculate the System Projection Operator
        self.systemConcept.calcProjectionOperator(self.analysisMethod)
        # Project Engineering System Net Firing Vectors
        self.projectEngSysNetFiringVectors()
        # Initialize Knowledge Bases and Constraint Tensors Updates: JHT, JHrefT, KHT, KHrefT, AHT, AHrefT
        self.initializeSystemConceptTensors()
        # Calculate Transportation Knowledge Bases Tensors: JHT, KHT, AHT
        self.calcTransportationSystemConceptTensors()
        # Calculate the Process-Capability Incidence Matrix
        self.systemConcept.calcProcessCapabilityIncidence(self.systemProcess.numberMax)
        # Calaculate the Resource-Capability Incidence Matrix
        self.systemConcept.calcResourceCapabilityIncidence(self.physicalResource.number)
        # Pack Set of Capabilities
        self.packSetCapability()
    @log_entry_exit_trace
    def calcEngSysNetFiringVectors(self):
        """
        This function calculates the Engineering System Net Firiving vectors from the system concept myLFES.AS.
        """
        if self.analysisMethod.value == 'timedEvents':
            self.engSysNet.Uneg = matricize(self.systemConcept.AS, [0, 1], [2])
            self.engSysNet.Upos = self.engSysNet.Uneg       # Assume instantaneous, zero-duration, events
            self.engSysNet.UFull = self.engSysNet.Uneg      # Assume instantaneous, zero-duration, events

            # All the knowledge bases, constraint matrices, and system concepts need to be collapsed into their
            # natural two-dimensional form for all the downstream calculations.  The DOF calculations need to be
            # redone because there may exist more than one event-instance of each capability.
            self.systemConcept.JM = coo_array(np.max(COO(self.systemConcept.JM), axis=2).to_scipy_sparse())
            self.systemConcept.KM = coo_array(np.max(COO(self.systemConcept.KM), axis=2).to_scipy_sparse())
            self.systemConcept.AM = coo_array(np.max(COO(self.systemConcept.AM), axis=2).to_scipy_sparse())
            self.systemConcept.DOFM = self.systemConcept.AM.nnz

            self.systemConcept.JG = coo_array(np.max(COO(self.systemConcept.JG), axis=2).to_scipy_sparse())
            self.systemConcept.KG = coo_array(np.max(COO(self.systemConcept.KG), axis=2).to_scipy_sparse())
            self.systemConcept.AG = coo_array(np.max(COO(self.systemConcept.AG), axis=2).to_scipy_sparse())
            self.systemConcept.DOFG = self.systemConcept.AG.nnz

            self.systemConcept.JH = coo_array(np.max(COO(self.systemConcept.JH), axis=2).to_scipy_sparse())
            self.systemConcept.KH = coo_array(np.max(COO(self.systemConcept.KH), axis=2).to_scipy_sparse())
            self.systemConcept.AH = coo_array(np.max(COO(self.systemConcept.AH), axis=2).to_scipy_sparse())
            self.systemConcept.DOFH = self.systemConcept.AH.nnz

            self.systemConcept.JHRef = coo_array(np.max(COO(self.systemConcept.JHRef), axis=2).to_scipy_sparse())
            self.systemConcept.KHRef = coo_array(np.max(COO(self.systemConcept.KHRef), axis=2).to_scipy_sparse())
            self.systemConcept.AHRef = coo_array(np.max(COO(self.systemConcept.AHRef), axis=2).to_scipy_sparse())
            self.systemConcept.DOFHRef = self.systemConcept.AHRef.nnz
            # It may be necessary to sort all of the above matrices all over again. For now, just sorting the critical ones...

            self.systemConcept.JS = sortSparseMatrix(coo_array(np.max(COO(self.systemConcept.JS), axis=2).to_scipy_sparse()))
            self.systemConcept.KS = sortSparseMatrix(coo_array(np.max(COO(self.systemConcept.KS), axis=2).to_scipy_sparse()))
            self.systemConcept.AS = sortSparseMatrix(coo_array(np.max(COO(self.systemConcept.AS), axis=2).to_scipy_sparse()))

            self.systemConcept.DOFS = self.systemConcept.AS.nnz
        else: pass
    @log_entry_exit_trace
    def projectEngSysNetFiringVectors(self):
        """
        This function projects the Engineering System Net Firiving vectors from the system concept myLFES.AS.
        """
        if self.analysisMethod.value == 'timedEvents':
            self.engSysNet.Uneg = projectMatrix(self.systemConcept.PS, self.engSysNet.Uneg)
            self.engSysNet.Upos = self.engSysNet.Uneg  # Assume instantaneous, zero-duration, events
            self.engSysNet.UFull = self.engSysNet.Uneg  # Assume instantaneous, zero-duration, events
        else:
            pass
    @log_entry_exit_trace
    def initializeSystemConceptMatrices(self):
        """
        This function initializes the knowledge bases and constraints matrices to empty
        sparse matrices of type COO (coordinate) format.
        """
        if self.analysisMethod.value == 'timedEvents':
            self.systemConcept.JM = DOK(shape=(self.transformProcess.number, self.transformationResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.KM = DOK(shape=(self.transformProcess.number, self.transformationResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.AM = DOK(shape=(self.transformProcess.number, self.transformationResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.JG = DOK(shape=(self.holdingProcess.number, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.KG = DOK(shape=(self.holdingProcess.number, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.AG = DOK(shape=(self.holdingProcess.number, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.JH = DOK(shape=(self.transportProcess.numberMax, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.KH = DOK(shape=(self.transportProcess.numberMax, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.AH = DOK(shape=(self.transportProcess.numberMax, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.JHRef = DOK(shape=(self.transportProcess.numberRefMax, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.KHRef = DOK(shape=(self.transportProcess.numberRefMax, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.AHRef = DOK(shape=(self.transportProcess.numberRefMax, self.physicalResource.number, self.timeKeeper.numEvents), dtype=int)
        else:
            self.systemConcept.JM = coo_array((self.transformProcess.number, self.transformationResource.number), dtype=int)
            self.systemConcept.KM = coo_array((self.transformProcess.number, self.transformationResource.number), dtype=int)
            self.systemConcept.AM = coo_array((self.transformProcess.number, self.transformationResource.number), dtype=int)
            self.systemConcept.JG = coo_array((self.holdingProcess.number, self.physicalResource.number), dtype=int)
            self.systemConcept.KG = coo_array((self.holdingProcess.number, self.physicalResource.number), dtype=int)
            self.systemConcept.AG = coo_array((self.holdingProcess.number, self.physicalResource.number), dtype=int)
            self.systemConcept.JH = coo_array((self.transportProcess.numberMax, self.physicalResource.number), dtype=int)
            self.systemConcept.KH = coo_array((self.transportProcess.numberMax, self.physicalResource.number), dtype=int)
            self.systemConcept.AH = coo_array((self.transportProcess.numberMax, self.physicalResource.number), dtype=int)
            self.systemConcept.JHRef = coo_array((self.transportProcess.numberRefMax, self.physicalResource.number), dtype=int)
            self.systemConcept.KHRef = coo_array((self.transportProcess.numberRefMax, self.physicalResource.number), dtype=int)
            self.systemConcept.AHRef = coo_array((self.transportProcess.numberRefMax, self.physicalResource.number), dtype=int)
    @log_entry_exit_trace
    def initializeSystemConceptTensors(self):
        """
        This function initializes the knowledge bases and constraints tensors to
        sparse tensors of type COO.
        """
        self.systemConcept.JHT = COO(DOK(shape=(self.buffer.number, self.buffer.number, self.physicalResource.number), dtype=int))
        self.systemConcept.AHT = COO(DOK(shape=(self.buffer.number, self.buffer.number, self.physicalResource.number), dtype=int))
        self.systemConcept.KHT = COO(DOK(shape=(self.buffer.number, self.buffer.number, self.physicalResource.number), dtype=int))
        self.systemConcept.JHRefT = COO(DOK(shape=(self.holdingProcess.number, self.buffer.number, self.buffer.number, self.physicalResource.number), dtype=int))
        self.systemConcept.AHRefT = COO(DOK(shape=(self.holdingProcess.number, self.buffer.number, self.buffer.number, self.physicalResource.number), dtype=int))
        self.systemConcept.KHRefT = COO(DOK(shape=(self.holdingProcess.number, self.buffer.number, self.buffer.number, self.physicalResource.number), dtype=int))
    @log_entry_exit_trace
    def calcTransformationSystemConcept(self):
        """
        The function calculates the Transformation Knowledge Base JM, Constraints Matrix KM,  and Transformation Concept AM.
        """
        if self.systemConcept.DOFM > 0:
            for k in range(self.transformationResource.number):
                if isinstance(self.transformationResource.transformProcess[k], TransformProcess):
                    self.transformationResource.transformProcess[k].populateTransformProcess(self.transformProcess)
            if self.analysisMethod.value == 'timedEvents':
                self.systemConcept.JM = appendProcessCapabilities(self.systemConcept.JM, self.transformationResource.transformProcess, 'JM-Timed',0,self.timeKeeper)
                self.systemConcept.KM = appendProcessCapabilities(self.systemConcept.KM, self.transformationResource.transformProcess, 'KM-Timed', 0, self.timeKeeper)
                self.systemConcept.AM = (self.systemConcept.JM - self.systemConcept.KM)
            else:
                self.systemConcept.JM = appendProcessCapabilities(self.systemConcept.JM, self.transformationResource.transformProcess, 'JM',0)
                self.systemConcept.KM = appendProcessCapabilities(self.systemConcept.KM, self.transformationResource.transformProcess, 'KM',0)
                self.systemConcept.AM = (self.systemConcept.JM - self.systemConcept.KM).tocoo()

            self.systemConcept.JM = sortSparseMatrix(self.systemConcept.JM)
            self.systemConcept.KM = sortSparseMatrix(self.systemConcept.KM)
            self.systemConcept.AM = sortSparseMatrix(self.systemConcept.AM)
            self.systemConcept.DOFM = self.systemConcept.AM.nnz
    @log_entry_exit_trace
    def calcTransportationSystemConcept(self):
        """
        This function calculates Transportation Knowledge Base JH, Constraints Matrix KH,
        and Transportation Concept AH.
        """
        if self.systemConcept.DOFHRef > 0:
            for k in range(self.transformationResource.number):
                if isinstance(self.transformationResource.transportProcess[k], TransportProcess):
                    self.transformationResource.transportProcess[k].populateTransportProcess(self.buffer, self.holdingProcess)
            for k in range(self.independentBuffer.number):
                if isinstance(self.independentBuffer.transportProcess[k], TransportProcess):
                    self.independentBuffer.transportProcess[k].populateTransportProcess(self.buffer,self.holdingProcess)
            for k in range(self.transportationResource.number):
                if isinstance(self.transportationResource.transportProcess[k], TransportProcess):
                    self.transportationResource.transportProcess[k].populateTransportProcess(self.buffer,self.holdingProcess)

            if self.analysisMethod.value == 'timedEvents':
                self.systemConcept.JG = appendProcessCapabilities(self.systemConcept.JG, self.transformationResource.transportProcess, 'JG-Timed',0, self.timeKeeper)
                self.systemConcept.KG = appendProcessCapabilities(self.systemConcept.KG, self.transformationResource.transportProcess, 'KG-Timed',0, self.timeKeeper)
                self.systemConcept.JH = appendProcessCapabilities(self.systemConcept.JH, self.transformationResource.transportProcess, 'JH-Timed',0, self.timeKeeper)
                self.systemConcept.KH = appendProcessCapabilities(self.systemConcept.KH, self.transformationResource.transportProcess, 'KH-Timed',0, self.timeKeeper)
                self.systemConcept.JHRef = appendProcessCapabilities(self.systemConcept.JHRef, self.transformationResource.transportProcess, 'JR-Timed',0, self.timeKeeper)
                self.systemConcept.KHRef = appendProcessCapabilities(self.systemConcept.KHRef, self.transformationResource.transportProcess, 'KR-Timed',0, self.timeKeeper)

                self.systemConcept.JG = appendProcessCapabilities(self.systemConcept.JG, self.independentBuffer.transportProcess, 'JG-Timed',self.transformationResource.number, self.timeKeeper)
                self.systemConcept.KG = appendProcessCapabilities(self.systemConcept.KG, self.independentBuffer.transportProcess, 'KG-Timed',self.transformationResource.number, self.timeKeeper)
                self.systemConcept.JH = appendProcessCapabilities(self.systemConcept.JH, self.independentBuffer.transportProcess, 'JH-Timed',self.transformationResource.number, self.timeKeeper)
                self.systemConcept.KH = appendProcessCapabilities(self.systemConcept.KH, self.independentBuffer.transportProcess, 'KH-Timed',self.transformationResource.number, self.timeKeeper)
                self.systemConcept.JHRef = appendProcessCapabilities(self.systemConcept.JHRef, self.independentBuffer.transportProcess, 'JR-Timed',self.transformationResource.number, self.timeKeeper)
                self.systemConcept.KHRef = appendProcessCapabilities(self.systemConcept.KHRef, self.independentBuffer.transportProcess, 'KR',self.transformationResource.number, self.timeKeeper)

                self.systemConcept.JG = appendProcessCapabilities(self.systemConcept.JG, self.transportationResource.transportProcess, 'JG-Timed',self.buffer.number, self.timeKeeper)
                self.systemConcept.KG = appendProcessCapabilities(self.systemConcept.KG, self.transportationResource.transportProcess, 'KG-Timed',self.buffer.number, self.timeKeeper)
                self.systemConcept.JH = appendProcessCapabilities(self.systemConcept.JH, self.transportationResource.transportProcess, 'JH-Timed',self.buffer.number, self.timeKeeper)
                self.systemConcept.KH = appendProcessCapabilities(self.systemConcept.KH, self.transportationResource.transportProcess, 'KH-Timed',self.buffer.number, self.timeKeeper)
                self.systemConcept.JHRef = appendProcessCapabilities(self.systemConcept.JHRef, self.transportationResource.transportProcess, 'JR-Timed',self.buffer.number, self.timeKeeper)
                self.systemConcept.KHRef = appendProcessCapabilities(self.systemConcept.KHRef, self.transportationResource.transportProcess, 'KR-Timed',self.buffer.number, self.timeKeeper)

                self.systemConcept.AG = (self.systemConcept.JG - self.systemConcept.KG)
                self.systemConcept.AH = (self.systemConcept.JH - self.systemConcept.KH)
                self.systemConcept.AHRef = (self.systemConcept.JHRef - self.systemConcept.KHRef)
            else:
                self.systemConcept.JG = appendProcessCapabilities(self.systemConcept.JG, self.transformationResource.transportProcess, 'JG',0)
                self.systemConcept.KG = appendProcessCapabilities(self.systemConcept.KG, self.transformationResource.transportProcess, 'KG',0)
                self.systemConcept.JH = appendProcessCapabilities(self.systemConcept.JH, self.transformationResource.transportProcess, 'JH',0)
                self.systemConcept.KH = appendProcessCapabilities(self.systemConcept.KH, self.transformationResource.transportProcess, 'KH',0)
                self.systemConcept.JHRef = appendProcessCapabilities(self.systemConcept.JHRef, self.transformationResource.transportProcess, 'JR',0)
                self.systemConcept.KHRef = appendProcessCapabilities(self.systemConcept.KHRef, self.transformationResource.transportProcess, 'KR',0)

                self.systemConcept.JG = appendProcessCapabilities(self.systemConcept.JG, self.independentBuffer.transportProcess, 'JG',self.transformationResource.number)
                self.systemConcept.KG = appendProcessCapabilities(self.systemConcept.KG, self.independentBuffer.transportProcess, 'KG',self.transformationResource.number)
                self.systemConcept.JH = appendProcessCapabilities(self.systemConcept.JH, self.independentBuffer.transportProcess, 'JH',self.transformationResource.number)
                self.systemConcept.KH = appendProcessCapabilities(self.systemConcept.KH, self.independentBuffer.transportProcess, 'KH',self.transformationResource.number)
                self.systemConcept.JHRef = appendProcessCapabilities(self.systemConcept.JHRef, self.independentBuffer.transportProcess, 'JR',self.transformationResource.number)
                self.systemConcept.KHRef = appendProcessCapabilities(self.systemConcept.KHRef, self.independentBuffer.transportProcess, 'KR',self.transformationResource.number)

                self.systemConcept.JG = appendProcessCapabilities(self.systemConcept.JG, self.transportationResource.transportProcess, 'JG',self.buffer.number)
                self.systemConcept.KG = appendProcessCapabilities(self.systemConcept.KG, self.transportationResource.transportProcess, 'KG',self.buffer.number)
                self.systemConcept.JH = appendProcessCapabilities(self.systemConcept.JH, self.transportationResource.transportProcess, 'JH',self.buffer.number)
                self.systemConcept.KH = appendProcessCapabilities(self.systemConcept.KH, self.transportationResource.transportProcess, 'KH',self.buffer.number)
                self.systemConcept.JHRef = appendProcessCapabilities(self.systemConcept.JHRef, self.transportationResource.transportProcess, 'JR',self.buffer.number)
                self.systemConcept.KHRef = appendProcessCapabilities(self.systemConcept.KHRef, self.transportationResource.transportProcess, 'KR',self.buffer.number)

                self.systemConcept.AG = (self.systemConcept.JG - self.systemConcept.KG).tocoo()
                self.systemConcept.AH = (self.systemConcept.JH - self.systemConcept.KH).tocoo()
                self.systemConcept.AHRef = (self.systemConcept.JHRef - self.systemConcept.KHRef).tocoo()

            self.systemConcept.JG = sortSparseMatrix(self.systemConcept.JG)
            self.systemConcept.KG = sortSparseMatrix(self.systemConcept.KG)
            self.systemConcept.AG = sortSparseMatrix(self.systemConcept.AG)

            self.systemConcept.JH = sortSparseMatrix(self.systemConcept.JH)
            self.systemConcept.KH = sortSparseMatrix(self.systemConcept.KH)
            self.systemConcept.AH = sortSparseMatrix(self.systemConcept.AH)

            self.systemConcept.JHRef = sortSparseMatrix(self.systemConcept.JHRef)
            self.systemConcept.KHRef = sortSparseMatrix(self.systemConcept.KHRef)
            self.systemConcept.AHRef = sortSparseMatrix(self.systemConcept.AHRef)

            self.systemConcept.DOFG = self.systemConcept.AG.nnz
            self.systemConcept.DOFH = self.systemConcept.AH.nnz
            self.systemConcept.DOFHRef = self.systemConcept.AHRef.nnz
    @log_entry_exit_trace
    def calcTransportationSystemConceptTensors(self):
        """
        This function calculates Transportation Knowledge Base, Constraints, and Concept Tensors.
        It also calculates the refined transportation knowledge base, constraints, and concept tensors.
        """
        self.systemConcept.JHT = sortSparseMatrix(tensorize(self.systemConcept.JH,[self.buffer.number, self.buffer.number, self.physicalResource.number], [1, 0], [2]))
        self.systemConcept.KHT = sortSparseMatrix(tensorize(self.systemConcept.KH,[self.buffer.number, self.buffer.number, self.physicalResource.number], [1, 0], [2]))
        self.systemConcept.AHT = sortSparseMatrix(self.systemConcept.JHT - self.systemConcept.KHT)

        self.systemConcept.JHRefT = sortSparseMatrix(tensorize(self.systemConcept.JHRef, [self.holdingProcess.number, self.buffer.number, self.buffer.number, self.physicalResource.number], [2, 1, 0], [3]))
        self.systemConcept.KHRefT = sortSparseMatrix(tensorize(self.systemConcept.KHRef, [self.holdingProcess.number, self.buffer.number, self.buffer.number, self.physicalResource.number], [2, 1, 0], [3]))
        self.systemConcept.AHRefT = sortSparseMatrix(self.systemConcept.JHRefT - self.systemConcept.KHRefT)

        temp = (COO.from_scipy_sparse(self.systemConcept.AH)).sum(1)
        self.systemConcept.ABS = sortSparseMatrix(ivecMat(temp, [self.buffer.number, self.buffer.number]))
        temp = (COO.from_scipy_sparse(self.systemConcept.AHRef)).sum(1)
        self.systemConcept.ALBS = sortSparseMatrix(ivecMat(temp, [self.buffer.number, self.buffer.number, self.holdingProcess.number]))
    @log_entry_exit_trace
    def stackSystemConcepts(self):
        """
        This function identifies all the system capabilities.
        """
        if self.analysisMethod.value == 'timedEvents':
            temp = DOK(shape=(self.transformProcess.number, self.independentBuffer.number + self.transportationResource.number, self.timeKeeper.numEvents), dtype=int)
            self.systemConcept.JS = DOK(concatenate([concatenate([self.systemConcept.JM, temp],axis=1),self.systemConcept.JHRef],axis=0))
            self.systemConcept.KS = DOK(concatenate([concatenate([self.systemConcept.KM, temp], axis=1), self.systemConcept.KHRef], axis=0))
            self.systemConcept.AS = DOK(concatenate([concatenate([self.systemConcept.AM, temp], axis=1), self.systemConcept.AHRef], axis=0))
        else:
            # csc_array is used here for computational efficiency in vstack.
            temp = csc_array((self.transformProcess.number, self.independentBuffer.number + self.transportationResource.number),dtype=int)
            self.systemConcept.JS = vstack([hstack([self.systemConcept.JM, temp]), self.systemConcept.JHRef], format='coo')
            self.systemConcept.KS = vstack([hstack([self.systemConcept.KM, temp]), self.systemConcept.KHRef], format='coo')
            self.systemConcept.AS = vstack([hstack([self.systemConcept.AM, temp]), self.systemConcept.AHRef], format='coo')

        self.systemConcept.JS = sortSparseMatrix(self.systemConcept.JS)
        self.systemConcept.KS = sortSparseMatrix(self.systemConcept.KS)
        self.systemConcept.AS = sortSparseMatrix(self.systemConcept.AS)
        self.systemConcept.DOFS = self.systemConcept.DOFM + self.systemConcept.DOFHRef
        if self.systemConcept.DOFS == 0:
            logger.warning('Warning!  This system has no capabilities! Proceeding cautiously ...')
        self.systemConcept.DOFMax = self.systemProcess.numberMax * self.physicalResource.number
    @log_entry_exit_trace
    def packSetCapability(self):
        """
        This function identifies all of the system capabilities.
        """
        self.systemConcept.idxPsiCapability = list(range(self.systemConcept.DOFS))
        # In this version of the HFGT toolbox, all sparse matrices still have int64 row and column indices.
        # So they must be converted back to lists of native Python int
        self.systemConcept.idxChiCapability = [int(x) for x in (vecMAT(self.systemConcept.AS)).row]         #Note: self.systemConcept.AS must be sorted!
        self.systemConcept.idxResource = [int(x) for x in self.systemConcept.AS.col]                        #Note: self.systemConcept.AS must be sorted!
        self.systemConcept.idxProcess = [int(x) for x in self.systemConcept.AS.row]                         #Note: self.systemConcept.AS must be sorted!

        #Initialize .idxOrigin and .idxDestination for numpy-based operations
        self.systemConcept.idxOrigin = np.array([0] * self.systemConcept.DOFS, dtype=object)
        self.systemConcept.idxDestination = np.array([0] * self.systemConcept.DOFS, dtype=object)

        # Transformation Capability:  Find the index of each, then calculate its origin and destination.  Nececessary for self.analytics.MRho calculations
        idx1 = np.array(self.systemConcept.idxProcess, dtype=object) < self.transformProcess.number
        self.systemConcept.idxOrigin[idx1] = np.array(self.systemConcept.idxResource, dtype=object)[idx1]
        self.systemConcept.idxDestination[idx1] = np.array(self.systemConcept.idxResource, dtype=object)[idx1]

        # Transportation Capability:  Find the index of each, then calculate its origin and destination.  Necessary for self.analytics.MRho calculations
        idx2 = calcIndexBinA(self.transportProcess.idxProcess, np.array(self.systemConcept.idxProcess, dtype=object)[~idx1])
        self.systemConcept.idxOrigin[~idx1] = np.array(self.transportProcess.idxOrigin, dtype=object)[idx2]
        self.systemConcept.idxDestination[~idx1] = np.array(self.transportProcess.idxDestination, dtype=object)[idx2]

        #Convert .idxOrigin and .idxDestination back to lists for native Python int.
        self.systemConcept.idxOrigin = self.systemConcept.idxOrigin.tolist()
        self.systemConcept.idxDestination = self.systemConcept.idxDestination.tolist()

        # Old Method!   Keeping for posterity for now.
        # This assumes that all capabilities with the same process have the same ratios of process inputs.  --> Correct in theory...but has practical limitations.
        # Consider refactoring so that this more like the attribute calculations being used for the engineering system net ...
        # Also reconsider the dot product with a filtering operation!
        # self.systemConcept.inputOperandWeight2  = self.systemProcess.MLPNeg.dot(self.systemConcept.PPS).tocsc()      #Don't touch! The CSC Matrix is needed for self.analytics.MRho calculations.
        # self.systemConcept.outputOperandWeight2 = self.systemProcess.MLPPos.dot(self.systemConcept.PPS).tocsc()      #Don't touch! The CSC Matrix is needed for self.analytics.MRho calculations.
        # self.systemConcept.idxInputOperand2  = (self.systemConcept.inputOperandWeight2  > 0)                          #Don't touch! The CSC Matrix is needed for self.analytics.MRho calculations.
        # self.systemConcept.idxOutputOperand2 = (self.systemConcept.outputOperandWeight2 > 0)                          #Don't touch! The CSC Matrix is needed for self.analytics.MRho calculations.

        # Initialize a temporary dictionary.
        tempDict = dict()
        myKeys = {'idxInputOperand','inputOperandWeight','idxOutputOperand','outputOperandWeight','idxResource','idxProcess'}
        for myKey in myKeys: tempDict[myKey] = []

        # Mine the process data attributes from all resources
        tempDict = mineProcessData(tempDict, self.transformationResource.transformProcess, self.transformationResource.idxResource)
        tempDict = mineProcessData(tempDict, self.transformationResource.transportProcess, self.transformationResource.idxResource)
        tempDict = mineProcessData(tempDict, self.independentBuffer.transportProcess, self.independentBuffer.idxResource)
        tempDict = mineProcessData(tempDict, self.transportationResource.transportProcess, self.transportationResource.idxResource)

        # Calculate the ChiCapability index
        tempDict['idxChiCapability'] = calcVectorizedIdx(tempDict['idxProcess'],tempDict['idxResource'],self.systemProcess.numberMax)

        # Calculate the indices of the correct sorted order
        # New Method needs to take into account that when self.analysisMethod.value == ``timedEvents", there may be
        # repeated values in tempDict['idxChiCapability'].  So argsort() needs to be generalized to unique()
        _, idx = np.unique(tempDict['idxChiCapability'], return_index=True)
        idx = idx.tolist()

        # Sort all the data using the correct sorted index
        # Note!  idxChi in increasing order is the same as idxPsi in increasing order!
        for myKey in tempDict.keys():
            tempDict[myKey]=(np.array(tempDict[myKey],dtype=object)[idx]).tolist()

        self.systemConcept.idxInputOperand = tempDict['idxInputOperand']
        self.systemConcept.idxOutputOperand = tempDict['idxOutputOperand']
        self.systemConcept.inputOperandWeight = tempDict['inputOperandWeight']
        self.systemConcept.outputOperandWeight = tempDict['outputOperandWeight']

        listResources = np.array(self.physicalResource.name)[self.systemConcept.idxResource]
        listProcesses = np.array(self.systemProcess.name)[calcIndexBinA(self.systemProcess.idx, self.systemConcept.idxProcess)]
        if self.systemConcept.DOFS > 0:
            self.systemConcept.name = (np.char.add(np.char.add(listResources, ' '), listProcesses)).tolist()
        else: self.systemConcept.name = []
        # Old Method -- Keep for posterity.
        # self.systemConcept.name = [self.physicalResource.name[self.systemConcept.AS.col[idxPsi]] + ' ' +
        #                         self.systemProcess.name[self.systemProcess.idx.index(self.systemConcept.AS.row[idxPsi])]
        #                         for idxPsi in range(self.systemConcept.DOFS)]
        if analysisMethod == ['SoSResilience']:
            self.systemConcept.nameSoS = self.systemConcept.name + ['LFES initiate SoSService', 'LFES finish SoSService']
        # These matrices are very dense and redundant.  Eliminating to streamline dictify().
        self.systemProcess.MLPNeg = []
        self.systemProcess.MLPPos = []
        self.transportProcess.MLPNeg = []
        self.transportProcess.MLPPos = []
    @log_entry_exit_trace
    def calcOperandNetFeasibility(self):
        """
        This function calculates the service feasibility matrix. It uses the DOFs to find
        the services performed by the DOFs.
        """
        for k in range(self.operand.number):
            logger.info('Starting Operand: ', self.operand.operandName[k], 'Operand Net: ', self.operand.operandNetName[k])
            if self.operand.pnTransitions[k] != None:
                # This line is included for backwards compatibility where the processLinkNames are included for transportation and storage processes
                tempListofStrings = ['' if s.startswith(('transport', 'store')) else s for s in self.operand.pnTransitions[k].processLinkName]
                self.operand.LambdaTransform[k] = calcIncidenceMatrix(tempListofStrings, self.transformProcess.name,'row', self.operand.pnTransitions[k].processLinkWeight)
                self.operand.LambdaHolding[k]   = calcIncidenceMatrix(self.operand.pnTransitions[k].processLinkRef,  self.holdingProcess.name, 'row',self.operand.pnTransitions[k].processLinkRefWeight)
                self.operand.LambdaTransport[k] = kron(self.operand.LambdaHolding[k], np.ones([1, self.transportProcess.numberMax]), 'coo')
                self.operand.Lambda[k] = (hstack([self.operand.LambdaTransform[k], self.operand.LambdaTransport[k]])).tocoo()
                self.operand.syncMat[k] = self.operand.Lambda[k].dot(self.systemConcept.PPS).tocoo()
            logger.info('Finished Operand: ', self.operand.operandName[k], 'Operand Net: ', self.operand.operandNetName[k])
        self.operand.ALrho = coo_array(vstack(self.operand.syncMat))
        if analysisMethod == 'SoSResilience':
            logger.info('Operand: {}', self.sosService.operandNetName)
            if self.sosService.pnTransitions != None:
                self.sosService.LambdaTransform = calcIncidenceMatrix(self.sosService.pnTransitions.processLinkName, self.transformProcess.name,'row')
                self.sosService.LambdaHolding   = calcIncidenceMatrix(self.sosService.pnTransitions.processLinkRef,  self.holdingProcess.name, 'row')
                self.sosService.LambdaTransport = kron(self.sosService.LambdaHolding, np.ones([1, self.transportProcess.numberMax]), 'coo')
                self.sosService.Lambda = (hstack([self.sosService.LambdaTransform, self.sosService.LambdaTransport])).tocoo()
                self.sosService.syncMat = self.sosService.Lambda.dot(self.systemConcept.PPS).tocoo()
            logger.info('Finished Operand Net', self.sosService.operandNetName)
    @log_entry_exit_trace
    def calcDecisionMakerAgencyMatrix(self):
        """
        This method calculates the Decision Maker Agency Matrix in the myLFES object as part of the produceFinalLFES() method.

        Upon completion, this LFES will be an instantiated Large Flexible Engineering System object ready to
        compute HFGT mathematical models.
        """
        myRows = self.physicalResource.decisionMaker
        myCols = self.decisionMaker.name
        if len(myCols) == 0:
            self.decisionMaker.A_RD = coo_array((len(myRows),len(myCols)), dtype=int)
            self.decisionMaker.ARhoD = coo_array((self.systemConcept.DOFS,len(myCols)), dtype=int)
        else:
            self.decisionMaker.A_RD = calcIncidenceMatrix(self.physicalResource.decisionMaker, self.decisionMaker.name,'row')
            # Calculate ADrho - System DecisionMaker Agency Matrix
            tempMat = tileSparseMatrix(self.decisionMaker.A_RD, self.systemProcess.numberMax,'col')
            self.decisionMaker.ARhoD = projectMatrix(self.systemConcept.PS, tempMat)
    @log_entry_exit_trace
    def calcHeterofunctionalIncidenceTensor(self):
        """
        This function calculates the positive and negative hetero-functional incidence tensors.
        """
        self.calcHeterofunctionalIncidenceTensorNeg()
        self.calcHeterofunctionalIncidenceTensorPos()
        self.analytics.MRho3 = self.analytics.MRho3Pos - self.analytics.MRho3Neg
        self.analytics.MPR4  = self.analytics.MPR4Pos - self.analytics.MPR4Neg
    @log_entry_exit_trace
    def calcHeterofunctionalIncidenceTensorNeg(self):
        """
        This function computes the projected and un-projected forms of the
        negative hetero-functional incidence tensor as well as the 4th order tensor.
        """
        self.analytics.MRho3Neg = DOK((self.operand.number, self.buffer.number, self.systemConcept.DOFS), dtype=float)
        self.analytics.MPR4Neg = DOK((self.operand.number, self.buffer.number, self.systemProcess.numberMax, self.physicalResource.number),dtype=float)
        idxL    = []; idxBS   = []; idxPsi  = []; idxVals = []

        # mySlice = csc_array((1, 1))
        for idx in self.systemConcept.idxPsiCapability:
            # Old Method:  inputOperandWeight was a csc matrix derived from MLP and did not admit different operand weight for each process.
            # mySlice = self.systemConcept.inputOperandWeight[:, [idx]]
            # idxL.extend(mySlice.indices.tolist())
            # idxBS.extend([self.systemConcept.idxOrigin[idx]] * mySlice.nnz)
            # idxPsi.extend([self.systemConcept.idxPsiCapability[idx]] * mySlice.nnz)
            # idxVals.extend(mySlice.data.tolist())

            # New Method:  inputOperandWeight is a list of lists and allows for different operand weight for each process.
            numArcs = len(self.systemConcept.inputOperandWeight[idx])
            idxL.extend(self.systemConcept.idxInputOperand[idx])
            idxBS.extend([self.systemConcept.idxOrigin[idx]] * numArcs)
            idxPsi.extend([self.systemConcept.idxPsiCapability[idx]] * numArcs)
            idxVals.extend(self.systemConcept.inputOperandWeight[idx])
        idxP, idxR, idxChi = resolvePsiCapabilityIndex(idxPsi, self.systemConcept)
        if len(idxVals) > 0:
            self.analytics.MPR4Neg[idxL, idxBS, idxP, idxR] = idxVals
            self.analytics.MRho3Neg[idxL, idxBS, idxPsi] = idxVals
        # Old Method:  No longer needed because the csc matrix is not used.
        # self.systemConcept.idxInputOperand.data = self.systemConcept.idxInputOperand.data.astype(int)
    @log_entry_exit_trace
    def calcHeterofunctionalIncidenceTensorPos(self):
        """
        This function computes the projected and un-projected forms of the
        negative hetero-functional incidence tensor as well as the 4th order tensor.
        """
        self.analytics.MRho3Pos = DOK((self.operand.number, self.buffer.number, self.systemConcept.DOFS), dtype=float)
        self.analytics.MPR4Pos  = DOK((self.operand.number, self.buffer.number, self.systemProcess.numberMax, self.physicalResource.number), dtype=float)
        idxL    = []; idxBS   = []; idxPsi  = []; idxVals = []
        # mySlice = csc_array((1, 1))
        for idx in self.systemConcept.idxPsiCapability:
            # Old Method:  outputOperandWeight was a csc matrix derived from MLP and did not admit different operand weight for each process.
            # mySlice = self.systemConcept.outputOperandWeight[:,[idx]]
            # idxL.extend(mySlice.indices.tolist())
            # idxBS.extend([self.systemConcept.idxDestination[idx]] * mySlice.nnz)
            # idxPsi.extend([self.systemConcept.idxPsiCapability[idx]] * mySlice.nnz)
            # idxVals.extend(mySlice.data.tolist())

            # New Method:  inputOperandWeight is a list of lists and allows for different operand weight for each process.
            numArcs = len(self.systemConcept.outputOperandWeight[idx])
            idxL.extend(self.systemConcept.idxOutputOperand[idx])
            idxBS.extend([self.systemConcept.idxDestination[idx]] * numArcs)
            idxPsi.extend([self.systemConcept.idxPsiCapability[idx]] * numArcs)
            idxVals.extend(self.systemConcept.outputOperandWeight[idx])
        idxP, idxR, idxChi = resolvePsiCapabilityIndex(idxPsi, self.systemConcept)
        if len(idxVals) > 0:
            self.analytics.MPR4Pos[idxL, idxBS, idxP, idxR] = idxVals
            self.analytics.MRho3Pos[idxL,idxBS,idxPsi] = idxVals
        # Old Method:  No longer needed because the csc matrix is not used.
        # self.systemConcept.idxOutputOperand.data = self.systemConcept.idxOutputOperand.data.astype(int)
    @log_entry_exit_trace
    def calcHeterofunctionalAdjacencyMatrix(self):
        """
        This function computes the projected and un-projected forms of the
        negative hetero-functional incidence tensor as well as the 4th order tensor.
        """
        self.analytics.ARho = (self.engSysNet.Mpos.T.dot(self.engSysNet.Mneg)).tocoo()
        self.analytics.APR = coo_array((self.systemConcept.DOFMax, self.systemConcept.DOFMax), dtype=float)
        self.analytics.APR.row = np.array(self.systemConcept.idxChiCapability, dtype=object)[self.analytics.ARho.row]
        self.analytics.APR.col = np.array(self.systemConcept.idxChiCapability, dtype=object)[self.analytics.ARho.col]
        self.analytics.APR.data = self.analytics.ARho.data

        self.analytics.APR4 = DOK((self.systemProcess.numberMax,self.physicalResource.number, self.systemProcess.numberMax,self.physicalResource.number), dtype=float)
        idxP1, idxR1, _ = resolvePsiCapabilityIndex(self.analytics.ARho.row, self.systemConcept)
        idxP2, idxR2, _ = resolvePsiCapabilityIndex(self.analytics.ARho.row, self.systemConcept)
        if len(self.analytics.APR.data) > 0:
            self.analytics.APR4[idxP1, idxR1, idxP2, idxR2] = self.analytics.APR.data
        self.analytics.AFormal = (self.engSysNet.Mneg.dot(self.engSysNet.Mpos.T)).tocoo()
        self.analytics.AFormalT = tensorize(self.analytics.AFormal,
                        [self.operand.number, self.buffer.number, self.operand.number,
                        self.buffer.number], [0,1], [2,3])
        if analysisMethod == 'SoSResilience':
            idxSource = np.flatnonzero(np.isin(np.array(self.operand.sosType),'source'))
            # Old Method for Calculating idxSource but it presumes that idxInputOperand is boolean MLPsi csc_array
            # idxSource1 = ((self.systemConcept.idxInputOperand2[idxSource,:]).sum(axis=0).astype(bool).astype(int))[np.newaxis]
            # New Method for Calculating idxSources takes a list-of-lists.
            idxSource = np.array([int(bool(set(x) & set(idxSource))) for x in self.systemConcept.idxInputOperand])[np.newaxis]

            idxMustProduce = np.flatnonzero(np.isin(np.array(self.operand.sosType),'must produce'))
            # Old Method for Calculating idxMustProduce but it presumes that idxOutputOperand is boolean MLPsi csc_array
            # idxMustProduce1 = (((self.systemConcept.idxOutputOperand2[idxMustProduce,:]).sum(axis=0).astype(bool).astype(int))[np.newaxis]).T
            idxMustProduce = np.array([int(bool(set(x) & set(idxMustProduce))) for x in self.systemConcept.idxOutputOperand])[np.newaxis].T

            self.analytics.ARhoSoS = bmat([[self.analytics.ARho, np.zeros((self.systemConcept.DOFS, 1)), idxMustProduce],
                         [idxSource, None, None],[np.zeros((1, self.systemConcept.DOFS)), None, None]])
    @log_entry_exit_trace
    def calcEngineeringSystemNet(self):
        """
        This function calculates the engineering system net
        """
        self.engSysNet.Mneg = matricize(COO(self.analytics.MRho3Neg), [1, 0], [2])
        self.engSysNet.Mpos = matricize(COO(self.analytics.MRho3Pos), [1, 0], [2])
        self.engSysNet.MFull = (self.engSysNet.Mpos - self.engSysNet.Mneg).tocoo()
        self.engSysNet.pnPlaces = EngSysNetPlace()
        self.engSysNet.pnTransitions = EngSysNetTransition()
        self.calcEngineeringSystemNetPlaces()
        self.calcEngineeringSystemNetTransitions()
    @log_entry_exit_trace
    def calcEngineeringSystemNetTransitions(self):
        # The transition names and indices are the same as those of those the capabilities.
        self.engSysNet.pnTransitions.name = self.systemConcept.name
        self.engSysNet.pnTransitions.idx = self.systemConcept.idxPsiCapability
        self.engSysNet.pnTransitions.number = len(self.engSysNet.pnTransitions.name)

        # Initialize a temporary dictionary.
        tempDict = dict()
        myKeys = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self.engSysNet.pnTransitions).keys()) -
                  {'name','idx','number','idxChiCapability','preset','postset'}}
        for myKey in myKeys: tempDict[myKey] = []

        # Mine the process data attributes from all resources
        tempDict = mineProcessData(tempDict, self.transformationResource.transformProcess, self.transformationResource.idxResource)
        tempDict = mineProcessData(tempDict, self.transformationResource.transportProcess, self.transformationResource.idxResource)
        tempDict = mineProcessData(tempDict, self.independentBuffer.transportProcess, self.independentBuffer.idxResource)
        tempDict = mineProcessData(tempDict, self.transportationResource.transportProcess, self.transportationResource.idxResource)

        # Calculate the ChiCapability index
        tempDict['idxChiCapability'] = calcVectorizedIdx(tempDict['idxProcess'],tempDict['idxResource'],self.systemProcess.numberMax)

        # Calculate the indices of the correct sorted order
        # Old Method1:  idx = calcIndexBinA(tempDict['idxChiCapability'],self.systemConcept.idxChiCapability)
        # Old Method2:  idx = np.argsort(tempDict['idxChiCapability']).tolist()
        # New Method needs to take into account that when self.analysisMethod.value == ``timedEvents", there may be
        # repeated values in tempDict['idxChiCapability'].  So argsort() needs to be generalized to unique()
        _, idx = np.unique(tempDict['idxChiCapability'], return_index=True)
        idx = idx.tolist()

        # Sort all the data using the correct sorted index
        # Note!  idxChi in increasing order is the same as idxPsi in increasing order!
        for myKey in tempDict.keys():
            tempDict[myKey]=(np.array(tempDict[myKey],dtype=object)[idx]).tolist()
        # Finally, insert all values from tempDict
        self.engSysNet.pnTransitions.insertAttributeDataFromDict(tempDict,'extend')
        self.engSysNet.pnTransitions.varDomain = vecMAT(self.engSysNet.pnTransitions.varDomain)
    @log_entry_exit_trace
    def calcEngineeringSystemNetPlaces(self):
        self.engSysNet.pnPlaces.name = [k1 + ' @ ' + k2 for k1 in self.operand.operandName for k2 in self.buffer.name]
        self.engSysNet.pnPlaces.operandType = [k1.value + ' @ ' + k2 for k1 in self.operand.operandType for k2 in self.buffer.name]
        self.engSysNet.pnPlaces.number = len(self.engSysNet.pnPlaces.name)
        self.engSysNet.pnPlaces.idx = list(range(self.engSysNet.pnPlaces.number))
        myKeys = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self.engSysNet.pnPlaces).keys()) -
                  {'name','operandType','idx','number'}}
        for myKey in myKeys:
            temp = getattr(self.buffer, myKey)
            if temp and isinstance(temp[0],np.ndarray):
                myShape = temp[0].shape
                setattr(self.engSysNet.pnPlaces, myKey, np.stack(temp, axis=2).reshape(myShape[0], -1).T.tolist())
            else:
                setattr(self.engSysNet.pnPlaces,myKey,vecMAT(temp))
    @log_entry_exit_trace
    def calcSystemAdjacencyMatrix(self):
        """
        This function calculates the system adjacency matrix
        """
        A1 = [self.operand.AL, self.operand.ALrho, None]
        A2 = [self.operand.ALrho.transpose(), self.analytics.ARho, self.decisionMaker.ARhoD]
        A3 = [None, self.decisionMaker.ARhoD.transpose(), self.decisionMaker.A_DD]
        self.analytics.ASys = bmat([A1, A2, A3])
    # Functions for exportFinalLFES()~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class SystemConcept(GenericClass):
    def __init__(self):
        self.name = []
        self.nameSoS = []
        self.idxPsiCapability = 0
        self.idxChiCapability = 0
        self.idxResource = 0
        self.idxProcess = 0
        self.idxInputOperand = 0
        self.inputOperandWeight = 0
        self.idxOutputOperand = 0
        self.outputOperandWeight = 0
        self.idxOrigin = 0
        self.idxDestination = 0
        self.DOFM = 0
        self.DOFHRef = 0
        self.DOFG = 0
        self.DOFH = 0
        self.DOFS = 0
        self.JM = 0
        self.KM = 0
        self.AM = 0
        self.JH = 0
        self.KH = 0
        self.AH = 0
        self.JG = 0
        self.KG = 0
        self.AG = 0
        self.JHRef = 0
        self.KHRef = 0
        self.AHRef = 0
        self.JS = 0
        self.KS = 0
        self.AS = 0
        self.JHT = 0
        self.KHT = 0
        self.AHT = 0
        self.JHRefT = 0
        self.KHRefT = 0
        self.AHRefT = 0
        self.PS = 0
        self.PPS = 0
        self.PRS = 0
    @log_entry_exit_trace
    def calcProjectionOperator(self,analysisMethod):
        self.PS = coo_array((self.DOFS, self.DOFMax), dtype=int)
        self.PS.col = (vecMAT(self.AS)).row                      # Note:  This presumes that self.AS is sorted!
        self.PS.row = range(len(self.PS.col))
        self.PS.data = np.repeat(1, len(self.PS.col))
    @log_entry_exit_trace
    def calcProcessCapabilityIncidence(self, numProcesses):
        self.PPS = coo_array((numProcesses, self.DOFS), dtype=int)
        self.PPS.row = self.AS.row                              # Note:  This presumes that self.AS is sorted!
        self.PPS.col = range(len(self.PPS.row))
        self.PPS.data = np.repeat(1, len(self.PPS.row))
    @log_entry_exit_trace
    def calcResourceCapabilityIncidence(self, numResources):
        self.PRS = coo_array((numResources, self.DOFS), dtype=int)
        self.PRS.row = self.AS.col                              # Note:  This presumes that self.AS is sorted!
        self.PRS.col = range(len(self.PRS.row))
        self.PRS.data = np.repeat(1, len(self.PRS.row))
class Analytics(GenericClass):
    def __init__(self):
        self.MPR4Neg = []
        self.MRho3Neg = []
        self.MRho2Neg = []
        self.MPR4Pos = []
        self.MRho3Pos = []
        self.MRho2Pos = []
        self.MPR4 = []
        self.MRho3 = []
        self.MRho2 = []

        self.ARho = []
        self.APR = []
        self.APR4 = []
        self.ARhoSoS = []
        self.AFormal = []
        self.AFormalT = []
        self.ASys = []
class PetriNet(GenericClass):
    def __init__(self):
        # Non-primitive data attributes for calculation
        self.MFull = []
        self.Mneg  = []
        self.Mpos  = []
        self.UFull = []
        self.Uneg  = []
        self.Upos  = []
        self.XS    = []
        self.XE    = []
        self.XF    = []
        self.pnPlaces = []
        self.pnTransitions = []
class PetriNetPlace(GenericClass):
    def __init__(self):
        self.name = []
        self.initCond = []
        self.finalCond = []
        self.upperBound = []
        self.lowerBound = []
        self.linearCostCoeff = []
        self.quadCostCoeff = []
        self.varDomain = []
        self.varDomainEnabled = []
        # Primitive data attributes for calculation
        self.idx = []
        self.number = []
class PetriNetTransition(GenericClass):
    def __init__(self):
        self.upperBoundFlowNeg = []
        self.upperBoundFlowPos = []
        self.upperBoundStock = []

        self.lowerBoundFlowNeg = []
        self.lowerBoundFlowPos = []
        self.lowerBoundStock = []

        self.upperBoundRamp = []
        self.lowerBoundRamp = []
        self.duration = []

        self.linearCostCoeffFlowNeg = []
        self.linearCostCoeffFlowPos = []
        self.linearCostCoeffStock = []

        self.quadCostCoeffFlowNeg = []
        self.quadCostCoeffFlowPos = []
        self.quadCostCoeffStock = []

        self.initCond = []
        self.finalCond = []
        self.varDomain = []
        self.name = []
        self.preset = []
        self.postset = []
        self.idx = []
        self.number = []
        self.value = []
class TimeKeeper(GenericClass):
    def __init__(self):
        self.idx = []
        self.value = []
        self.numEvents = []
## Operands ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Operand(PetriNet):
    def __init__(self):
        self.requiredKeys = RequiredKeys()
        # Primitive data attributes for validation.  See validateAttributeData()
        self.operandName = []           # The name of the operand
        self.operandNetName = []        # The name of the operand net
        self._operandType = []          # The type of operand
        self.status = []                # Status describes the availability the operand.
        self.requiredKeys.default = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys()) - {'requiredKeys'}}
        self.requiredKeys.SoSResilience = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys()) - {'requiredKeys'}}

        self.hasOperandNet_STF1 = []
        self.hasOperandNet_STF2 = []
        self.hasOperandNet_Duration = []
        self.hasOperandNetEnablingConstraint = []
        self.hasSyncMatNeg = []
        self.hasSyncMatPos = []

        self.hasPlaceLinearCost = []
        self.hasPlaceQuadCost = []
        self.hasPlaceUpperBound = []
        self.hasPlaceLowerBound = []
        self.hasPlaceInitConds = []
        self.hasPlaceFinalConds = []

        self.hasTransitionLinearCostFlowNeg = []
        self.hasTransitionLinearCostFlowPos = []
        self.hasTransitionLinearCostStock = []

        self.hasTransitionQuadCostFlowNeg = []
        self.hasTransitionQuadCostFlowPos = []
        self.hasTransitionQuadCostStock = []

        self.hasTransitionUpperBoundFlowNeg = []
        self.hasTransitionUpperBoundFlowPos = []
        self.hasTransitionUpperBoundStock = []

        self.hasTransitionLowerBoundFlowNeg = []
        self.hasTransitionLowerBoundFlowPos = []
        self.hasTransitionLowerBoundStock = []

        self.hasTransitionDurationConds = []
        self.hasTransitionFinalConds = []
        self.hasTransitionInitConds = []
        self.requiredKeys.HFNMCF = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys()) - {'requiredKeys'}}

        self.sosType = []
        # Inherited data attributes
        PetriNet.__init__(self)
        # Primitive data attributes for calculation
        self.idx = []
        self.number = []
        # Non-primitive data attributes
        self.AL = []
        self.ALrho = []
        self.Adual = []
        self.Aprime = []
        self.Lambda = []
        self.LambdaHolding = []
        self.LambdaTransform = []
        self.LambdaTransport = []
        self.syncMat = []

        self.validator = Validator()
        self.validator.keys = [ 'hasOperandNet_Duration', 'hasOperandNet_STF1', 'hasOperandNet_STF2', 'hasOperandNetEnablingConstraint', 'hasSyncMatNeg','hasSyncMatPos',
                                'hasPlaceLinearCost', 'hasPlaceQuadCost','hasPlaceUpperBound', 'hasPlaceLowerBound', 'hasPlaceInitConds', 'hasPlaceFinalConds',
                                'hasTransitionLinearCostFlowNeg','hasTransitionLinearCostFlowPos', 'hasTransitionLinearCostStock',
                                'hasTransitionQuadCostFlowNeg', 'hasTransitionQuadCostFlowPos', 'hasTransitionQuadCostStock',
                                'hasTransitionUpperBoundFlowNeg','hasTransitionUpperBoundFlowPos','hasTransitionUpperBoundStock',
                                'hasTransitionLowerBoundFlowNeg', 'hasTransitionLowerBoundFlowPos', 'hasTransitionLowerBoundStock',
                                'hasTransitionDurationConds', 'hasTransitionFinalConds', 'hasTransitionInitConds', 'status']
        self.validator.keyTypes = ['bool'] * 28
    @property
    def operandType(self) -> OperandType | list[OperandType]:
        return self._operandType
    @operandType.setter
    def operandType(self, myValue):
        # Try Block:  checking for type correctness of myValue.
        try:
            if isinstance(myValue, OperandType): self._operandType = myValue
            elif isinstance(myValue, str):
                # Try Block:  checking for value correctness of myValue
                try: self._operandType = OperandType(myValue) # allow strings, but validate them
                except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in OperandType]}"); sys.exit(1)
            elif isinstance(myValue, list): self._operandType = [OperandType(v) for v in myValue]
            else: raise TypeError("OperandType must be a OperandType enum, valid string, or valid list.")
        except TypeError as e: logger.error(f"TypeError: {e}"); sys.exit(1)
    @log_entry_exit_trace
    def setupOperand(self, myRoot=None):
        myRequiredKeys = getattr(self.requiredKeys, analysisMethod)
        if 'defaultXML' in inputDataFormat:
            self.appendInputDataAttributes(myRoot.attrib, myRequiredKeys)
            self.setupOperandNet(myRoot)
        elif 'sysml' in inputDataFormat: pass
        else: pass
    @log_entry_exit_trace
    def setupOperandNet(self, myRoot=None):
        """
        This function copies the attributes of myProcesses associated with a resource from the intermediary
        
    Args:
        opt: “M”,“C”, or “H” for transformation process, control process,
            or transportation process respectively
        
        """
        if 'defaultXML' in inputDataFormat:
            for myChild in myRoot:
                if myChild.tag == 'OperandPlace':
                    if self.pnPlaces[-1] == None: self.pnPlaces[-1] = OperandPlace()
                    else: pass
                    myRequiredKeys = getattr(self.pnPlaces[-1].requiredKeys,analysisMethod)
                    self.pnPlaces[-1].appendInputDataAttributes(myChild.attrib, myRequiredKeys)
                elif myChild.tag == 'OperandTransition':
                    if self.pnTransitions[-1] == None: self.pnTransitions[-1] = OperandTransition()
                    else: pass
                    myRequiredKeys = getattr(self.pnTransitions[-1].requiredKeys, analysisMethod)
                    self.pnTransitions[-1].appendInputDataAttributes(myChild.attrib, myRequiredKeys)
                else:
                    logger.error("The XML tag ", myChild.tag, " in the OperandNet Layer is invalid! Abort! Abort!")
                    sys.exit(1)
        elif 'sysml' in inputDataFormat: pass
        else: pass
    @log_entry_exit_trace
    def calcOperand(self):
        self.number = len(self.operandName)
        self.idx = list(range(self.number))
        self.validateAttributeData()
        for k in range(self.number):
            if self.pnPlaces[k] != None: self.calcOperandPlace(k)
            if self.pnTransitions[k] != None: self.calcOperandTransition(k)
            if self.pnPlaces[k] != None and self.pnTransitions[k] != None:
                self.Mneg[k]   = calcIncidenceMatrix(self.pnPlaces[k].name, self.pnTransitions[k].preset, 'col',self.pnTransitions[k].presetWeight)
                self.Mpos[k]   = calcIncidenceMatrix(self.pnPlaces[k].name, self.pnTransitions[k].postset, 'col',self.pnTransitions[k].postsetWeight)
            else:
                self.Mneg[k] = coo_array((0, 0), dtype=int)
                self.Mpos[k] = coo_array((0, 0), dtype=int)
            self.MFull[k]  = (self.Mpos[k] - self.Mneg[k]).tocoo()
            self.Aprime[k] = (self.Mneg[k].dot(self.Mpos[k].T)).tocoo()
            self.Adual[k]  = ((self.Mpos[k].T).dot(self.Mneg[k])).tocoo()
        self.AL = block_diag(tuple(self.Adual))
    @log_entry_exit_trace
    def calcOperandPlace(self,k):
        self.pnPlaces[k].number = len(self.pnPlaces[k].name)
        self.pnPlaces[k].idx = self.pnPlaces[k].number
        if analysisMethod == 'HFNMCF':
            if self.hasPlaceUpperBound[k]: getattr(self.pnPlaces[k].requiredKeys, analysisMethod).add('upperBound')
            if self.hasPlaceLowerBound[k]: getattr(self.pnPlaces[k].requiredKeys, analysisMethod).add('lowerBound')
            if self.hasPlaceLinearCost[k]: getattr(self.pnPlaces[k].requiredKeys, analysisMethod).add('linearCostCoeff')
            if self.hasPlaceFinalConds[k]: getattr(self.pnPlaces[k].requiredKeys, analysisMethod).add('finalCond')
            if self.hasPlaceInitConds[k]: getattr(self.pnPlaces[k].requiredKeys, analysisMethod).add('initCond')
            if self.hasPlaceUpperBound[k] or self.hasPlaceLowerBound[k] or self.hasPlaceCost[k] or self.hasPlaceFinalConds[k] or self.hasPlaceInitConds[k]:
                getattr(self.pnPlaces[k].requiredKeys,analysisMethod).add('varDomain')
        else: pass
        self.pnPlaces[k].validateAttributeData()
        # This step is needed to validate varDomain for the rest of the code.
        # self.pnPlaces[k].varDomain = self.pnPlaces[k].varDomain
        self.pnPlaces[k].varDomain = vecMAT(self.pnPlaces[k].varDomain)
        temp = np.array([x.value for x in self.pnPlaces[k].placeType])
        if any(np.isin(temp, 'source')): self.sosType[k] = 'source'
        elif any(np.isin(temp, 'must produce')): self.sosType[k] = 'must produce'
        elif any(np.isin(temp, 'sink')): self.sosType[k] = 'sink'
        else: self.sosType[k] = 'internal'
    @log_entry_exit_trace
    def calcOperandTransition(self,k):
        self.pnTransitions[k].number = len(self.pnTransitions[k].name)
        self.pnTransitions[k].idx = self.pnTransitions[k].number
        self.pnTransitions[k].validateTransitionWeights('preset', 'presetWeight')
        self.pnTransitions[k].validateTransitionWeights('postset','postsetWeight')
        # We can't use self.pnTransitions[k].processLinkName as is because it historically includes transportation and storage processes.
        # For backwards compatibility, we have to filter these out.
        temp = self.pnTransitions[k].processLinkName
        self.pnTransitions[k].processLinkName = ['' if s.startswith(('transport', 'store')) else s for s in self.pnTransitions[k].processLinkName]
        self.pnTransitions[k].validateTransitionWeights('processLinkName','processLinkWeight')
        self.pnTransitions[k].processLinkName = temp
        self.pnTransitions[k].validateTransitionWeights('processLinkRef','processLinkRefWeight')
        self.pnTransitions[k].validateAttributeData()
        # self.pnTransitions[k].varDomain = self.pnTransitions[k].varDomain
        self.pnTransitions[k].varDomain = vecMAT(self.pnTransitions[k].varDomain)
    @log_entry_exit_trace
    def calcSoSService(self):
        mySoSService = self.collectAllOperands()
        mySoSService.consolidateOperandNet()
        return mySoSService
    @log_entry_exit_trace
    def collectAllOperands(self):
        mySoSService = Operand()
        mySoSService.operandNetName = 'deliver SoS service'
        mySoSService.operandName = 'SoS service'
        mySoSService.idx = 0
        mySoSService.sosType = 'hybrid'
        mySoSService.operandType = 'information'
        mySoSService.number = 1
        mySoSService.pnPlaces = OperandPlace()
        mySoSService.pnTransitions = OperandTransition()
        # Collect data from all individual operands
        for k in range(self.number):
            mySoSService.pnPlaces.name.extend(self.pnPlaces[k].name)
            mySoSService.pnPlaces.placeType.extend(self.pnPlaces[k].placeType)
            for k1 in range(len(self.pnTransitions[k].name)):
                # Use the holding process name if it is linked to a refined transportation process
                if self.pnTransitions[k].processLinkName[k1].startswith('store') or self.pnTransitions[k].processLinkName[k1].startswith('transport'):
                    mySoSService.pnTransitions.name.append(self.pnTransitions[k].processLinkRef[k1])
                # Use the processing name if it is a transformation process.
                else:
                    mySoSService.pnTransitions.name.append(self.pnTransitions[k].processLinkName[k1])
            mySoSService.pnTransitions.preset.extend(self.pnTransitions[k].preset)
            mySoSService.pnTransitions.postset.extend(self.pnTransitions[k].postset)
            mySoSService.pnTransitions.processLinkName.extend(self.pnTransitions[k].processLinkName)
            mySoSService.pnTransitions.processLinkRef.extend(self.pnTransitions[k].processLinkRef)
        mySoSService.pnPlaces.fillAttributesWithNones(['name','placeType'])
        mySoSService.pnTransitions.fillAttributesWithNones(['name', 'preset','postset','processLinkName','processLinkRef'])
        mySoSService.fillAttributesWithNones(['operandNetName','operandName','idx','sosType','number','pnPlaces','pnTransitions'])
        return mySoSService
    @log_entry_exit_trace
    def calcSystemOperandSyncMatrix(self):
        tempList = []
        for myOperandNet in self.operandNet:
            if isinstance(myOperandNet, OperandNet): tempList.append(myOperandNet.syncMat)
            else: tempList.append(coo_array((0, 0), dtype=int))
        self.ALrho = vstack(tempList)
    @log_entry_exit_trace
    def extractSysMLOperands(self):
        omitKeys = ['requiredKeys', 'validator']
        self.myName = self.operandName
        myKeys = stripUnderscores(list(vars(self).keys()))
        for myKey in myKeys:
            if myKey in omitKeys: delattr(self,myKey)
            elif myKey == 'pnPlaces':
                tempPlaceList = []
                for myPlace in getattr(self, myKey):
                    if myPlace is None: tempPlaceList.append(None)
                    else:
                        tempPlaceList.append(myPlace.extractSysMLOperandPlace())
                setattr(self, myKey, tempPlaceList)
            elif myKey == 'pnTransitions':
                tempTransitionList = []
                for myTransition in getattr(self, myKey):
                    if myTransition is None: tempTransitionList.append(None)
                    else:
                        tempTransitionList.append(myTransition.extractSysMLOperandTransition())
                setattr(self, myKey, tempTransitionList)
            else: pass
        tempOperandDict = dictify(self)
        tempOperandDict['myClass'] = [tempOperandDict['myClass']] * len(tempOperandDict['myName'])
        tempOperandDict['part'] = [[]] * len(tempOperandDict['myName'])
        tempOperandList = pd.DataFrame(tempOperandDict).to_dict("records")
        for k in range(len(tempOperandList)):
            if tempOperandList[k]['pnPlaces'] != None:
                tempOperandList[k]['part'] = tempOperandList[k]['part'] + tempOperandList[k]['pnPlaces']
                del tempOperandList[k]['pnPlaces']
            if tempOperandList[k]['pnTransitions'] != None:
                tempOperandList[k]['part'] = tempOperandList[k]['part'] + tempOperandList[k]['pnTransitions']
                del tempOperandList[k]['pnTransitions']
            if tempOperandList[k]['part'] == []:
                tempOperandList[k]['part'] = None
        tempOperandList = cleanNonesFromListofDicts(tempOperandList)
        return tempOperandList
    @log_entry_exit_trace
    def consolidateOperandNet(self):
        myTransitionNames, idxSet, idxList = np.unique(self.pnTransitions.name, return_index=True, return_inverse=True)
        self.pnTransitions.name = myTransitionNames.tolist()
        # The penultimate operand net transition is the initiating transition
        # The last operand net transition is the finalizing transition.
        self.pnTransitions.name.extend(['initiate SoSService','finish SoSService'])
        self.pnTransitions.processLinkName = np.array(self.pnTransitions.processLinkName)[idxSet].tolist()
        self.pnTransitions.processLinkName.extend(['initiate SoSService','finish SoSService'])
        self.pnTransitions.processLinkRef = np.array(self.pnTransitions.processLinkRef)[idxSet].tolist()
        self.pnTransitions.processLinkRef.extend(['',''])
        myPresets  = [''] * len(idxSet)
        myPostsets = [''] * len(idxSet)
        for k in range(len(idxList)):
            # Only add a comma if you need to
            if myPresets[idxList[k]] != '' and self.pnTransitions.preset[k] != '': myPresets[idxList[k]] = myPresets[idxList[k]] + ','
            if myPostsets[idxList[k]] != '' and self.pnTransitions.postset[k] != '': myPostsets[idxList[k]] += ','
            # Append what you find in presets and postsets
            myPresets[idxList[k]] = myPresets[idxList[k]] + self.pnTransitions.preset[k]
            myPostsets[idxList[k]] = myPostsets[idxList[k]] + self.pnTransitions.postset[k]
        idxTemp = np.isin(self.pnPlaces.placeType,'source')
        temp = ','.join(np.array(self.pnPlaces.name)[idxTemp])
        myPostsets.extend([temp,''])
        idxTemp = np.isin(self.pnPlaces.placeType,'must produce')
        temp = ','.join(np.array(self.pnPlaces.name)[idxTemp])
        myPresets.extend(['',temp])
        self.pnTransitions.preset = myPresets
        self.pnTransitions.postset = myPostsets
        self.Mneg   = calcIncidenceMatrix(self.pnPlaces.name, self.pnTransitions.preset, 'col')
        self.Mpos   = calcIncidenceMatrix(self.pnPlaces.name, self.pnTransitions.postset, 'col')
        self.MFull  = (self.Mpos - self.Mneg).tocoo()
        self.Aprime = (self.Mneg.dot(self.Mpos.T)).tocoo()
        self.Adual  = ((self.Mpos.T).dot(self.Mneg)).tocoo()
        self.AL     = self.Adual
class OperandNet(GenericClass):
    def __init__(self):
        PetriNet.__init__(self)
class OperandPlace(PetriNetPlace):
    def __init__(self):
        PetriNetPlace.__init__(self)
        self._placeType = []
        self.requiredKeys = RequiredKeys()
        self.requiredKeys.default = {'name','placeType'}
        self.requiredKeys.SoSResilience = {'name', 'placeType'}
        self.requiredKeys.HFNMCF = {'name','placeType'}       #Only for initialization.  Recalculated later.
        # Primitive data attributes for validation
        self.validator = Validator()
        self.validator.keys = ['upperBound', 'lowerBound','quadCostCoeff','linearCostCoeff', 'finalCond', 'initCond']
        self.validator.keyTypes = ['float', 'float','float','float', 'float', 'float']
    @property
    def placeType(self) -> PlaceType | list[PlaceType]:
        return self._placeType
    @placeType.setter
    def placeType(self,myValue):
        # Try Block:  checking for type correctness of myValue.
        try:
            if isinstance(myValue, PlaceType): self._placeType = myValue
            elif isinstance(myValue, str):
                # Try Block:  checking for type correctness of myValue.
                try: self._placeType = PlaceType(myValue) # allow strings, but validate them
                except ValueError: raise ValueError(f"Invalid mode '{myValue}'. Must be one of {[m.value for m in PlaceType]}"); sys.exit1(1)
            elif isinstance(myValue, list):
                self._placeType = [PlaceType(v) for v in myValue]
            else: raise TypeError("PlaceType must be an PlaceType enum, valid string, or valid list.")
        except TypeError as e: logger.error(f"TypeError: {e}"); sys.exit(1)
    @log_entry_exit_trace
    def extractSysMLOperandPlace(self):
        omitKeys = ['requiredKeys', 'validator']
        myKeys = stripUnderscores(list(vars(self).keys()))
        for myKey in myKeys:
            if myKey in omitKeys: delattr(self, myKey)
            else: pass
        tempPlaceDict = dictify(self)
        tempPlaceDict['myName'] = tempPlaceDict['name']
        # for k in range(len(tempPlaceDict['varDomain'])):
        #     if tempPlaceDict['varDomain'][k] != None:
        #         tempPlaceDict['varDomain'][k] = ",".join(tempPlaceDict['varDomain'][k])
        tempPlaceList = pd.DataFrame(tempPlaceDict).to_dict("records")
        tempPlaceList = cleanNonesFromListofDicts(tempPlaceList)
        return tempPlaceList
class EngSysNetPlace(PetriNetPlace):
    def __init__(self):
        PetriNetPlace.__init__(self)
        self.operandType = []
class OperandTransition(PetriNetTransition):
    def __init__(self):
        PetriNetTransition.__init__(self)
        self.presetWeight = []
        self.postsetWeight = []
        self.processLinkName = []
        self.processLinkRef = []
        self.processLinkWeight = []
        self.processLinkRefWeight = []
        self.requiredKeys = RequiredKeys()
        self.requiredKeys.default = {'preset','postset','processLinkName','processLinkRef'}
        self.requiredKeys.SoSResilience = {'preset', 'postset', 'processLinkName', 'processLinkRef'}
        self.requiredKeys.HFNMCF = {'preset','postset','processLinkName','processLinkRef','varDomain'}

        self.validator = Validator()
        self.validator.keys =     ['upperBoundFlowNeg','upperBoundFlowPos','upperBoundStock',
                                   'lowerBoundFlowNeg','lowerBoundFlowPos','lowerBoundStock',
                                   'linearCostCoeffFlowNeg', 'linearCostCoeffFlowPos','linearCostCoeffStock',
                                   'quadCostCoeffFlowNeg', 'quadCostCoeffFlowPos', 'quadCostCoeffStock',
                                   'initCond','finalCond','duration']
        self.validator.keyTypes = ['float','float','float',
                                   'float', 'float', 'float',
                                   'floatVector', 'floatVector', 'floatVector',
                                   'floatVector', 'floatVector', 'floatVector',
                                   'float','float','int']
    @log_entry_exit_trace
    def validateTransitionWeights(self, transitionKey, transitionWeightKey):
        # NOTE:  This function is effectively the same as validateProcessWeights but with a FOR loop!
        # Try Block:  checking to make sure stringKey and weightStringkey have non-None values
        try:
            if getattr(self, transitionKey) == [None]:
                raise AttributeError(
                    f"Fail! {type(self).__name__} called {self.name} does not have valid values for "
                    f"{transitionKey} and {transitionWeightKey}! Abort! Abort!")
        except AttributeError as e: logger.error(f"{e}"); sys.exit(1)
        placeStrings = []
        placeWeightStrings = []
        for k in range(len(getattr(self, transitionKey))):
            if getattr(self, transitionKey)[k] == '':
                placeStrings.append([])
            else:
                placeStrings.append((getattr(self, transitionKey)[k]).split(','))

            if getattr(self, transitionWeightKey)[k] == None:  # Presest/Postset transition weight is not provided
                placeWeightStrings.append([1.0] * len(placeStrings[k]))
            elif getattr(self, transitionWeightKey)[k] == '':   # Preset/Postset transition weight is empty
                placeWeightStrings.append([])
            else:  # Preset/Postset transition weight is provided properly
                temp = (getattr(self, transitionWeightKey)[k]).split(',')
                placeWeightStrings.append([float(x) for x in temp])
                # Try Block:  checking if preset/postset places and preset/postset place weights do not have the same length
                try:
                    if len(placeStrings[k]) != len(placeWeightStrings[k]):
                        raise ValueError(
                            f"Fail! {type(self).__name__} called {self.name} does not have an equal number of "
                            f"values for {transitionKey} and {transitionWeightKey}! Abort! Abort!")
                except ValueError as e:
                    logger.error(f"Error: {e}"); sys.exit(1)
            # setattr(self, operandKey, placeStrings) --> Don't overcomplicate! A comma delimited string is fine!
        setattr(self, transitionWeightKey, placeWeightStrings)
    @log_entry_exit_trace
    def extractSysMLOperandTransition(self):
        omitKeys = ['requiredKeys', 'validator']
        myKeys = stripUnderscores(list(vars(self).keys()))
        for myKey in myKeys:
            if myKey in omitKeys: delattr(self, myKey)
            else: pass
        tempTransitionDict = dictify(self)
        tempTransitionDict['myName'] = tempTransitionDict['name']
        # for k in range(len(tempTransitionDict['varDomain'])):
        #     if tempTransitionDict['varDomain'][k] != None:
        #         tempTransitionDict['varDomain'][k] = ",".join(tempTransitionDict['varDomain'][k])
        tempTransitionList = pd.DataFrame(tempTransitionDict).to_dict("records")
        tempTransitionList = cleanNonesFromListofDicts(tempTransitionList)
        return tempTransitionList
class EngSysNetTransition(PetriNetTransition):
    def __init__(self):
        PetriNetTransition.__init__(self)
        self.idxResource = []
        self.idxProcess  = []
        self.idxChiCapability = []
## RESOURCES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Resource(GenericClass):
    def __init__(self):
        self.requiredKeys = RequiredKeys()
        # Primitive data attributes for validation.  See validateAttributeData()
        self.requiredKeys.default = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys())-{'requiredKeys'}}
        self.requiredKeys.HFNMCF = self.requiredKeys.default  # Only for initialization.  Recalculated later.
        # Primitive data attributes for calculation.
        self.idx = []
        self.name = []
        self.number = []
        self.status = []
        self.validator = Validator()
    @log_entry_exit_trace
    def extractSysMLResources(self):
        omitKeys = ['requiredKeys', 'validator']
        if isinstance(self,TransformationResource): self.myName = self.transformationResourceName
        elif isinstance(self,IndependentBuffer): self.myName = self.independentBufferName
        elif isinstance(self,TransportationResource): self.myName = self.transportationResourceName
        else: pass
        myKeys = stripUnderscores(list(vars(self).keys()))
        for myKey in myKeys:
            if myKey in omitKeys: delattr(self,myKey)
            elif myKey in ['transformProcess','transportProcess']:
                tempProcessList = []
                for myProcess in getattr(self, myKey):
                    if myProcess is None: tempProcessList.append(None)
                    else:  tempProcessList.append(myProcess.extractSysMLProcess())
                setattr(self, myKey, tempProcessList)
            else: pass
        tempResourceDict = dictify(self)
        tempResourceDict['myClass'] = [tempResourceDict['myClass']] * len(tempResourceDict['myName'])
        tempResourceDict['action'] = [[]] * len(tempResourceDict['myName'])
        # if isinstance(self,Buffer):
        #     for k in range(len(tempResourceDict['varDomain'])):
        #         if tempResourceDict['varDomain'][k] != None:
        #             tempResourceDict['varDomain'][k] = ",".join(tempResourceDict['varDomain'][k])
        tempResourceList = pd.DataFrame(tempResourceDict).to_dict("records")
        for k in range(len(tempResourceList)):
            if isinstance(self, TransformationResource):
                tempResourceList[k]['action'] = tempResourceList[k]['action'] + tempResourceList[k]['transformProcess']
                del tempResourceList[k]['transformProcess']
            if tempResourceList[k]['transportProcess'] != None:
                tempResourceList[k]['action'] = tempResourceList[k]['action'] + tempResourceList[k]['transportProcess']
                del tempResourceList[k]['transportProcess']
            if tempResourceList[k]['action'] == []:
                tempResourceList[k]['action'] = None
        tempResourceList = cleanNonesFromListofDicts(tempResourceList)
        return tempResourceList
class PhysicalResource(Resource):
    def __init__(self):
        Resource.__init__(self)
        # Primitive data attributes for validation.  See validateAttributeData()
        self.decisionMaker = []
        self.autonomous = []
        self.requiredKeys.default = self.requiredKeys.default | {'decisionMaker','autonomous'}
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'decisionMaker','autonomous'}
        # Primitive data attributes for calculation.
        self.idxResource = []
    @log_entry_exit_trace
    def calcResource(self, configAnalysisMethod, myTransportProcess, myTransformProcess=None):
        if isinstance(self, TransformationResource):
            self.number = len(self.transformationResourceName)
            if self.number == 0: logger.warning("Warning!  This LFES has no transformation resources. It is a closed "
                                       "transportation system! Proceeding cautiously...")
            self.name = self.transformationResourceName
            self.idx = list(range(self.number))
            self.idxBuffer = self.idx
            self.idxResource = self.idx
        elif isinstance(self, IndependentBuffer):
            self.number = len(self.independentBufferName)
            if self.number == 0: logger.warning("Warning! This LFES has no independent buffers. Some transformation process "
                                       "happens everywhere! Proceeding cautiously ...")
            self.name = self.independentBufferName
            self.idx = list(range(self.number))
            self.idxBuffer = [configAnalysisMethod.numTransformationResources + x for x in self.idx]
            self.idxResource = self.idxBuffer
        elif isinstance(self, TransportationResource):
            self.number = len(self.transportationResourceName)
            if self.number == 0: logger.warning("Warning!  This LFES has no transportation resources.  Are all transportation "
                                       "processes handled by buffers? Proceeding cautiously ...")
            self.name = self.transportationResourceName
            self.idx = list(range(self.number))
            self.idxResource = [configAnalysisMethod.numBuffers + x for x in self.idx]
        else: pass
        if self.number > 0:
            self.status = [True] * self.number
            if analysisMethod == 'HFNMCF':
                # Dynamically revising required keys to take into account buffer conditions and costs
                if isinstance(self, Buffer):
                    if configAnalysisMethod.hasBufferUpperBound == True: getattr(self.requiredKeys, analysisMethod).add('upperBound')
                    if configAnalysisMethod.hasBufferLowerBound == True: getattr(self.requiredKeys, analysisMethod).add('lowerBound')
                    if configAnalysisMethod.hasBufferInitCond == True: getattr(self.requiredKeys, analysisMethod).add('initCond')
                    if configAnalysisMethod.hasBufferFinalCond == True: getattr(self.requiredKeys, analysisMethod).add('finalCond')
                    if configAnalysisMethod.hasBufferLinearCost == True: getattr(self.requiredKeys, analysisMethod).add('linearCostCoeff')
                    if configAnalysisMethod.hasBufferQuadCost == True: getattr(self.requiredKeys, analysisMethod).add('quadCostCoeff')
                else:pass
            else: pass
            self.validateAttributeData()
            if isinstance(self, TransformationResource):
                for myProcess in self.transformProcess:
                    if myProcess != None:
                        if analysisMethod == 'HFNMCF':
                            if configAnalysisMethod.hasProcessUpperBoundFlowNeg == True: getattr(myProcess.requiredKeys,analysisMethod).add('upperBoundFlowNeg')
                            if configAnalysisMethod.hasProcessUpperBoundFlowPos == True: getattr(myProcess.requiredKeys,analysisMethod).add('upperBoundFlowPos')
                            if configAnalysisMethod.hasProcessUpperBoundStock == True: getattr(myProcess.requiredKeys,analysisMethod).add('upperBoundStock')
                            if configAnalysisMethod.hasProcessLowerBoundFlowNeg == True: getattr(myProcess.requiredKeys,analysisMethod).add('lowerBoundFlowNeg')
                            if configAnalysisMethod.hasProcessLowerBoundFlowPos == True: getattr(myProcess.requiredKeys,analysisMethod).add('lowerBoundFlowPos')
                            if configAnalysisMethod.hasProcessLowerBoundStock == True: getattr(myProcess.requiredKeys,analysisMethod).add('lowerBoundStock')
                            if configAnalysisMethod.hasProcessUpperBoundRamp == True: getattr(self.requiredKeys,analysisMethod).add('upperBoundRamp')
                            if configAnalysisMethod.hasProcessLowerBoundRamp == True: getattr(self.requiredKeys,analysisMethod).add('lowerBoundRamp')
                            if configAnalysisMethod.hasProcessInitCond == True: getattr(myProcess.requiredKeys,analysisMethod).add('initCond')
                            if configAnalysisMethod.hasProcessFinalCond == True: getattr(myProcess.requiredKeys,analysisMethod).add('finalCond')
                            if configAnalysisMethod.hasProcessLinearCostFlowNeg == True: getattr(myProcess.requiredKeys,analysisMethod).add('linearCostCoeffFlowNeg')
                            if configAnalysisMethod.hasProcessLinearCostFlowPos == True: getattr(myProcess.requiredKeys,analysisMethod).add('linearCostCoeffFlowPos')
                            if configAnalysisMethod.hasProcessLinearCostStock == True: getattr(myProcess.requiredKeys,analysisMethod).add('linearCostCoeffStock')
                            if configAnalysisMethod.hasProcessQuadCostFlowNeg == True: getattr(myProcess.requiredKeys,analysisMethod).add('quadCostCoeffFlowNeg')
                            if configAnalysisMethod.hasProcessQuadCostFlowPos == True: getattr(myProcess.requiredKeys,analysisMethod).add('quadCostCoeffFlowPos')
                            if configAnalysisMethod.hasProcessQuadCostStock == True: getattr(myProcess.requiredKeys,analysisMethod).add('quadCostCoeffStock')
                            if configAnalysisMethod.hasProcessDuration == True: getattr(myProcess.requiredKeys,analysisMethod).add('duration')
                        else: pass
                        myProcess.validateProcess()
                        myTransformProcess.insertProcessData(myProcess)
                    else: pass
            else: pass
            for myProcess in self.transportProcess:
                if myProcess != None:
                    if analysisMethod == 'HFNMCF':
                        if configAnalysisMethod.hasProcessUpperBoundFlowNeg == True: getattr(myProcess.requiredKeys, analysisMethod).add('upperBoundFlowNeg')
                        if configAnalysisMethod.hasProcessUpperBoundFlowPos == True: getattr(myProcess.requiredKeys, analysisMethod).add('upperBoundFlowPos')
                        if configAnalysisMethod.hasProcessUpperBoundStock == True: getattr(myProcess.requiredKeys, analysisMethod).add('upperBoundStock')
                        if configAnalysisMethod.hasProcessLowerBoundFlowNeg == True: getattr(myProcess.requiredKeys,analysisMethod).add('lowerBoundFlowNeg')
                        if configAnalysisMethod.hasProcessLowerBoundFlowPos == True: getattr(myProcess.requiredKeys, analysisMethod).add('lowerBoundFlowPos')
                        if configAnalysisMethod.hasProcessLowerBoundStock == True: getattr(myProcess.requiredKeys, analysisMethod).add('lowerBoundStock')
                        if configAnalysisMethod.hasProcessUpperBoundRamp == True: getattr(self.requiredKeys,analysisMethod).add('upperBoundRamp')
                        if configAnalysisMethod.hasProcessLowerBoundRamp == True: getattr(self.requiredKeys,analysisMethod).add('lowerBoundRamp')
                        if configAnalysisMethod.hasProcessInitCond == True: getattr(myProcess.requiredKeys, analysisMethod).add('initCond')
                        if configAnalysisMethod.hasProcessFinalCond == True: getattr(myProcess.requiredKeys, analysisMethod).add('finalCond')
                        if configAnalysisMethod.hasProcessLinearCostFlowNeg == True: getattr(myProcess.requiredKeys, analysisMethod).add('linearCostCoeffFlowNeg')
                        if configAnalysisMethod.hasProcessLinearCostFlowPos == True: getattr(myProcess.requiredKeys,analysisMethod).add('linearCostCoeffFlowPos')
                        if configAnalysisMethod.hasProcessLinearCostStock == True: getattr(myProcess.requiredKeys,analysisMethod).add('linearCostCoeffStock')
                        if configAnalysisMethod.hasProcessQuadCostFlowNeg == True: getattr(myProcess.requiredKeys, analysisMethod).add('quadCostCoeffFlowNeg')
                        if configAnalysisMethod.hasProcessQuadCostFlowPos == True: getattr(myProcess.requiredKeys,analysisMethod).add('quadCostCoeffFlowPos')
                        if configAnalysisMethod.hasProcessQuadCostStock == True: getattr(myProcess.requiredKeys,analysisMethod).add('quadCostCoeffStock')
                        if configAnalysisMethod.hasProcessDuration == True: getattr(myProcess.requiredKeys, analysisMethod).add('duration')
                    else: pass
                    myProcess.reviseTransportationProcessData()
                    myProcess.validateProcess()
                    myTransportProcess.insertProcessData(myProcess)
                else: pass
        else: pass
class Buffer(PhysicalResource):
    def __init__(self):
        PhysicalResource.__init__(self)
        # Primitive data attributes for validation.  See validateAttributeData()
        self.gpsX = []
        self.gpsY = []
        self.requiredKeys.default = self.requiredKeys.default | {'gpsX', 'gpsY'}
        self.varDomain = []
        self.varDomainEnabled = []
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'gpsX', 'gpsY'}      # Only for initialization.  Recalculated later.
        self.initCond = []
        self.finalCond = []
        self.upperBound = []
        self.lowerBound = []
        self.linearCostCoeff = []
        self.quadCostCoeff = []
        # Primitive data attributes for calculation.
        self.idxBuffer = []
        # Switch the second to floatMatrix
        self.validator.keys = ['autonomous','upperBound', 'lowerBound', 'linearCostCoeff',
                               'quadCostCoeff','finalCond', 'gpsX', 'gpsY', 'initCond',
                               'varDomain','varDomainEnabled']
        self.validator.keyTypes = ['bool','floatMatrix', 'floatVector','floatVector',
                                   'floatVector','floatVector','float','float','floatVector',
                                   'strVector','strVector']
class TransformationResource(Buffer):
    def __init__(self):
        Buffer.__init__(self)
        # Primitive data attributes for validation. See validateAttributeData()
        self.transformationResourceName = []
        self.requiredKeys.default = self.requiredKeys.default | {'transformationResourceName'}
        self.requiredKeys.SoSResilience = self.requiredKeys.default | {'transformationResourceName'}
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'transformationResourceName'}
        self.requiredKeys.timedEvents = self.requiredKeys.HFNMCF | {'transformationResourceName'}
        self.transformProcess = []
        self.transportProcess = []
class IndependentBuffer(Buffer):
    def __init__(self):
        Buffer.__init__(self)
        # Primitive data attributes for validation.  See validateAttributeData()
        self.independentBufferName = []
        self.requiredKeys.default = self.requiredKeys.default | {'independentBufferName'}
        self.requiredKeys.SoSResilience = self.requiredKeys.default | {'independentBufferName'}
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'independentBufferName'}
        self.requiredKeys.timedEvents = self.requiredKeys.HFNMCF | {'independentBufferName'}
        self.transportProcess = []
class TransportationResource(PhysicalResource):
    def __init__(self):
        PhysicalResource.__init__(self)
        # Primitive data attributes for validation.  See validateAttributeData()
        self.transportationResourceName = []
        self.requiredKeys.default = self.requiredKeys.default | {'transportationResourceName'}
        self.requiredKeys.SoSResilience = self.requiredKeys.default | {'transportationResourceName'}
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'transportationResourceName'}
        self.requiredKeys.timedEvents = self.requiredKeys.HFNMCF | {'transportationResourceName'}
        self.transportProcess = []
class DecisionMaker(Resource):
    def __init__(self):
        Resource.__init__(self)
        # Primitive data attributes for validation. See validateAttributeData()
        self.peerRecipient = []
        self.requiredKeys.default = self.requiredKeys.default | {'name','peerRecipient'}
        self.requiredKeys.SoSResilience = self.requiredKeys.default | {'name', 'peerRecipient'}
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'name','peerRecipient'}
        self.requiredKeys.timedEvents = self.requiredKeys.HFNMCF | {'name','peerRecipient'}
        self.A_DD = []
        self.A_RD = []
        self.ARhoD = []
    @log_entry_exit_trace
    def setupDecisionMakers(self, myRoot = None):
        if 'defaultXML' in inputDataFormat:
            myRequiredKeys = getattr(self.requiredKeys, analysisMethod)
            self.appendInputDataAttributes(myRoot,myRequiredKeys)
        elif 'sysml' in inputDataFormat:
            myDictKeys = [k for k, v in vars(self).items() if isinstance(v, list) and v]
            if myDictKeys:
                self.fillAttributesWithNones(myDictKeys)
                delattr(self, "myName")
        else: pass
    @log_entry_exit_trace
    def calcDecisionMakers(self):
        self.number = len(self.name)
        if self.number == 0:
            logger.info("Warning!  This LFES has no decision-making resources. This is a purely physical system. Proceeding cautiously ...")
        else:
            self.idx = list(range(self.number))
            self.status = [True] * self.number
    @log_entry_exit_trace
    def calcDecisionMakerAdjacency(self):
        self.A_DD = calcIncidenceMatrix(self.name,self.peerRecipient,'col')
    @log_entry_exit_trace
    def extractSysMLDecisionMakers(self):
        omitKeys = ['requiredKeys', 'validator']
        self.myName = self.name
        myKeys = stripUnderscores(list(vars(self).keys()))
        for myKey in myKeys:
            if myKey in omitKeys: delattr(self,myKey)
            else: pass
        tempDecisionMakerDict = dictify(self)
        tempDecisionMakerDict['myClass'] = [tempDecisionMakerDict['myClass']] * len(tempDecisionMakerDict['myName'])
        tempDecisionMakerList = pd.DataFrame(tempDecisionMakerDict).to_dict("records")
        tempDecisionMakerList = cleanNonesFromListofDicts(tempDecisionMakerList)
        return tempDecisionMakerList
## PROCESSES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class SystemProcess(GenericClass):
    def __init__(self):
        self.requiredKeys = RequiredKeys()
        # Primitive data attributes for validation.  See validateAttributeData()
        self.name = []
        self.status = []
        self.inputOperand = []
        self.outputOperand = []
        self.requiredKeys.default = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys())-{'requiredKeys'}}
        self.requiredKeys.SoSResilience = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys()) - {'requiredKeys'}}
        # Only for initialization.  Recalculated later.
        self.varDomain = []
        self.requiredKeys.HFNMCF = {s.lstrip('_') if s.startswith('_') else s for s in set(vars(self).keys())-{'requiredKeys'}}
        self.inputOperandWeight = []
        self.outputOperandWeight = []
        self.upperBoundFlowNeg = []
        self.upperBoundFlowPos = []
        self.upperBoundStock = []
        self.lowerBoundFlowNeg = []
        self.lowerBoundFlowPos = []
        self.lowerBoundStock = []
        self.upperBoundRamp = []
        self.lowerBoundRamp = []
        self.linearCostCoeffFlowNeg = []
        self.linearCostCoeffFlowPos = []
        self.linearCostCoeffStock = []
        self.quadCostCoeffFlowNeg = []
        self.quadCostCoeffFlowPos = []
        self.quadCostCoeffStock = []
        self.duration = []
        self.initCond = []
        self.finalCond = []
        self.value = []
        # Primitive data attributes for calculation.
        self.idx = []
        self.idxProcess = []
        self.idxInputOperand = []
        self.idxOutputOperand = []
        # self.MLPNeg = []
        # self.MLPPos = []
        self.number = []
        self.numberMax = []
        self.validator = Validator()
        self.validator.keys =['upperBoundFlowNeg', 'upperBoundFlowPos','upperBoundStock',
                              'lowerBoundFlowNeg', 'lowerBoundFlowPos','lowerBoundStock',
                              'linearCostCoeffFlowNeg','linearCostCoeffFlowPos','linearCostCoeffStock',
                              'quadCostCoeffFlowNeg', 'quadCostCoeffFlowPos', 'quadCostCoeffStock',
                              'upperBoundRamp','lowerBoundRamp',
                               'duration','finalCond','initCond','value','status']
        self.validator.keyTypes = ['float','float','float',
                                   'float','float','float',
                                   'floatVector', 'floatVector','floatVector',
                                   'floatVector', 'floatVector', 'floatVector',
                                   'float','float',
                                    'int','float','float','floatVector','bool']
    @log_entry_exit_trace
    def validateProcess(self):
        self.number = len(self.name)
        self.validateProcessWeights('inputOperand', 'inputOperandWeight')
        self.validateProcessWeights('outputOperand', 'outputOperandWeight')
        self.validateAttributeData()
    @log_entry_exit_trace
    def validateProcessWeights(self, operandKey, operandWeightKey):
        # NOTE:  This function is effectively the same as validateTransitionWeights but without a FOR loop!
        # Try Block:  checking to make sure stringKey and weightStringkey have non-None values
        try:
            if getattr(self, operandKey) == [None]:
                raise AttributeError(f"Fail! {type(self).__name__} called {self.name} does not have valid values for "
                                     f"{operandKey} and {operandWeightKey}! Abort! Abort!")
        except AttributeError as e: logger.error(f"{e}"); sys.exit(1)
        operandStrings = [None] * self.number
        operandWeightStrings = [None] * self.number
        for k in range(self.number):
            # Revise systemProcess.inputOperand or systemProcess.outputOperand
            if getattr(self, operandKey)[k] == '':                              # Input/Output operand is provided as empty
                operandStrings[k] = []
            else:                                                               # Input/Output operand is provided properly.
                operandStrings[k] = (getattr(self, operandKey)[k]).split(',')
            # Revise systemProcess.inputOperandWeight or systemProcess.outputOperandWeight
            if getattr(self,operandWeightKey)[k] == '':                         # Input/Output operand weight is provided as empty
                operandWeightStrings[k] = []
            elif getattr(self, operandWeightKey)[k] == None:                    # Input/Output operand weight is not provided
                if bool(operandStrings[k]):
                    operandWeightStrings[k] = [1.0] * len(operandStrings[k])
                else:
                    operandWeightStrings[k] = []
            else:                                                   # Input/Output operand weight is provided properly
                operandWeightStrings[k] = (getattr(self, operandWeightKey)[k]).split(',')
                operandWeightStrings[k] = [float(x) for x in operandWeightStrings[k]]
            # Try Block:  checking if operands and operand weights do not have the same length
            try:
                if len(operandStrings[k]) != len(operandWeightStrings[k]):
                    raise ValueError(f"Fail! {type(self).__name__} called {self.name} does not have an equal number of "
                                     f"values for {operandKey} and {operandWeightKey}! Abort! Abort!")
            except ValueError as e: logger.error(f"Error: {e}"); sys.exit(1)
        # setattr(self, operandKey, operandStrings)         --> Don't get any crazy ideas and overcomplicate! Uncommenting this line will break things downstream!
        setattr(self, operandWeightKey, operandWeightStrings)
    @log_entry_exit_trace
    def insertProcessData(self,myProcess):
        safeKeys = ['number', 'requiredKeys', 'validator']
        tempProcess = (copy.deepcopy(myProcess)).__dict__
        for myKey in safeKeys: del tempProcess[myKey]
        self.insertAttributeDataFromDict(tempProcess, 'extend')
    @log_entry_exit_trace
    def packProcessSet(self, myOperands):
        """
        This function packs a set of processes with numpy unique.
        It also calculates the number of these processes.
        """
        self.number = len(self.name)
        # self.validateAttributeData()  --> If you validated everything earlier, then you don't need to validate here!
        idxList = sorted(np.unique(self.name, return_index=True)[1])
        idxList = [int(x) for x in idxList]
        myKeys = set(self.__dict__.keys())
        safeKeys = {'number','numberMax','idx','idxProcess','MLPNeg','MLPPos','requiredKeys','validator'}  # safeKeys are the ones that should not be calculated through setattr().
        myKeys = myKeys - safeKeys
        for myKey in myKeys:                                                    # Now packing....
            temp = getattr(self,myKey)
            if isinstance(temp, np.ndarray): setattr(self,myKey,temp[idxList])
            else: setattr(self,myKey,[temp[k] for k in idxList])

        # Postprocessing...
        self.number = len(self.name)
        self.numberMax = self.number
        self.idx = list(range(self.number)) # This is where we finally get the unique indices to all the transformation processes!
        self.idxProcess = self.idx
        self.MLPNeg = calcIncidenceMatrix(myOperands, self.inputOperand, 'col',self.inputOperandWeight)
        self.MLPPos = calcIncidenceMatrix(myOperands, self.outputOperand, 'col',self.outputOperandWeight)
    @log_entry_exit_trace
    def extractSysMLProcess(self):
        omitKeys = ['requiredKeys', 'validator']
        myKeys = stripUnderscores(list(vars(self).keys()))
        for myKey in myKeys:
            if myKey in omitKeys: delattr(self, myKey)
            else: pass
        tempProcessDict = dictify(self)
        if 'ref' in tempProcessDict.keys(): tempProcessDict['refinement'] = tempProcessDict.pop('ref')
        tempProcessDict['myName'] = tempProcessDict['name']
        # for k in range(len(tempProcessDict['varDomain'])):
        #     if tempProcessDict['varDomain'][k] != None:
        #         tempProcessDict['varDomain'][k] = ",".join(tempProcessDict['varDomain'][k])
        tempProcessList = pd.DataFrame(tempProcessDict).to_dict("records")
        tempProcessList = cleanNonesFromListofDicts(tempProcessList)
        return tempProcessList
class TransformProcess(SystemProcess):
    def __init__(self):
        SystemProcess.__init__(self)
    @log_entry_exit_trace
    def populateTransformProcess(self, myTransformProcessList):
        """
        This function populates the data attributes of an instance of the TransformProcess class.
        
        Args:
            myTransformProcessList
            
        Returns:
            myTransformProcess
        """
        self.number = len(self.name)
        self.numberMax = self.number
        self.idx = calcIndexBinA(myTransformProcessList.name, self.name)
    @log_entry_exit_trace
    def backPopulateTransformProcess(self,myTransformProcessDB,operandLookUp):
        self.idx = [myTransformProcessDB.name.index(x) for x in self.name]
        self.idxProcess = self.idx
        self.number = len(self.idx)
        self.numberMax = len(self.idx)
        self.idxInputOperand  = [[operandLookUp[x] for x in self.inputOperand[k].split(",") if x != ""]  for k in range(self.number)]
        self.idxOutputOperand = [[operandLookUp[x] for x in self.outputOperand[k].split(",") if x != ""] for k in range(self.number)]
class HoldingProcess(SystemProcess):
    def __init__(self):
        SystemProcess.__init__(self)
    @log_entry_exit_trace
    def populateHoldingProcess(self,myTransportProcesses):
        self.name = myTransportProcesses.ref
        myKeys = set(vars(self).keys()) - {'name','requiredKeys','validator'}
        for myKey in myKeys: setattr(self,myKey,getattr(myTransportProcesses,myKey))
class TransportProcess(SystemProcess):
    def __init__(self):
        SystemProcess.__init__(self)
        # Primitive data attributes for validation.  See validateAttributeData()
        self.origin = []
        self.destination = []
        self.ref = []
        self.requiredKeys.default = self.requiredKeys.default | {'origin','destination','ref'}
        self.requiredKeys.HFNMCF = self.requiredKeys.HFNMCF | {'origin','destination','ref'}
        # Primitive data attributes for calculation.
        self.nameRef = []
        self.idxOrigin = []
        self.idxDestination = []
        self.idxHolding = []
        self.idxTransport = []
        self.numberRefMax = []
    @log_entry_exit_trace
    def reviseTransportationProcessData(self):
        #Try Block: catching improperly written transportation/storage processes
        for k in range(len(self.name)):
            try:
                if 'store' in self.name[k].lower():
                    self.name[k] = self.name[k].lower()  + ' @ ' + self.origin[k]
                    self.nameRef[k] = self.name[k].lower() + ' while ' + self.ref[k]
                elif 'transport' in self.name[k].lower():
                    self.name[k] = self.name[k].lower() + ' f. ' + self.origin[k] + ' t. ' + self.destination[k]
                    self.nameRef[k] = self.name[k].lower() + ' while ' +self.ref[k]
                else: raise ValueError(f"Transportation process '{self.name[k]}' improperly written.")
            except ValueError as e: logger.error(f"{e} Begin with 'transport' or 'store' [operand]. Abort! Abort!"); sys.exit(1)
    @log_entry_exit_trace
    def populateTransportProcess(self, myBuffer, myHoldingProcess):
        """
        This function populates the data attributes of an instance of the TransportProcess class.
        
        Args:
            myBuffer
            myHoldingProcess
        """
        for k in range(len(self.name)):
            if self.origin[k].lower() == self.destination[k].lower():
                temp = self.name[k].lower()
                self.name[k] = temp.replace('transport', 'store')
        self.number = len(self.name)
        self.numberRef = len(self.nameRef)
        self.numberMax = myBuffer.number ** 2
        self.numberRefMax = self.numberMax * myHoldingProcess.number

        self.idxOrigin = calcIndexBinA(myBuffer.name, self.origin)
        self.idxDestination = calcIndexBinA(myBuffer.name, self.destination)
        self.idxHolding = calcIndexBinA(myHoldingProcess.name, self.ref)
        self.calcIdxTransportProcess(myBuffer.number)
        self.calcIdxTransportProcessRef()
    @log_entry_exit_trace
    def backPopulateTransportProcess(self,myTransportProcessDB,operandLookUp):
        idxMatch = [myTransportProcessDB.nameRef.index(x) for x in self.nameRef]
        self.idx = [myTransportProcessDB.idx[k1] for k1 in idxMatch]
        self.idxDestination = [myTransportProcessDB.idxDestination[k1] for k1 in idxMatch]
        self.idxHolding = [myTransportProcessDB.idxHolding[k1] for k1 in idxMatch]
        self.idxOrigin = [myTransportProcessDB.idxOrigin[k1] for k1 in idxMatch]
        self.idxProcess = [myTransportProcessDB.idxProcess[k1] for k1 in idxMatch]
        self.idxTransport = [myTransportProcessDB.idxTransport[k1] for k1 in idxMatch]
        self.number = len(idxMatch)
        self.numberMax = len(idxMatch)
        self.numberRefMax = len(idxMatch)
        self.idxInputOperand  = [[operandLookUp[x] for x in self.inputOperand[k].split(",") if x != ""]  for k in range(self.number)]
        self.idxOutputOperand = [[operandLookUp[x] for x in self.outputOperand[k].split(",") if x != ""] for k in range(self.number)]
    def calcIdxTransportProcess(self, numBuffers):
        """
        This function calculates the transportation process index.  By convention, the destination index increments faster
        than the origin index increments, so it is the first argument of calcVectorizedIdx().
        
        Args:
            idxOrigin: origin index
            idxDestination: destination index
            numBuffers: number of buffers   
        """

        self.idxTransport = calcVectorizedIdx(self.idxDestination, self.idxOrigin, numBuffers)
    def calcIdxTransportProcessRef(self):
        """
        This function calculates the refined transportation process index. By convention, the transportation process index
        increments faster than the holding process index, so it is the first argument of calcVectorizedIdx().
            
        Args:
            idxTransport: index of process within the set of transportation processes
            idxHolding: holding process index
            numTransportProcess:
            
        Returns:
            refined transportation process index
        """
        self.idx = calcVectorizedIdx(self.idxTransport,self.idxHolding, self.numberMax)
    @log_entry_exit_trace
    def packSetTransportProcess(self,myHoldingProcess):
        """
        This function computes the set of all possible REFINED transportation processes in the system.
        This set of processes includes storage at a certain buffer element and transportation from one buffer
        element to all other buffer elements present in the system.
        """
        self.number = len(self.name)
        # self.validateAttributeData()  --> If you validated everything earlier, then you don't need to validate here!
        idxList = sorted(np.unique(self.nameRef, return_index=True)[1])
        myKeys = set(self.__dict__.keys())
        safeKeys = {'number', 'numberMax','numberRef','numberRefMax','MLPNeg', 'MLPPos', 'idxProcess','requiredKeys','validator'}
        myKeys = set(self.__dict__.keys())
        myKeys = myKeys.difference(safeKeys)
        for myKey in myKeys:                                                    # Now packing....
            temp = getattr(self,myKey)
            if isinstance(temp, np.ndarray): setattr(self,myKey,temp[idxList])
            else: setattr(self,myKey,[temp[k] for k in idxList])

        self.number = len(self.name)
        self.numberRef = len(self.nameRef)
        self.MLPNeg = kron(myHoldingProcess.MLPNeg, np.ones([1, self.numberMax]), 'coo')
        self.MLPPos = kron(myHoldingProcess.MLPPos, np.ones([1, self.numberMax]), 'coo')
        # Not needed, but for completness:
        self.idxProcess = self.idx
## Serialization/Deserialization Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def isGitRepo(path="."):
    try:
        subprocess.check_output(["git", "rev-parse", "--is-inside-work-tree"],cwd=path,stderr=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError:
        return False
@log_entry_exit_trace
def importInputData(inputFilePath: pl.Path) -> LFES:
    """
    The function creates an LFES instance and populates it by reading
    the data stored within the specified inputFilePath. The LFES instance
    is returned.

    Note that the inputFilePath must be either an XML or a SysML file, i.e.
    its suffix must be either '.xml' or '.sysml'. If it is not,
    populateInputData will raise an error.    

    The constructor of the LFES class instantiates many of its attributes. Several
    attributes are then initialised by both populateInputData and by this function.
    This function specifically sets the following attributes:
     - inputFilePath is set to the inputFilePath argument passed to this function.
     - outputFileName is automatically set based on the name of the LFES, the inputDataFormat,
       scenario, and runCode (which is a YYYY-MM-DD string based on the git commit date).      
     - outputFilePath is by joining LFES's outputDirectory with outputFileName above.
       Note that the directory is hardcoded, and is initialised by the constructor of
       the LFES class.
     - juliaOutputFilePath is overwritten so that it is joined with outputFileName above.
       Prior to being overwritten by this function, juliaOutputFilePath is a hardcoded
       directory path (similarly set by the LFES class' constructor).
    
    Args:
        inputFilePath (pl.Path): The file path to import data from.

    Raises:
        FileNotFoundError: If the specified inputFilePath does not exist.

    Returns:
        LFES: An LFES data structure with completed analytical calculations.
    """
    # Try Block:  checking for existence of input file.
    try:
        if inputFilePath.exists():                                          # Check if path to input file exists
            update_logging_level("SUCCESS")
            logger.success(f"Importing HFGT Data: {inputFilePath} ...")
            myLFES = LFES()  # Initialize the myLFES instance.
            myLFES.inputFilePath = inputFilePath
            myLFES.populateInputData()
        else:
            raise FileNotFoundError(f"Input file {inputFilePath.absolute()} does not exist! Abort! Abort!")
    except FileNotFoundError as e: logger.error(e); sys.exit(1)
    logger.success(f"Importing HFGT Data Complete: {inputFilePath}")
    return myLFES
@log_entry_exit_trace
def configureLFESOutputPaths(myLFES: LFES, outputDirectory: str, juliaOutputDirectory: str) -> LFES:
    """Configure the output locations of the given LFES, based on outputDirectory 
    and juliaOutputDirectory.
    Sets myLFES.outputDirectory, myLFES.outputFilePath, and myLFES.juliaOutputFilePath.

    Args:
        myLFES (LFES): The LFES instance.
        outputDirectory (str): The path of the output directory.
        juliaOutputDirectory (str): The path of the Julia output directory.

    Returns:
        LFES: The LFES after it has been updated. Technically it is not necessary to return it,
              but this way the function is consistent with importInputData().
    """
    outputFileName = 'myLFES-' + myLFES.name + '-' + myLFES.inputDataFormat.value.title() + '-' + \
                      myLFES.scenario.title() + '-' + myLFES.runCode
    myLFES.outputDirectory = pl.Path(outputDirectory)
    myLFES.outputFilePath = myLFES.outputDirectory.joinpath(outputFileName + '.' + myLFES.outputFileType.value)
    myLFES.juliaOutputFilePath = pl.Path(juliaOutputDirectory).joinpath(outputFileName + '.' + myLFES.outputFileType.value)
    return myLFES
@log_entry_exit_trace
def importXMLData(xmlfile):
    """
    This function reads an XML file and outputs a Tuple with three elements.
    The first element is the tree, the second one is the root, the third is the tags.
    
    Args:
        xmlfile: Input XML file
    
    Returns:
        tree: myLFES object details
        root : Intermediary structure to feed myLFES object
        tags : myLFES meta-elements
    """
    tree = ET.parse(xmlfile)
    root = tree.getroot()
    tags = list({child.tag for child in root})
    return tree, root, tags
@log_entry_exit_trace
def loadMyData(inputFilePath):
    inputFilePath = pl.Path(inputFilePath)
    inputDirectory = inputFilePath.parent
    inputFileName = inputFilePath.name
    inputFileType = inputFilePath.suffix.lower()
    if inputFileType == '.json':
        logger.success("Loading JSON Data!")
        inputJSON = open(inputFilePath, 'rb')
        inputData = json.load(inputJSON)
        logger.success("JSON Data Loaded!")
        inputData = objectify(inputData)
    else:
        logger.error("Data format is invalid.  Choose from: .json, .xml, .bsdf, .mat, .hdf5")
        return None
    return inputData
@log_entry_exit_trace
def appendProcessCapabilities(sparseMat, myProcesses, opt,idxShift,*args):
    if len(args) > 0:   # If the optional inputs are provided they are processed..
        timeKeeper = args[0]
    # This loop is counter-intuitive.  # k represents a loop over resource index where myProcesses[k] represent the
    # processes associated with the k^th resource.  Of course, myProcess[k].number can be greater than 1 when that resource
    # can do more than one thing.
    for k in range(len(myProcesses)):       # k represents a loop over resource index.
        idxResource = k + idxShift
        if isinstance(myProcesses[k], TransformProcess):
            #logger.debug('k:', k, 'Opt:', opt, len(myProcesses))
            if 'JM' in opt: idxProcess  = myProcesses[k].idx
            elif 'KM' in opt:
                if len(myProcesses[k].status) > 0:
                    # idxProcess  = myProcesses[k].idx[not(all(myProcesses[k].status))]
                    idxProcess  = (np.array(myProcesses[k].idx, dtype=object)[not(all(myProcesses[k].status))]).tolist()
                else: idxProcess = []
            else: logger.error("Please provide an option:  JM, or KM"); sys.exit(1)
        elif isinstance(myProcesses[k], TransportProcess):
            # logger.debug('k:', k, 'Opt:', opt, len(myProcesses))
            if 'JG' in opt:
                idxProcess  = myProcesses[k].idxHolding
            elif 'KG' in opt:
                if len(myProcesses[k].status) > 0:
                    #idxProcess  = myProcesses[k].idxHolding[not(all(myProcesses[k].status))]
                    idxProcess  = (np.array(myProcesses[k].idx, dtype=object)[not(all(myProcesses[k].status))]).tolist()
                else: idxProcess = []
            elif 'JH' in opt:
                idxProcess  = myProcesses[k].idxTransport
            elif 'KH' in opt:
                if len(myProcesses[k].status) > 0:
                    # idxProcess  = myProcesses[k].idxTransport[not(all(myProcesses[k].status))]
                    idxProcess  = (np.array(myProcesses[k].idx, dtype=object)[not(all(myProcesses[k].status))]).tolist()
                else: idxProcess = []
            elif 'JR' in opt:
                idxProcess = myProcesses[k].idx
            elif 'KR' in opt:
                if len(myProcesses[k].status) > 0:
                    # idxProcess = myProcesses[k].idx[not(all(myProcesses[k].status))]
                    idxProcess  = (np.array(myProcesses[k].idx, dtype=object)[not(all(myProcesses[k].status))]).tolist()
                else: idxProcess = []
            else: logger.error("Please provide an option:  JG, KG, JH, KH, JHR, or KHR"); sys.exit(1)
        else: idxProcess = []

        if len(idxProcess) > 0:
            if 'Timed' in opt:
                if hasattr(myProcesses[k], "timeStamp"):
                    myProcesses[k].timeStamp = [float(x) for x in myProcesses[k].timeStamp]
                    idxTime = [timeKeeper.value.index(x) for x in myProcesses[k].timeStamp]
                else:
                    idxTime = np.repeat(idxTime, len(idxProcess))
                for k in range(len(idxProcess)):
                    sparseMat[idxProcess[k], idxResource, idxTime[k]] = sparseMat[idxProcess[k], idxResource, idxTime[k]] + 1
            else:
                sparseMat.row = np.append(sparseMat.row, idxProcess)
                sparseMat.col = np.append(sparseMat.col, np.repeat(idxResource, len(idxProcess)))
                sparseMat.data = np.append(sparseMat.data, np.repeat(1, len(idxProcess)))
        else: pass
    return sparseMat
@log_entry_exit_trace
def saveMyData(inputData, *args):
    # NOTE: All data will be saved as a dictionary!
    if not isinstance(inputData, dict):
        outputData = dictify(inputData)
    else: outputData = inputData
    if len(args) > 2:  # If all the optional inputs are provided, they are processed...
        args = list(args)
        if isinstance(args[0], str): args[0] = pl.Path(args[0])
        outputData['outputDirectory'] = args[0]
        outputData['outputFileName'] = args[1]
        outputData['outputFileType'] = [args[2]]
        outputData['outputFilePath'] = outputData['outputDirectory'].joinpath(
            outputData['outputFileName'] + '.' + outputData['outputFileType'][0].lower())
    elif len(args) == 2:  # If the directory and filename are provided...
        args = list(args)
        for k in range(len(args)):
            if isinstance(args[k], str): args[k] = pl.Path(args[k])
        outputData['outputDirectory'] = args[0]
        outputData['outputFileName'] = args[1].stem
        outputData['outputFileType'] = [args[1].suffix.lstrip('.')]
        outputData['outputFilePath'] = outputData['outputDirectory'].joinpath(
            outputData['outputFileName'] + '.' + outputData['outputFileType'][0].lower())
    elif len(args) == 1:  # If the entire filepath is provided...
        args = list(args)
        if isinstance(args[0], str): args[0] = pl.Path(args[0])
        outputData['outputDirectory'] = args[0].parent
        outputData['outputFileName'] = args[0].stem
        outputData['outputFileType'] = [args[0].suffix.lstrip('.')]
        outputData['outputFilePath'] = outputData['outputDirectory'].joinpath(
            outputData['outputFileName'] + '.' + outputData['outputFileType'][0].lower())
    else:
        if isinstance(outputData['outputDirectory'], dict):
            outputData['outputDirectory'] = pl.Path(outputData['outputDirectory']['value'])
            outputData['outputFilePath']  = pl.Path(outputData['outputFilePath']['value'])
        else:
            print('This condition should never happen.  I am leaving this as a placeholder for now.')
    outputData['outputDirectory'].mkdir(parents=True, exist_ok=True)
    #Try Block:  Attempting to write output file based on suffix.
    try:
        mySuffix = outputData['outputFilePath'].suffix.lower()
        if mySuffix == '.json':  # or True:
            logger.success('Beginning JSON Dump!')
            outputJSON = open(outputData['outputFilePath'], 'w')
            # Convert outputDirectory and outputFilePath to string so that they
            # may be serialized (in case they are Windows paths).
            outputData['outputDirectory'] = dictify(outputData['outputDirectory'])
            outputData['outputFilePath'] = dictify(outputData['outputFilePath'])
            json.dump(outputData, outputJSON)
            outputJSON.close()
            logger.success(f"Success! JSON Data exported to {outputData['outputFilePath']['value']}")
        elif mySuffix == '.sysml':
            exportSysMLFile(outputData, outputData['outputFilePath'])
        else:
            raise ValueError(f"Fail! The output filetype '{mySuffix}' is not supported!")
    except ValueError as e: logger.error(f"{e} Abort! Abort!"); sys.exit(1)
    return str(outputData['outputFilePath'])
@log_entry_exit_trace
def saveMatrixToCSV(outputData, outputDirectory, outputFileSuffix):
    if isinstance(outputData, dict):
        outputKeys = list(outputData.keys())
        for k in range(len(outputKeys)):
            if outputData[outputKeys[k]] is None:
                pass
            elif isinstance(outputData[outputKeys[k]],
                            (str, int, bool, float, pl.PosixPath, np.ndarray, np.int64, np.dtypes.Int64DType)):
                pass
            elif isinstance(outputData[outputKeys[k]], (list, tuple)):
                if len(outputData[outputKeys[k]]) > 0 \
                        and not isinstance(outputData[outputKeys[k]][0], (
                str, int, bool, float, pl.PosixPath, np.ndarray, np.int64, np.dtypes.Int64DType)):
                    newOutputDirectory = outputDirectory.joinpath(outputKeys[k])
                    newOutputDirectory.mkdir(parents=True, exist_ok=True)
                    for k1 in range(len(outputData[outputKeys[k]])):
                        tempOutputDirectory = newOutputDirectory.joinpath(str(k1))
                        saveMatrixToCSV(outputData[outputKeys[k]][k1], tempOutputDirectory, outputFileSuffix)
                else:
                    pass
            elif isinstance(outputData[outputKeys[k]], dict):
                newOutputDirectory = outputDirectory.joinpath(outputKeys[k])
                newOutputDirectory.mkdir(parents=True, exist_ok=True)
                saveMatrixToCSV(outputData[outputKeys[k]], newOutputDirectory, outputFileSuffix)
                del outputData[outputKeys[k]]
                if len(os.listdir(newOutputDirectory)) == 0: os.rmdir(newOutputDirectory)
            else:
                newOutputDirectory = outputDirectory.joinpath(outputKeys[k])
                newOutputDirectory.mkdir(parents=True, exist_ok=True)
                saveMatrixToCSV(outputData[outputKeys[k]], newOutputDirectory, outputFileSuffix)
                del outputData[outputKeys[k]]
                if len(os.listdir(newOutputDirectory)) == 0: os.rmdir(newOutputDirectory)
        outputFilePath = str(outputDirectory) + '-' + outputFileSuffix
        with open(outputFilePath, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=outputKeys)
            writer.writeheader()
            writer.writerows([outputData])
    elif isinstance(outputData, coo_array):
        myHeader = 'idxRow-' + str(outputData.shape[0]) + ',idxCol-' + str(outputData.shape[1]) + ',value'
        myCSVMatrix = (np.array([outputData.row, outputData.col, outputData.data])).T
        outputFilePath = str(outputDirectory) + '-' + outputFileSuffix
        np.savetxt(outputFilePath, myCSVMatrix, delimiter=',', header=myHeader, comments='')
    elif isinstance(outputData, COO):
        myHeader = ''
        for k in range(outputData.ndim):
            myHeader = myHeader + 'idxDim' + str(k) + '-' + str(outputData.shape[k]) + ','
        myHeader = myHeader + 'value'
        myCSVMatrix = (np.vstack((outputData.coords, outputData.data))).T
        outputFilePath = str(outputDirectory) + '-' + outputFileSuffix
        np.savetxt(outputFilePath, myCSVMatrix, delimiter=',', header=myHeader, comments='')
    elif isinstance(outputData, DOK):
        outputData = COO(outputData)
        saveMatrixToCSV(outputData, outputDirectory, outputFileSuffix)
    elif isinstance(outputData, list):
        outputData = {"string": outputData}
        saveMatrixToCSV(outputData, outputDirectory, outputFileSuffix)
    else:
        outputData = outputData.__dict__
        saveMatrixToCSV(outputData, outputDirectory, outputFileSuffix)
def lowerCaseFirstLetter(myString):
    myString = myString[0].lower() + myString[1:] if myString else myString
    return myString
def stripUnderscores(myInput):
    try:
        if isinstance(myInput,str):
            myOutput = myInput.lstrip('_') if myInput.startswith('_') else myInput
        elif isinstance(myInput,list):
            myOutput = [s.lstrip('_') if s.startswith('_') else s for s in myInput]
        else:
            raise TypeError(f"Expected a string or list, but received {type(myInput).__name__}.")
    except TypeError as e:
        logger.error(e)
        sys.exit(1)
    return myOutput
## SysML Specific Serialization/Deserialization Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@log_entry_exit_trace
def importSysMLFile(sysMLfile) -> dict:
    """
    This function reads an SysML file and outputs a dictionary containing the SysML Data.
    
    Args:
        sysMLfile: Input SysML file as a string or a path variable.
    
    Returns:
        mySysMLDict:  dictionary with all SysML Data
    """
    # Read entire file as a single string
    with open(sysMLfile, 'r', encoding='utf-8') as file:
        mySysMLString = file.read()
    # Exception Handling for common errors
    mySysMLString = mySysMLString.rstrip()                                  # Eliminate whitespace at EOF
    mySysMLString = regex.sub(r";\s+\n", ";\n", mySysMLString)  # Eliminate whitespace between ; and EOL
    mySysMLString = mySysMLString.replace(' ' * 4, "\t")             # Convert 4 consecutive spaces into tabs
    with open(sysMLfile, "w", encoding="utf-8") as f:                       # Overwrite the original file
        f.write(mySysMLString)
    # Make sure the SysML file begins with a package.
    if regex.search(r'^package\s+[a-zA-Z]+\s+\{.+\}', mySysMLString, regex.S):
        mySysMLString = cleanSysMLString(mySysMLString)
        mySysMLDict   = parseSysMLStringToDict(mySysMLString)
    else:
        logger.error("Error! The SysML file does not begin as a package! Abort! Abort!")
        sys.exit(1)
    return mySysMLDict
def cleanSysMLString(mySysMLString:str) -> str:
    """
    After a SysMLv2 file has been read into a single string, find the largest block greedily, clip out the enclosing curly
    brackets and return the contents.
    Args:
        mySysMLString: SysML text as a string.
    Returns:
        mySysMLString:  SysML text as a string.
    """
    # New Method:
    mySysMLString = regex.search(r'\{\s*(.+)\s*\}', mySysMLString, regex.S).group(1).rstrip()
    # Old Method -- Retain for posterity:
    # # Step 1:  Get all the text between the largest set of curly brackets
    # mySysMLString = regex.findall(r'\{.+\}', mySysMLString, regex.S)[0]
    # # Step 2:  At the beginning of the string, clip the { + whitespace to the beginning of the next SysML block
    # mySysMLString = regex.sub(r'^\{\s+', '', mySysMLString)
    # # Step 3:  At the end of the string, clip the whitespace + }.
    # mySysMLString = regex.sub(r'\s+\}$', '', mySysMLString)
    return mySysMLString
@log_entry_exit_trace
def parseSysMLStringToDict(mySysMLString:str, mySysMLDict:dict = None) -> dict:
    """
    After a SysMLv2 file has been read into a single string, and cleaned, it must be parsed into a dictionary.  This
    function proceeds iteratively through the SysML string identifying blocks along the way.  Each block is ultimately
    handled with the appendSysMLElement().
    Args:
        mySysMLString: SysML text as a string.
        mySysMLDict:  An optional seed SysML-compliant dictionary that will be grown.
    Returns:
        mySysMLDict:  A SysML-compliant dictionary after it has been grown.
    """
    # If there is no seed dictionary, create one.
    if mySysMLDict is None:
        mySysMLDict = {}

    regexPatterns = [
        # Case 0:  Regular expression for a group of single-line SysML lines with no curly brackets
        regex.compile(r'^[a-zA-Z][^{}]*;', flags=regex.S),
        # Case 1:  Regular expression for a single block of SysML lines beginning and ending with curly brackets
        regex.compile(r'.*\{(?:[^{}]++|(?0))++\}', flags=regex.X)
    ]
    # Regular expression to split a group of single-line SysML lines with no curly brakets
    splitterPattern = regex.compile(r'doc\s*/\*[^\r\n]*?\*/|[a-zA-Z][^{}]*?;',flags=regex.S)

    # Loop over each of the regular expressions testing mySysMLString for the associated type of pattern
    for k in range(len(regexPatterns)):
        # Match to the k^th regular expression
        myMatch = regexPatterns[k].search(mySysMLString)
        if myMatch:
            # Case 0:  Regular expression for a group of single-line SysML lines with no curly brackets
            if k == 0:
                # tempList contains a list of single-line SysML lines with no curly brackets
                tempList = splitterPattern.findall(myMatch.group())
                for k1 in range(len(tempList)):
                    # Append the SysML Element to the SysML Dictionary
                    mySysMLDict = appendSysMLElement(mySysMLDict, tempList[k1])
                # Retain the remainder of the SysML string
                mySysMLString = mySysMLString[len(myMatch.group()):]
                # At the beginning of the string, clip the { + whitespace to the beginning of the next SysML block
                mySysMLString = regex.sub(r'^\s+', '', mySysMLString)

            # Case 1:  Regular expression for a single block of SysML lines beginning and ending with curly brackets
            elif k == 1:    # Match a multi-line SysML element begins with a white space and ends with }
                # Break up a multi-line SysML element into its component blocks
                tempList = regexPatterns[k].findall(mySysMLString)
                # At the beginning of the string, clip the whitespace
                tempList = [regex.sub(r'^\s+', '', x) for x in tempList]
                for k1 in range(len(tempList)):
                    # Append each item of the list to the SysML dictionary
                    mySysMLDict = appendSysMLElement(mySysMLDict, tempList[k1])
            else: pass
    return mySysMLDict
def appendSysMLElement(mySysMLDict,mySysMLString,opt="default"):
    """
    After a SysMLv2 file has been read into a single string, and cleaned, it must be parsed into a dictionary.  This
    function is called by parseSysMLStringToDict() and handles each type of SysML Element.
    Args:
        mySysMLDict:  An SysML-compliant dictionary that is being grown.
        mySysMLString: The SysML text as a string.
    Returns:
        mySysMLDict:  A SysML-compliant dictionary after it has been grown.
    CONVENTIONS:  This function imposes three conventions:
        1.)  myParentClass is the name of the parent class of a given part, item, or action definition element.
        2.)  myClass is the name of the class of a given part, item, or action instance element
        3.)  myName is the name of the SysML element regardless of whether it is an instance or a definition.
        Warning!  mySysMLDict["myName"] does not always equal mySysMLDict["name"].  mySysMLDict["name"] gives the name of
        SysML instance element, whereas mySysMLDict["myName"] gives the name of the SysML element regardless of what type
        of element it is.  For example in a part def mySysMLDict["myName"] = LFES and in the same block
        mySysMLDict["name"] would not have a value because the part def has not been instantiated yet.
    """
    # These are the types of elements that one can find in a SysML file.
    # Note this list will necessarily grow to support more parts of SysML.
    # Note that these SysML v2 regular expressions are developed ad-hoc and need to be verified for compliance with the SysMLv2 standard!

    # This SysML v2 Parser supports names with the following pattern as an atomic element.
    namePattern = r"(?:[A-Za-z_][A-Za-z0-9_.-]*|'[^'\\]*(?:\\.[^'\\]*)*')"
    regexPatterns = [
        # Case 0:  A SysML View
        regex.compile(r'^view\s+?(\w.+?);'),
        # Case 1:  A SysML Part Def
        regex.compile(rf"^part\s+def\s+({namePattern})"
                      rf"(?:\s+(:>)\s+({namePattern}))?"
                      r"\s*\{.+\}",regex.M | regex.S),
        # Case 2:  A SysML Item Def
        regex.compile(rf"^item\s+def\s+({namePattern})"
                      rf"(?:\s+(:>)\s+({namePattern}))?"
                      r"\s*\{.+\}",regex.M | regex.S),
        # Case 3:  A SysML Action Def
        regex.compile(rf"^action\s+def\s+({namePattern})"
                      rf"(?:\s+(:>)\s+({namePattern}))?"
                      r"\s*\{.+\}",regex.M | regex.S),
        # Case 4:  A SysML Part
        regex.compile(rf"^part(?!\s+def\b)\s+({namePattern})"
                      rf"(?:\s*:\s*({namePattern}))?"
                      r"\s*(?:;|\{.+\})",regex.M | regex.S),
        # Case 5:  A SysML Item
        regex.compile(rf"^item(?!\s+def\b)\s+({namePattern})"
                      rf"(?:\s*:\s*({namePattern}))?"
                      r"\s*(?:;|\{.+\})",regex.M | regex.S),
        # Case 6:  A SysML Action
        regex.compile(rf"^action(?!\s+def\b)\s+({namePattern})"
                      rf"(?:\s*:\s*({namePattern}))?"
                      r"\s*(?:;|\{.+\})",regex.M | regex.S),
        # Case 7:  A SysML Attribute with a Value
        regex.compile(rf'^attribute\s+({namePattern})'
                      rf'(?:\s*:>\s*\1)?'
                      rf'(?:\s*=\s*"([^"\n]*)")?\s*;'),
        # Case 8:  A SysML Single Line Comment
        regex.compile(r'^doc\s*/\*\s*(.*?)\s*\*/$', regex.M)
    ]
    # WARNING -- KNOWN LIMITATION:  The regular expressions above assume that all 1-line parts precede part blocks.
    # WARNING -- KNOWN LIMITATION:  The regular expressions above assume that all 1-line items precede item blocks.
    # WARNING -- KNOWN LIMITATION:  The regular expressions above assume that all 1-line actions precede action blocks.

    myElements = ['view', 'part def', 'item def', 'action def', 'part','item','action','attribute','comment']
    # Initialize myKey, tempSysMLString, sysMLBlockName
    tempSysMLString = ''; myKey = ''; myValue = '';
    # Loop over each of the regular expressions testing mySysMLString for the associated type of block
    for k in range(len(regexPatterns)):
        myMatch = regexPatterns[k].search(mySysMLString)
        if myMatch:
            tempSysMLString = myMatch.group()
            # Cases 0:  A SysML View
            if k in [0]:
                myKey = myElements[k]
                myValue = myMatch.group(1).strip("'")
            # Case 1, 2, or 3:  A SysML Part Def, Item Def, or Action Def
            elif k in [1,2,3]:
                myKey    = myElements[k]
                myValue  = myMatch.group(1).strip("'")
                if myMatch.group(3) is None: myParentClass = ""
                else: myParentClass  = myMatch.group(3).strip("'")
            # Case 4 or 5:  A SysML Part or Item
            elif k in [4,5]:
                myKey = myElements[k]
                myValue = myMatch.group(1).strip("'")  # + ' : ' + myMatch.group(2)
                myClass = myMatch.group(2).strip("'")
            # Case 6:  A SysML Action
            elif k in [6]:
                myKey = myElements[k]
                myValue = myMatch.group(1).strip("'")  # + ' : ' + myMatch.group(2)
                myClass = myMatch.group(2).strip("'") if myMatch.group(2) is not None else None
            #Case 7:  A SysML Attribute with an optional a value
            elif k in [7]:
                myKey = myMatch.group(1).strip("'")
                myValue = myMatch.group(2).strip("'") if myMatch.group(2) is not None else ""
            # Case 8:  A SysML Single Line Comment
            elif k in [8]:
                return mySysMLDict
            else: pass
            break
    # Exception handling to check if SysML file has recognized each SysML element block!
    if myKey == '':
        if mySysMLString == '' or mySysMLString.isspace():
            return mySysMLDict
        else:
            logger.error('Error! The following SysML text is either improperly written or not supported! Abort! Abort!')
            logger.error(mySysMLString)
            sys.exit(1)

    if regex.search(r'\{', tempSysMLString):
        # If the tempSysMLString contains another SysML block, then the block needs to be processed recursively.
        # Get the stuff inside the quotes and nothing else.
        tempSysMLString = cleanSysMLString(tempSysMLString)
        # For Part Defs, Item Defs, and Action Defs, we need to store the parent class as an attribute.
        if k in [1, 2, 3]:
            temp = 'attribute myParentClass :> myParentClass = "' + myParentClass + '";\n'
            tempSysMLString = temp + tempSysMLString
        # For Part, Item, and Action instances, we need to explicitly insert the name of the class as an attribute.
        elif k in [4, 5,6]:
            temp = 'attribute myClass :> myClass = "' + myClass + '";\n'
            tempSysMLString = temp + tempSysMLString
        else: pass
        # Store the dictionary value into a temporary dictionary
        tempDict = dict(); tempDict['myName'] = myValue  # Validate this!
        # Now recursively parse tempSysMLString
        myValue = parseSysMLStringToDict(tempSysMLString, tempDict)
    else:
        # If a part, item, or action has class information, then turn it into a block with the class information as an
        # attribute and then the block needs to be processed recursively.
        if k in [4,5,6] and isinstance(myClass, str):
            tempSysMLString = tempSysMLString.rstrip(';') + '\{\n\tattribute myClass :> myClass = "' + myClass + '";\n\}'
            tempSysMLString = cleanSysMLString(tempSysMLString)
            # Store the dictionary value into a temporary dictionary
            tempDict = dict(); tempDict['myName'] = myValue  # Validate this!
            # Now recursively parse tempSysMLString
            myValue = parseSysMLStringToDict(tempSysMLString, tempDict)
        else: pass
    if k in [7]:
        # An Attribute with a value...
        mySysMLDict[myKey] = myValue
    else:
        # If it is the first time around, then initialize mySysMLDict[myKey] to an empty list
        if not myKey in mySysMLDict: mySysMLDict[myKey] = []
        else: pass
        mySysMLDict[myKey].append(myValue)
    return mySysMLDict
@log_entry_exit_trace
def validateSysMLDict(sysMLDict:dict, opt:str='reference', opt1='keep') ->dict:
    """Although importSysMLFile() checks for many different types of SysML syntax errors in SysMLv2 file, it doesn't make
    any semantic checks.  This function checks if an arbitrary diction is "SysML compliant".

    If opt == instantiated, it makes sure that the SysML dictionary is composed exclusively in terms of keys that are SysML reserved words.
    If opt == reference, it makes sure that the SysML dictionary is composed exclusively in terms of keys that are SysML part, item, and action.
    If opt1 == None, then the original sysMLDict is not revised during validation.
    If opt1 == revise, then the original sysMLDict is revised during validation
    If the SysML dictionary contains a reference architecture, it then proceeds to validate dictionary against this
    reference architecture.  In some cases, the validation will correct minor inconsistencies in the dictionary.
    Args:
        sysMLDict (dict): The dictionary produced when importSysMLFile() is run on a SysMLv2 file.
        opt (str - optional):  reference for a reference architecture, instantiated for an instantiated architecture
    Returns:
        dict: The validated dictionary with minor modifications.
    """
    refElements = ['part def', 'item def', 'action def']
    try:
        if opt == 'instantiated':
            elementTypes = ['part def', 'item def', 'action def', 'part', 'item', 'action']
        elif opt == 'reference':
            elementTypes = refElements
        else:
            raise ValueError('The second argument must be either \"instaniated\" or \"reference\"!  Abort! Abort!')
        neglectedKeys = set(['view','outputDirectory','outputFileName','outputFileType','outputFilePath'])
        sysMLDictKeys = set(sysMLDict.keys()) - neglectedKeys
        if not sysMLDictKeys <=  set(elementTypes):
            if opt == 'instantiated':
                raise ValueError('The instantiated architecture is not stated exclusively in terms of SysML elements! Abort! Abort!')
            else:
                raise ValueError('The reference architecture is not stated exclusively in terms of part defs, item defs, and action defs! Abort! Abort!')
    except ValueError as e:
        logger.error(e)
        sys.exit(1)
    if opt1 is not None:
        if any(myKey in sysMLDict for myKey in refElements):
            sysMLDict = validateSysMLArchitectureDict(sysMLDict,opt1)
    else: pass
    return sysMLDict
@log_entry_exit_trace
def validateSysMLArchitectureDict(sysMLDict: dict, opt='keep') -> dict:
    """Although importSysMLFile() checks for many different types of SysML syntax errors in SysMLv2 file, it doesn't make
    any semantic checks.  This function checks the semantics of the SysMLv2 file based upon the tests identified below.
    In certain relatively benign cases, the function will regularize/correct the dictionary and proceed
    Args:
        sysMLDict (dict): The dictionary produced when importSysMLFile() is run on a SysMLv2 file.
        If opt1 == None, then the original sysMLDict is not revised during validation.
        If opt1 == revise, then the original sysMLDict is revised during validation
    Returns:
        bool: True if function completed successfully.
    """
    # Section 1:  Validate the part defs, item defs, and action defs.
    sysmlDefTypes = ['part def', 'item def', 'action def']
    sysMLDictRef =copy.deepcopy({k: sysMLDict[k] for k in sysmlDefTypes if k in sysMLDict})
    # Loop over part defs, item defs, and action defs.
    # Note:  In accordance with the SysML standard, definitions do not contain other definitions.
    for myDefType in sysmlDefTypes:
        if myDefType in sysMLDictRef:
            # Create a hash table with the names of all the defs and their index.
            idxMap = {sysMLDictRef[myDefType][k]['myName']: k for k in range(len(sysMLDictRef[myDefType]))}
            for childDict in sysMLDictRef[myDefType]:
                # Make sure that the keys of the dictionary are sorted.
                try:
                    # If no parent class has been defined, then it needs to be stated explicitly.
                    if not 'myParentClass' in childDict:
                        childDict['myParentClass'] = ''
                    # Check all part defs, item defs, and action defs that have parents.
                    if childDict['myParentClass'] != '':
                        myName = childDict['myName']
                        # Test 1:  Does the child instance have all the attributes of the parent class?
                        parentDict = regularizeSysMLDict(sysMLDictRef[myDefType][idxMap[childDict['myParentClass']]],'flat')
                        parentDict = sortDictionaryKeys(parentDict)
                        childDict  = regularizeSysMLDict(childDict,'flat')
                        childDict = sortDictionaryKeys(childDict)
                        if not parentDict.keys() <= childDict.keys():
                            raise ValueError(f"This part def {myName} does not contain the following "
                                             f"attributes of the parent class: {parentDict.keys()-childDict.keys()}. Abort! Abort!")
                        # Test 2:  Does the child instance adopt all the non-trivial default values of the parent class?
                        tempDict = parentDict | {k:v for k,v in childDict.items() if v != ""}
                        if not all(tempDict[k] == childDict[k] for k in tempDict.keys() & childDict.keys()):
                            diff = [list(childDict.keys())[i] for i, (a, b) in enumerate(zip(parentDict.values(), childDict.values())) if a != b]
                            raise ValueError(f"The default values of this {myDefType} {myName} are not equivalent "
                                             f" to those of its parent at keys: {diff}. Abort! Abort!")
                    else: pass
                except ValueError as e:
                    logger.error(e)
                    sys.exit(1)

    # Section 2:  Validate the part, item instances.
    sysmlObjTypes = ['part','item','action']
    sysMLDictInst = copy.deepcopy({k: sysMLDict[k] for k in sysmlObjTypes if k in sysMLDict})
    sysMLDictInst = validateSysMLDictInstances(sysMLDictInst,sysMLDictRef)

    # Section 3:  Revise the original SysMLDict with the updated SysML Reference and Instantiated Architectures
    if opt == 'revise':
        sysMLDict = sysMLDict | sysMLDictRef
        sysMLDict = sysMLDict | sysMLDictInst
    return sysMLDict
@log_entry_exit_trace
def validateSysMLDictInstances(sysMLDict:dict, sysMLDictRef:dict) ->dict:
    sysmlDefTypes = ['part def', 'item def', 'action def']
    sysmlObjTypes = ['part', 'item', 'action']
    # Loop over part, item, and action INSTANCES.
    for k in range(len(sysmlObjTypes)):
        if sysmlObjTypes[k] in sysMLDict:
            # Create hash map of def names and their indices.
            idxMap = {sysMLDictRef[sysmlDefTypes[k]][k1]['myName']: k1 for k1 in range(len(sysMLDictRef[sysmlDefTypes[k]]))}
            # Loop over instances of each type
            for k1 in range(len(sysMLDict[sysmlObjTypes[k]])):
                # Isolate the instance from the list of dictionaries
                instanceDict = sysMLDict[sysmlObjTypes[k]][k1]
                # In certain situations, instanceDict can be a string.  So we don't need do anything unless it is a dict.
                if isinstance(instanceDict,dict):
                    # Isolate the associated definition dictionary
                    defDict = regularizeSysMLDict(sysMLDictRef[sysmlDefTypes[k]][idxMap[instanceDict['myClass']]],'flat')
                    # Isolate the parts, items, and actions of the instance and then validate them
                    sysMLDictInst = {k: instanceDict[k] for k in sysmlObjTypes if k in instanceDict}
                    if sysMLDictInst:
                        sysMLDictInst = validateSysMLDictInstances(sysMLDictInst, sysMLDictRef)
                        instanceDict = instanceDict | sysMLDictInst
                    else: pass
                    # Since it is unlikely that the user will input the parent class of each instance element, this inserts
                    # that information for downstream usage.
                    if 'myParentClass' not in instanceDict:
                        instanceDict['myParentClass'] = defDict['myParentClass']
                    # Sort keys of the instance dictionary
                    instanceDict = sortDictionaryKeys(instanceDict)
                    try:
                        if instanceDict['myClass'] != '':
                            # Test 3:  Does the child instance have all attributes of the class definition?
                            if not defDict.keys() <= instanceDict.keys():
                                raise ValueError(f"This part {instanceDict['myName']} does not contain the following "
                                                 f"attributes of the associated part def: {defDict.keys() - instanceDict.keys()}. Abort! Abort!")
                        else: pass
                        # Test 4:  Does the child instance explicitly state what the parent class is?
                        if 'myParentClass' not in instanceDict:
                            raise ValueError(f"This part {instanceDict['myName']} does not explicitly state its parent classs!"
                                             f"Insert myParentClass :> myParentClass = \"Name of Parent Class\";  Abort! Abort!")
                        else: pass
                    except ValueError as e:
                        logger.error(e)
                        sys.exit(1)
                    sysMLDict[sysmlObjTypes[k]][k1] = instanceDict
                else: pass
    return sysMLDict
@log_entry_exit_trace
def regularizeSysMLDict(sysMLDictOld:dict, opt=None) ->dict:
    """SysMLv2 provides the user with a certain amount of flexibility in how to write the SysMLv2 file. Two SysMLv2 files
    can be syntactically different but essentially mean the same thing.  This function accounts for this flexibility and
    translates different cases into a single regular format dictionary.
    Args:
        sysMLDict (dict): The dictionary produced when importSysMLFile() is run on a SysMLv2 file. It pertains to a
        single part def, item def, action def, part instance, item instance, or action instance.
    Returns:
        sysMLDict (dict): The regularized SysML Dictionary.
    """
    sysMLDict = copy.deepcopy(sysMLDictOld)
    # Case 1:  When importSysMLFile() is called, it puts all attributes without values in a list under the dictionary's
    # "attribute" key.  Users who don't know the value of an attribute should not have to specify the value as an empty
    # string.  This transforms these attributes into attributes with empty strings.
    if 'attribute' in sysMLDict.keys():
        for k in range(len(sysMLDict['attribute'])):
            sysMLDict[sysMLDict['attribute'][k]] = ""
        del sysMLDict['attribute']
    # Case 2:  Eliminate key value pairs tied to SysML reserved words.
    if opt == 'flat':
        neglectedKeys = ['view','part','item','action','attribute']
        for myKey in neglectedKeys:
            if myKey in sysMLDict.keys(): del sysMLDict[myKey]
    return sysMLDict
def convertCSV2SysML(inputFilePath,className,idxColUID):
    inputFilePath = pl.Path(inputFilePath)  # Convert input file path string to Path object.
    df = pd.read_csv(inputFilePath)
    mySysMLDict = df2SysMLDict(df, className, idxColUID)
    outputFilePath = str(inputFilePath.parent.parent.parent) + '/3_PyHFGT_Output_Data/' + inputFilePath.stem + '.sysml'
    myResult = exportSysMLFile(mySysMLDict, outputFilePath)
    return outputFilePath
@log_entry_exit_trace
def exportSysMLFile(sysMLDict: dict, outputFilePath: str) -> bool:
    """Export the given SysML-Compliant Dictionary to the given outputFilePath as SysML text.s
    Args:
        sysMLDict (dict): The dictionary containing the data to export to a .sysml file.
        outputFilePath (str): The path in which to write the SysML data to.

    Returns:
        bool: True if function completed successfully.
    """

    sysMLDict = validateSysMLDict(sysMLDict,'instantiated',None)
    outputSysML = open(outputFilePath, 'w', encoding='utf-8')
    outputSysML.write("package Model {\n")
    for myKey in sysMLDict:
        exportSysMLKey(sysMLDict, myKey, outputSysML)
    outputSysML.write('}')
    outputSysML.close()
    return True
def exportSysMLKey(outputData: dict, myKey: str, outputSysML: str, depth: int = 1) -> bool:
    """Export the data corresponding to a particular key in outputData
    to the outputSysML file.
    It is handled differently depending on whether it is a package,
    definition (view, part def, item def, action def, metadata def, enum def) or
     a part,item, action, or metadata.

    Args:
        sysMLDict (dict): The dictionary containing the data to export to
           a .sysml file.
        myKey (str): The key from outputData to process.
        outputSysML (str): The current output string representing the SysML model.
        depth (int, optional): The depth (number of tabs) in which to write to
           outputSysML. Defaults to 1.

    Returns:
        bool: True if function completed successfully.
    """
    if myKey.startswith("package"):
        outputSysML.write('\t' * depth + myKey + ' {\n')
        # Export all data residing within the package at one extra tab level.
        # This allows for the export of packages within packages, etc, at any
        # level of nesting.
        for innerKey in outputData[myKey]:
            exportSysMLKey(outputData[myKey], innerKey, outputSysML, depth + 1)
        outputSysML.write('\t' * depth + '}\n')
    elif myKey in ['view', 'part def', 'item def', 'action def', 'metadata def',
                   'enum def']:  # Check that the key is a valid SysML keyword
        exportSysMLDefs(outputData, myKey, outputSysML, depth)
    elif myKey in ['part', 'item', 'action', 'metadata']:
        exportSysMLInstances(outputData, myKey, outputSysML, depth)
    return True
@log_entry_exit_trace
def exportSysMLDefs(outputData, myKey, outputSysML, depth):
    """Export any SysML definitions (part, item, action) that exist within outputData.

    Args:
        outputData (dict): The dictionary containing the data to export to a .sysml file.
        myKey (str): The key from outputData to process.
        outputSysML (str): The current output string representing the SysML model.
        depth (int, optional): The depth (number of tabs) in which to write to
           outputSysML.

    Returns:
        bool: True if function completed successfully.
    """
    if myKey == "metadata def":
        outputSysML.write('\t' * depth + "import ScalarValues::**;\n")
    if outputData[myKey] is None: outputData[myKey] = []
    for k in range(len(outputData[myKey])):  # Loop over the instances of that SysML keyword
        if myKey[k] == "myClass":
            continue
        # If the instance is a string ...
        if isinstance(outputData[myKey][k], str):
            outputSysML.write('\t' * depth + myKey + ' ' + outputData[myKey][k] + ';\n')
        # If the instance is a dictionary ...
        elif isinstance(outputData[myKey][k], dict):
            # First write the name of the SysML Element Definition.
            if isinstance(outputData[myKey][k]['myName'], list):
                # Warning:  This case may be obsolete and can perhaps be eliminated.  (Amro says)
                outputSysML.write('\t' * depth + myKey + ' ' + str(outputData[myKey][k]['myName'][0]) + ' {\n')
            else:
                outputSysML.write('\t' * depth + myKey + ' ' + str(outputData[myKey][k]['myName']) + ' {\n')
            # For all the attribute names that have been grouped under the 'attribute' key, write them without values.
            if 'attribute' in outputData[myKey][k]:
                for k1 in range(len(outputData[myKey][k]['attribute'])):
                    outputSysML.write('\t' * (depth + 1) + ('attribute ' if myKey != "enum def" else "") +
                                      outputData[myKey][k]['attribute'][k1] + ';\n')
            # Now identify all the remaining attributes that need to be processed.
            # Note:  The usage of lists is necessary to preserve the order of the keys which matters for round-trip functionality!
            attributeSet = [x for x in outputData[myKey][k] if x not in {'myName', 'myParentClass', 'attribute'}]
            for myAttribute in attributeSet:
                # This is the case where the attribute does not have a value
                if outputData[myKey][k][myAttribute] == '':
                    outputSysML.write('\t' * (depth + 1) + ('attribute ' if myKey != "enum def" else "") + myAttribute + ';\n')
                # This is the case where the attribute does have a value
                else:
                    print('hello')
            outputSysML.write('\t' * depth + '}\n')
    return True
@log_entry_exit_trace
def exportSysMLInstances(outputData: dict, myKey: str, outputSysML: str, depth: int = 1) -> bool:
    """Export any instances (part, item, action) that exist within outputData.

    Args:
        outputData (dict): The dictionary containing the data to export to
            a .sysml file.
        myKey (str): The key from outputData to process.
        outputSysML (str): The current output string representing the SysML model.
        depth (int, optional): The depth (number of tabs) in which to write to
           outputSysML. Defaults to 1.

    Returns:
        bool: True if function completed successfully.
    """
    for k in range(len(outputData[myKey])):  # Loop over instances
        tempDict = copy.deepcopy(outputData[myKey][k])  # Pulling out instance dictionary
        # If "myName" is not present in tempDict, ensure that myKey == "metadata"
        # otherwise raise an error.
        # This is needed because metadata does not require a name, just a class
        # (e.g. metadata MyMetadata and not metadata "name" : myMetadata).
        if "myName" not in tempDict and myKey != "metadata":
            raise ValueError("myName must be present.")
        if "myName" in tempDict:
            # Make sure instance name is the right format.
            if isinstance(tempDict['myName'], list):
                tempName = str(tempDict['myName'][0])
            else:
                tempName = str(tempDict['myName'])
        # Make sure the instance class is the right format
        if isinstance(tempDict['myClass'], list):
            tempClass = str(tempDict['myClass'][0])
        else:
            tempClass = str(tempDict['myClass'])
        # Write the first line of the instance
        if myKey == "metadata":
            outputSysML.write('\t' * depth + "import DatasetMetadata::**;\n")
            outputSysML.write('\t' * (depth) + myKey + ' ' + tempClass + ' {\n')
        else:
            outputSysML.write('\t' * (depth) + myKey + ' \'' + tempName + '\' : ' + tempClass + ' {\n')
            del tempDict['myName']
        del tempDict['myClass']
        # Create key list that does not include parts, items, and actions
        smallDictKeys = [x for x in tempDict.keys() if x not in ['part', 'item', 'action']]
        # Write each of these keys as attributes with their values.
        for myKey1 in smallDictKeys:
            # Metadata attributes do not need "attribute key :>" in front of them
            # (and this breaks the syntax).
            attributeStr = 'attribute ' + myKey1 + ' :> '
            if myKey == "metadata":
                attributeStr = ""
            if isinstance(tempDict[myKey1], list):
                outputSysML.write('\t' * (depth + 1) + attributeStr + myKey1 + ' = \"'
                                  + str(tempDict[myKey1][0]).replace('"',"'") + '\";\n')
            else:
                # Any strings containing :: are references to enum values, and
                # processed differently (no quotes around them).
                # (note the very hacky check for not starting with http - I was finding
                # some URLs had double colons in them, and had to find a way to ensure they still
                # were outputted properly (MS)
                outputValue = str(tempDict[myKey1]).replace('"', "'").replace("\n", " ")
                # # Amro is eliminating this truncating behavior because it is causing bugs in the latest set of tests.
                # # Truncating to 50 characters (for now)
                # if len(outputValue) >= 50:
                #     outputValue = outputValue[:50] + "..."
                if isinstance(tempDict[myKey1], str) and "::" in tempDict[myKey1] and not tempDict[myKey1].startswith(
                        "http"):
                    outputSysML.write('\t' * (depth + 1) + attributeStr + myKey1 + ' = ' + outputValue + ';\n')
                else:
                    outputSysML.write('\t' * (depth + 1) + attributeStr + myKey1 + ' = \"' + outputValue + '\";\n')
        # Create key list for parts, items, and actions.
        smallDictKeys = [x for x in tempDict.keys() if x in ['part', 'item', 'action']]
        # These need to be handled recursively.
        for myKey1 in smallDictKeys:
            exportSysMLInstances(tempDict, myKey1, outputSysML, depth + 1)
        # Write the last line of the instance as a closed bracket.
        outputSysML.write('\t' * (depth) + '}\n')
    return True
@log_entry_exit_trace
def df2SysMLDict(df: pd.DataFrame, myClass: Optional[str] = None, idxColumnName: Optional[str] = None) -> dict:
    """Given a Pandas DataFrame, and the name that should be assigned
    to each instance (e.g. "Substation", "Power Plant", etc), and the
    name of the column that uniquely identifies each row, convert the
    DataFrame into a SysML-compliant dictionary.

    Note: Originally idxColumnName was 'idxColumn' (the index of the
    column which is the identifier), but I (MS) changed this to
    idxColumnName as I felt it made more sense and was easier to use
    (no need to figure out the index of the id column, and no issue if
    the id column is a different column index when calling this function
    across multiple files such as via GISDirectory2SysMLFile).

    Args:
        df (pd.DataFrame): The input Pandas DataFrame.
        myClass (str): The name that should be assigned to each instance.
           If None, each instance will have the class "Object".
        idxColumnName (str): The name of the column that uniquely identifies
           each row, which will appear as the name of each item in the SysML
           dictionary. If None, the id will be generated as Object1, Object2
           and so on.

    Returns:
        dict: A SysML-compliant dictionary representing the DataFrame.
    """

    # Rename any problematic column names e.g. state, which conflict with
    # SysML keywords
    df.rename(columns={
        "state": "state_"
    }, inplace=True)

    sysMLDict = dict()
    sysMLDict['part def'] = [dict()]

    # Normalise column names by replacing any unwanted characters
    df.columns = df.columns.str.replace('₂', '2')
    df.columns = df.columns.str.replace("'", '"')

    mySysMLClass = myClass if myClass is not None else "Object"
    df['myClass'] = mySysMLClass

    sysMLDict['part def'][0]['attribute'] = list(df.columns)
    sysMLDict['part def'][0]['myName'] = mySysMLClass

    # If no idxColumName is provided, generate one (Object1, Object2, and so on).
    if idxColumnName is None:
        df['myName'] = ['Object' + str(i) for i in range(1, len(df) + 1)]
    else:
        # Try Block:  Attempt to find the idxColumn name. If it does not exist, log an error and exit.
        try:
            df['myName'] = df[idxColumnName]
        except KeyError as e: logger.error(f"Error: column '{idxColumnName}' does not appear in DataFrame."); sys.exit(1)
    sysMLDict['part'] = df.to_dict(orient="records")
    return sysMLDict
@log_entry_exit_trace
def GISDirectory2SysMLDict(inputDirectoryPath: str, className: str, idxColumnName: str,
                           maxRows: Optional[int] = None) -> dict:
    """Given a directory as input, process all GIS-type files into a SysML-
    compliant Dictionary via the relevant function.
    The GIS files in the directory must be either .csv or .shp files to be processed.
    Any non .csv or .shp files will be skipped.

    Args:
        inputDirectoryPath (str): The path of the input directory.
        className (str): The name that should be assigned to each instance
           in the model (e.g. "Substation", "Power Line", etc).
        idxColumnName (str): The name of the index column, which uniquely
           identifies each row. Note that each GIS file will need to use the
           same column name as an identifier.
        maxRows (int, Optional): The maximum number of rows to process for each
           dataset. If None, process all rows.

    Returns:
        dict: The LFES package representing the SysML model.
    """

    files = [f for f in os.listdir(inputDirectoryPath)]
    # Iterate over each file in the directory, processing them if they are
    # either .csv or .shp.
    # Add each of the resulting LFES to the overarching LFES (myLFESPackage).
    myLFESPackage = {}
    for fp in files:
        inputFilePath = os.path.join(inputDirectoryPath, fp)
        inputFiletype = pl.Path(inputFilePath).suffix
        if inputFiletype not in (".csv", ".shp"):
            continue
        args = (inputFilePath, className, idxColumnName, maxRows)
        if inputFiletype == ".csv":
            myLFES = CSV2SysMLDict(*args)
        elif inputFiletype == ".shp":
            myLFES = Shapefile2SysMLDict(*args)
        package_name = fp.replace('.', '__')
        if package_name[0].isdigit():
            package_name = "_" + package_name
        myLFESPackage[f"package {package_name}"] = myLFES
    return myLFESPackage
@log_entry_exit_trace
def GISDirectory2SysMLDictAuto(inputDirectoryPath: str, maxRows: Optional[int] = None,
                               maxFilesPerDirectory: Optional[int] = None) -> dict:
    """Given a directory as input, process all GIS-type files into a SysML-
    compliant Dictionary via the relevant function.
    The GIS files in the directory must be either .csv or .shp files to be processed.
    Any non .csv or .shp files will be skipped.

    For each GIS file, if it is accompanied by a .yml file,
    whose filename is exactly the same as the file to which it refers
    (e.g. "data1.csv" is sitting alongside a .yml file called "data1.csv.yml"),
    it will be processed according to the instructions in that .yml file.
    If present, the .yml file must contain two keys:
     - class_name: The name of the class, e.g. "PowerPlant".
     - idx_column_name: The name of the column that uniquely identifies each row,
       e.g. "name".
    It can also contain:
     - max_rows: The maximum number of rows to process. If this key is not present,
       the value from maxRows (the argument to this function) will be used instead.

    If a GIS file is not accompanied by a .yml file, it will be processed
    as if its class_name is "Object", and each object will be assigned an
    increasing id ("Object1", "Object2", etc). In this way, the .yml files are not
    required - they just improve the model.

    Args:
        inputDirectoryPath (str): The path of the input directory.
        maxRows (int, Optional): The maximum number of rows to process for each
           dataset. If max_rows is present in a dataset's corresponding .yml file,
           this value will be overridden.
        maxFilesPerDirectory (int, Optional): The maximum number of files to process
           in each directory. (useful when there may be directories containing 1000s
           of CSV files that you don't need to include in the model.

    Returns:
        dict: The LFES package representing the SysML model.
    """
    files = [f for f in os.listdir(inputDirectoryPath)]
    if maxFilesPerDirectory:
        files = files[:maxFilesPerDirectory]
    # Iterate over each file in the directory, processing them if they are
    # either .csv or .shp file.
    # Add each of the resulting LFES to the overarching LFES (myLFESPackage).
    myLFESPackage = {}
    for fp in files:
        inputFilePath = os.path.join(inputDirectoryPath, fp)
        inputFiletype = pl.Path(inputFilePath).suffix
        if inputFiletype not in (".csv", ".shp"):
            continue

        # Set className and idxColumnName to None by default
        # (they can be overridden by the .yml file if present).
        className = None
        idxColumnName = None

        # Check for the existence of the .yml file.
        # If present, load className, idxColumnName, and maxRows from it.
        ymlFile = os.path.join(inputDirectoryPath, f"{fp}.yml")
        if os.path.exists(ymlFile):
            with open(ymlFile, "r", encoding="utf-8") as f:
                yamlData = yaml.load(f.read(), Loader=yaml.BaseLoader)
            if "class_name" in yamlData:
                className = yamlData["class_name"]
            if "idx_column_name" in yamlData:
                idxColumnName = yamlData["idx_column_name"]
            if "max_rows" in yamlData:
                maxRows = int(yamlData["max_rows"])

        args = (inputFilePath, className, idxColumnName, maxRows)
        if inputFiletype == ".csv":
            # Try Block:  safely reading CSV file.
            try:
                myLFES = CSV2SysMLDict(*args)
            except Exception as e:
                logger.error("Error reading CSV: ")
                logger.error(str(e))
                break
        elif inputFiletype == ".shp":
            #Try Block:  safely reading Shapefile
            try:
                myLFES = Shapefile2SysMLDict(*args)
            except Exception as e:
                logger.error("Error reading shapefile: ")
                logger.error(str(e))
                break
        # package_name = fp.replace('.', '__').replace(" ", "_").replace("&", "And").replace("(", "").replace(")", "").replace("-", "_").replace("+", "_")
        # if package_name[0].isdigit():
        #    package_name = "_" + package_name
        package_name = fp.replace("'", '"')
        myLFESPackage[f"package '{package_name}'"] = myLFES
    return myLFESPackage
@log_entry_exit_trace
def GISDirectory2SysMLFile(inputDirectoryPath: str, outputFilePath: str, className: str, idxColumnName: str) -> bool:
    """Given a directory as input, process all GIS-type files into a SysML
    file via the relevant function and save the file to outputFilePath.
    The GIS files in the directory must be either .csv or .shp files to be processed.
    Any non .csv or .shp files will be skipped.

    Args:
        inputDirectoryPath (str): The path of the input directory.
        outputFilePath (str): The path to save the sysml file to.
        className (str): The name that should be assigned to each instance
           in the model (e.g. "Substation", "Power Line", etc).
        idxColumnName (str): The name of the index column, which uniquely
           identifies each row. Note that each GIS file will need to use the
           same column name as an identifier.

    Returns:
        bool: True if function completed successfully.
    """
    myLFESPackage = GISDirectory2SysMLDict(inputDirectoryPath, className, idxColumnName)
    saveMyData(myLFESPackage, outputFilePath)
    return True
@log_entry_exit_trace
def GIS2SysMLFile(inputFilePath: str, outputFilePath: str, className: str, idxColumnName: str):
    """Given a filepath as input, process it into a SysML
    file via the relevant function and save the file to outputFilePath.
    The input file must be either a .csv or a .shp file, otherwise
    an error will be raised.

    Args:
        inputFilePath (str): The path of the input file.
        outputFilePath (str): The path to save the sysml file to.
        className (str): The name that should be assigned to each instance
           in the model (e.g. "Substation", "Power Line", etc).
        idxColumnName (str): The name of the index column, which uniquely
           identifies each row.

    Raises:
        ValueError: If the filetype is not supported.

    Returns:
        bool: True if function completed successfully.
    """
    inputFiletype = pl.Path(inputFilePath).suffix
    args = (inputFilePath, className, idxColumnName)
    if inputFiletype == ".csv":
        myLFES = CSV2SysMLDict(*args)
    elif inputFiletype == ".shp":
        myLFES = Shapefile2SysMLDict(*args)
    else:
        raise ValueError(f"Filetype '{inputFiletype}' is not supported.")
    saveMyData(myLFES, outputFilePath)
    return True
@log_entry_exit_trace
def Shapefile2SysMLDict(inputFilePath: str, className: str, idxColumnName: str, maxRows: Optional[int] = None) -> dict:
    """Given a .shp filepath as input, process it into a SysML
    file via df2SysMLDict and save the file to outputFilePath.

    Args:
        inputFilePath (str): The path of the input .shp file.
        outputFilePath (str): The path to save the sysml file to.
        className (str): The name that should be assigned to each instance
           in the model (e.g. "Substation", "Power Line", etc).
        idxColumnName (str): The name of the index column, which uniquely
           identifies each row.
        maxRows (int, Optional): The maximum number of rows to process.

    Returns:
        dict: A SysML-compliant dictionary representing the model.
    """
    logger.info(f"Loading {inputFilePath}")
    if maxRows is not None:
        # Use pyogrio to avoid having to read the entire file and slicing.
        # This way only the first maxRows rows are loaded.
        gdf = gpd.read_file(inputFilePath, engine='pyogrio', max_features=maxRows)
    else:
        gdf = gpd.read_file(inputFilePath)
    del gdf["geometry"]  # Deleting this for now as it doesn't make sense
    # in a SysML context - perhaps it's worth adding though
    # (I am just not sure how to represent it) - MS
    myLFES = df2SysMLDict(gdf, className, idxColumnName)
    return myLFES
@log_entry_exit_trace
def CSV2SysMLDict(inputFilePath, className, idxColumnName, maxRows: Optional[int] = None) -> dict:
    """Given a .csv filepath as input, process it into a SysML
    file via df2SysMLDict and save the file to outputFilePath.

    Args:
        inputFilePath (str): The path of the input CSV file.
        outputFilePath (str): The path to save the sysml file to.
        className (str): The name that should be assigned to each instance
           in the model (e.g. "Substation", "Power Line", etc).
        idxColumnName (str): The name of the index column, which uniquely
           identifies each row.
        maxRows (Optional, int): The maximum number of rows to process.

    Returns:
        dict: A SysML-compliant dictionary representing the model.
    """
    logger.info(f"Loading {inputFilePath}")

    if maxRows is not None:
        df = pd.read_csv(inputFilePath, nrows=maxRows, encoding='utf-8')
    else:
        df = pd.read_csv(inputFilePath, encoding='utf-8')

    sysMLDict = df2SysMLDict(df, className, idxColumnName)
    return sysMLDict
## Data Type Management Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def dictify(myInput,opt='serialize'):
    if myInput is None: return(None)
    elif isinstance(myInput, (str,bool,int)): return(myInput)
    elif isinstance(myInput,Enum): return(myInput.value)
    elif isinstance(myInput, float):
        if myInput.is_integer(): return(int(myInput))
        else: return(myInput)
    elif isinstance(myInput,(np.int64,np.dtypes.Int64DType)): return(int(myInput))
    elif isinstance(myInput, np.ndarray):
        if len(myInput.shape) == 2 and myInput.shape[0] == 1:
            return(dictify(myInput[0].tolist(),opt))
        else: return(dictify(myInput.tolist(),opt))
    elif isinstance(myInput,tuple): return(dictify(list(myInput),opt))
    elif isinstance(myInput,set): return(dictify({"value": sorted(myInput), "myClass": "Set"}))
    elif isinstance(myInput, (pl.PurePath)): return(dictify({"value": str(myInput), "myClass": "Path"}))
    elif isinstance(myInput, list):
        if isSimpleList(myInput): return(myInput)
        else:
            # logger.debug('Dictifying a complex list...')
            myOutput = [dictify(myInput[k], opt) for k in range(len(myInput))]
            # logger.debug('Dictifying a complex list:  Finished.')
            return myOutput
    elif isinstance(myInput,(DOK,COO,coo_array)): return(dictify(SparseMAT(myInput),opt))
    elif isinstance(myInput,(csc_array)):
        logger.warning("Warning!  Serialization/Deserialization of CSC_Arrays is not supported! Data will be lost!")
        # As a matter of architectural design, the HFGT Toolbox should not have any other sparse matrix formats other than DOK, COO, coo_array, or SparseMAT.
        # Introducing other formats complicates the computational architecture and must be avoided!
        return(dictify(SparseMAT(myInput),opt))
    elif isinstance(myInput,dict):
        # logger.debug('Dictifying a dictionary...')
        myOutput = dict()
        for k, v in myInput.items():
            new_k = k.lstrip("_") if k.startswith("_") else k
            # logger.debug(f"Dictionary Key: {new_k}")
            myOutput[new_k] = dictify(v, opt)
        # logger.debug('Dictifying a dictionary: Finished')
        return myOutput
    else:
        # logger.debug('Dictifying an object...')
        temp = {**vars(myInput),  'myClass': type(myInput).__name__}
        myOutput = dictify(temp, opt)
        return myOutput
def isSimpleList(myInput):
    if len(myInput) == 0: return True
    elif all(x is None for x in myInput): return True
    elif isinstance(myInput[0],(str,bool,int)): return True
    elif isinstance(myInput[0],float) and not myInput[0].is_integer(): return True
    elif isinstance(myInput[0],list): return isSimpleList(myInput[0])
    else: return False
def sortDictionaryKeys(myInput, opt=True):
    if isinstance(myInput, dict):
        items = sorted(myInput.items()) if opt else myInput.items()
        return {k: sortDictionaryKeys(v) for k, v in items}
    elif isinstance(myInput, list):
        return [sortDictionaryKeys(x) for x in myInput]
    else:
        return myInput
def objectify(myInput,opt=None):
    if isinstance(myInput, str) and myInput == "None":
        myOutput = None
    elif isinstance(myInput,list):
        myOutput = [objectify(x,opt) for x in myInput]
    elif isinstance(myInput,dict):
        if 'myClass' in myInput:
            if isinstance(myInput['myClass'], list):
                myInput['myClass'] = myInput['myClass'][0]
            if   myInput['myClass'] == 'SparseMAT':
                if myInput['sparseType'] == 'coo_array':
                    if len(myInput['data']) == 0: myInput['coords'] = [[] for _ in range(len(myInput['shape']))]
                    else: myInput['coords'] = list(zip(*myInput['coords']))
                    myOutput = coo_array((myInput['data'], myInput['coords']), shape=myInput['shape'])
                elif myInput['sparseType'] == 'COO':
                    if len(myInput['data']) == 0: myInput['coords'] = [[] for _ in range(len(myInput['shape']))]
                    else: myInput['coords'] = list(zip(*myInput['coords']))
                    myOutput = COO(myInput['coords'], myInput['data'], shape=myInput['shape'])
                elif myInput['sparseType'] == 'DOK':
                    myOutput = DOK(tuple(myInput['shape']))
                    for coord, value in zip(myInput['coords'], myInput['data']):
                        myOutput[tuple(coord)] = value
                else:
                    logger.warning('This sparse matrix/tensor type is not supported! Returning original SparseMAT dictionary!')
                    myOutput = myInput
            elif myInput['myClass'] == 'Set':
                myOutput = set(myInput['value'])
            elif myInput['myClass'] == "Path":
                myOutput = pl.Path(myInput['value'])
            else:
                myOutput = createObject(myInput['myClass'])
                outputKeys = list(myInput.keys())
                for k in range(len(outputKeys)):
                    setattr(myOutput, outputKeys[k], objectify(myInput[outputKeys[k]],opt))
                    opt = None
                delattr(myOutput,'myClass')
        else:
            myOutput = GenericClass()
            outputKeys = list(myInput.keys())
            for k in range(len(outputKeys)):
                myOutput.__dict__[k] = objectify(myInput[outputKeys[k]])
    else:
        myOutput = myInput
    return myOutput
def boolify(myString: str) -> bool:
    """Given a string, return that string as a boolean:
     - "true" and "True" will be returned as True
     - "false" and "False" will be returned as False
     - Any other value will raise a ValueError.

    Args:
        myString (str): The string to convert to a boolean.

    Raises:
        ValueError: If the string cannot be converted to a boolean.

    Returns:
        bool: The boolean form of the string.
    """
    try:
        if myString.lower() in ['true','false']: myResult = myString.lower() == 'true'
        else: raise ValueError(f"Invalid boolean string: '{myString}'")
    except ValueError as e: logger.error(f"Error converting value '{myString}': {e}. Abort! Abort!"); sys.exit(1)
    return myResult
def listify(myInput):
    # This is a short-hand function that places all of the attribute values of an object within a list.
    for attribName, attribValue in vars(myInput).items():
        if isinstance(attribValue, list) and len(attribValue) == 0: pass
        else: setattr(myInput, attribName, [attribValue])
    return myInput
def createObject(className, *args, **kwargs):
    #Try Block:  check to create an object of class class name.
    try: return globals()[className](*args, **kwargs)
    except: return GenericClass()
def getVariableName(var, namespace):
    return [name for name in namespace if namespace[name] is var]
def cleanNonesFromListofDicts(myListOfDicts):
    for myDict in myListOfDicts:
        myKeys = list(myDict.keys())
        for myKey in myKeys:
            if isinstance(myDict[myKey], list): pass
            elif myDict[myKey] == None:
                del myDict[myKey]
            elif pd.isna(myDict[myKey]):
                del myDict[myKey]
            else: pass
    return myListOfDicts
@log_entry_exit_trace
def transposeListOfDicts(myList):
    dfTemp = pd.DataFrame(myList, dtype=object)
    if dfTemp.isna().to_numpy().any():
        dfTemp = dfTemp.where(pd.notna(dfTemp), None)
    else: pass
    myDict = dfTemp.to_dict(orient="list")
    return myDict
## Vector, Matrix, and Tensor Math Utility Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@log_entry_exit_trace
def tensorize(AMatrix, tensorSize, idxRow, idxCol):
    # This code accepts any 2D numpy or sparse array.
    # It does not accept a list of lists.
    # IT forces computation on a full numpy array or COO.
    if issparse(AMatrix):
      if not isinstance(AMatrix, COO):
        # logger.debug("Converting matrix to sparse.COO()")
        if isinstance(AMatrix, DOK): AMatrix = COO(AMatrix)
        else:  AMatrix = COO.from_scipy_sparse(AMatrix)
    rowSize = np.array([tensorSize[k] for k in idxRow])
    colSize = np.array([tensorSize[k] for k in idxCol])
    tensorSize = (np.concatenate((rowSize,colSize))).tolist()
    idx = (np.concatenate((idxRow,idxCol))).tolist()
    # reshapeMAT(A,R,C) is the MATLAB equivalent of reshape(A,R,C).
    # ipermute(A,R,C) works just like its MATLAB equivalent
    ATensor = permute(reshapeMAT(AMatrix, tensorSize), idx)
    return ATensor
@log_entry_exit_trace
def matricize(ATensor, idxRow, idxCol):
    # This code accepts any higher order (3+) numpy or sparse array.
    # It does not accept a list of lists.
    # IT forces computation on a full numpy array or COO.
    # logger.debug("Converting matrix to sparse.COO() if necessary")
    if isinstance(ATensor, DOK): ATensor = COO(ATensor)
    elif isinstance(ATensor, sparray): ATensor = COO.from_scipy_sparse(ATensor)
    else: pass
    tensorSize = list(ATensor.shape)
    rowSize = [np.prod([tensorSize[i] for i in idxRow])]
    colSize = [np.prod([tensorSize[i] for i in idxCol])]
    idx = (np.concatenate((idxRow,idxCol))).tolist()
    matSize = (np.concatenate((rowSize,colSize))).tolist()
    # reshapeMAT(A,R,C) is the MATLAB equivalent of reshape(A,R,C).
    # permute(A,R,C) works just like its MATLAB equivalent
    AMatrix = reshapeMAT(permute(ATensor,idx),matSize)
    return AMatrix
def reshapeMAT(ATensor, myDims):  # This is the MATLAB equivalent of reshape()
    # This code accepts any numpy or sparse array.
    # It does not accept a list of lists.
    # IT forces computation on a full numpy array or COO.
    if isinstance(ATensor, list):
      logger.error("Invalid input.  Convert list to matrix first!")
      sys.exit(1)
    # logger.debug("Converting matrix to sparse.COO() if necessary")
    if isinstance(ATensor, DOK): ATensor = COO(ATensor)
    elif isinstance(ATensor, sparray): ATensor = COO.from_scipy_sparse(ATensor)
    else: pass
    myResult = ATensor.T.reshape(myDims[::-1]).T
    if isinstance(myResult, COO) & (len(myDims) <= 2): myResult = coo_array(COO.to_scipy_sparse(myResult))
    return myResult
def permute(ATensor,myDims):        # This is the MATLAB equivalent of permute()
    # This code accepts any numpy or sparse array.
    # It must test for the type to accomodate the slight difference in syntax
    if issparse(ATensor): myResult = ATensor.transpose(axes=myDims)
    else:  myResult = ATensor.transpose(myDims)
    return myResult
def ivecMat(AVector,myDims):
    if AVector.ndim != 1:
      logger.error("Not a vector! Length equal to ", len(AVector))
      sys.exit(1)
    if isinstance(AVector, list):
        AVector = np.array(AVector)
    return reshapeMAT(AVector, myDims)
def vecMAT(AMatrix):
    if isinstance(AMatrix, (coo_array,np.ndarray)):
        myDim = [np.prod(AMatrix.shape)]
        myResult = AMatrix.reshape((myDim[0],1),order='F')
    elif isinstance(AMatrix,COO):
        temp = (AMatrix.transpose()).reshape(-1)
        myResult = coo_array((temp.data, (temp.coords[0],np.zeros_like(temp.coords[0]))), shape=(temp.shape[0],1))
    elif isinstance(AMatrix,list):
        myResult =((vecMAT(np.array(AMatrix))).flatten()).tolist()
        # Reconsider implementing without numpy using a list comprehension.
        # myReult = [item for sublist in AMatrix for item in sublist]
    else:
        logger.error('Fail! Vectorization for ' + type(AMatrix).__name__ + ' is not supported! Abort! Abort!')
        sys.exit(1)
    return myResult
def calcVectorizedIdx(idxRow, idxCol, numRows):
    """
    Given indices i in idxRow and indices j in idxCol, compute the associated index when the associated matrix has been
    vectorized one column on top of the other.  Naturally, idxRow increments faster than idxCol.
    """

    return [numRows * idxj + idxi for idxi, idxj in zip(idxRow, idxCol)]
def getElVec(k, n):
    x = dok_array((n, 1), dtype=int)
    if 0 <= k and k < n: x[k] = True
    return x.tocsc()
def createProjectionOperator(AMat, idxRow):
    numRowsRowProjector = len(idxRow)
    numColsRowProjector = AMat.shape[0]
    valRowProjector = [1] * numRowsRowProjector
    idxIRowProjector = list(range(numRowsRowProjector))
    idxJRowProjector = idxRow
    return coo_array((valRowProjector, (idxIRowProjector, idxJRowProjector)), shape=(numRowsRowProjector, numColsRowProjector))
def projectMatrix(P, A):
    # This funciton projects matrix A using the projectionOperator. It calculates
    # myResult = projectionOperator * A
    # However, since the projection operator only has one "1" in each column, it is much more computationally efficient
    # and memory efficient to use slicing.  myResult = A[projectionOperator.col,:]
    if not isinstance(P, COO): P = P.tocoo()
    if not isinstance(A, COO): A = A.tocoo()
    # Method 1:  Use np.searchsorted()
    # Need to make sure that the COO projection operator P is sorted.
    # P = sortSparseMatrix(P)
    # temp1 = coo_array((A.data, (np.searchsorted(P.col, A.row), A.col)), shape=(P.shape[0], A.shape[1]))

    # Method 2:  Use a numpy hash table.
    cooHashP        = np.full(P.shape[1], -1, dtype=int)
    cooHashP[P.col] = P.row
    idx             = np.isin(A.row, P.col)
    A.row           = A.row[idx]
    A.col           = A.col[idx]
    A.data          = A.data[idx]
    return coo_array((A.data, (cooHashP[A.row], A.col)), shape=(P.shape[0], A.shape[1]))
def sliceCOOMatrix(AMat, idx1, opt="row", idx2=None):
    if not isinstance(AMat, COO): AMat = AMat.tocoo()
    if opt == "row":
        idxRow = idx1
        idxCol = idx2
        if idxCol is not None:
            colProjector = createProjectionOperator(AMat.T, idxCol)
            AMat = (projectMatrix(colProjector, AMat.T)).T
        rowProjector = createProjectionOperator(AMat, idxRow)
        AMat2 = projectMatrix(rowProjector, AMat)
    elif opt == "col":
        AMat2 = sliceCOOMatrix(AMat.T,idx1).T
    return AMat2
def sortSparseMatrix(A):
    if isinstance(A, coo_array):
        idx = np.argsort(vecMAT(A).row)
        B = coo_array((A.data[idx], (A.row[idx], A.col[idx])), shape=A.shape)
    elif isinstance(A, COO):
        idx = np.argsort(vecMAT(A).row)
        B = COO(coords=A.coords[:, idx], data=A.data[idx],shape=A.shape)
    elif isinstance(A, DOK):
        B = DOK(A.shape, {k: v for k, v in sorted(A.data.items())})
    elif isinstance(A, SparseMAT):
        pairs = sorted(zip(A.coords, A.data))
        A.coords = [a for a, b in pairs]
        A.data   = [b for a, b in pairs]
        return A
    else:
        logger.error('Object is not a COO sparse array!'); sys.exit(1)
    return B
def tileSparseMatrix(A, reps,dir='row'):
    """Tile a sparse matrix A along rows and columns."""
    if not isinstance(A, coo_array):  A = coo_array(A)  # Convert to COO format if necessary
    if dir == 'row':
        numCols = A.shape[1]
        row = np.repeat(A.row, reps)
        col = (np.tile(numCols * np.arange(reps),(A.nnz,1)) + A.col[:,np.newaxis]).flatten()
        data = np.repeat(A.data, reps)
        A2 = coo_array((data, (row, col)), shape=(A.shape[0], A.shape[1] * reps))
    elif dir == 'col':
        numRows = A.shape[0]
        row = (np.tile(numRows * np.arange(reps), (A.nnz, 1)) + A.row[:, np.newaxis]).flatten()
        col = np.repeat(A.col, reps)
        data = np.repeat(A.data, reps)
        A2 = coo_array((data, (row, col)), shape=(A.shape[0]*reps, A.shape[1]))
    else:
        logger.error('Error! Invalid direction parameter! Either row or col. Abort! Abort!')
        sys.exit(1)
    return A2
## Hetero-functional Graph Theory Utility Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@log_entry_exit_trace
def calcIncidenceMatrix(rowList, colList,opt,myWeights=True):
    if opt == 'col':
        # logger.debug("Looping over columns...")
        pass
    elif opt == 'row':
        # logger.debug("Looping over rows...")
        temp = rowList; rowList = colList; colList = temp
    else: logger.error("Invalid option for calcIncidenceMatrix()!!! Abort! Abort! Option is either col or row"); sys.exit(1)
    if myWeights == True:
        myMatrix = coo_array((len(rowList), len(colList)), dtype=int)
    else:
        myMatrix = coo_array((len(rowList), len(colList)), dtype=float)
    for k in range(len(colList)):
        myColListStrings = regex.split(r',\s*', colList[k])
        idx = np.array((np.isin(rowList, myColListStrings)).nonzero()).flatten()
        extraStringList = np.setdiff1d(myColListStrings, np.append(rowList,''))
        if len(extraStringList) > 0:
            logger.warning('Warning!  There are extra strings in the test string array:  ', extraStringList)
        myMatrix.row = np.append(myMatrix.row, idx)
        myMatrix.col = np.append(myMatrix.col, np.repeat(k, len(idx)))
        if myWeights == True:
            myMatrix.data = np.append(myMatrix.data, np.repeat(1, len(idx)))
        else:
            try:
                if len(idx) == len(myWeights[k]):
                    myMatrix.data = np.append(myMatrix.data, myWeights[k])
                else:
                    raise ValueError("Incidence calculation mismatch: lengths do not align.")
            except Exception as e:
                logger.error(f"Error! {e}")
                logger.error(f"\tRow List: {', '.join(rowList)}")
                logger.error(f"\tColumn List: {', '.join(colList)}")
                logger.error("\tAbort! Abort!")
                sys.exit(1)
    if opt == 'row':
        myMatrix = myMatrix.T
    return myMatrix
@log_entry_exit_trace
def calcIndexBinA(listA, listB):
    """
    Given listA and ListB, idxListB is a list as long as list B that provides the index in list A of each element in List B.
    This is the same as [listA.index(x) for x in listB].  The hash map implementation is much faster ...
    """

    idxMapA = {v: i for i, v in enumerate(listA)}
    idxListB =  [idxMapA[item] for item in listB]
    return idxListB
@log_entry_exit_trace
def mineProcessData(tempDict,myProcesses,idxResource):
    # Extract the data attributes from the list of system processes
    myKeys = set(tempDict.keys()) - {'idxResource'}
    for k in range(len(myProcesses)):
        if myProcesses[k] != None:
            # Append to tempDict['idxResource'] a list with the value idxResource[k] repeated myProcesses[k].number times.
            # The * operator here does not mean multiplication, it is operating on a list and acting like repmat()
            # Equivalently, but slower:  tempDict['idxResource'] = tempDict['idxResource'] + [idxResource[k] * for _ in range(myProcesses[k].number)]
            tempDict['idxResource'] = tempDict['idxResource'] + [idxResource[k]] * myProcesses[k].number
            for myKey in myKeys:
                if isinstance(tempDict[myKey],list):
                    tempDict[myKey] = tempDict[myKey] + getattr(myProcesses[k], myKey)
                elif isinstance(tempDict[myKey],coo_array):
                    tempDict[myKey] = hstack([tempDict[myKey], getattr(myProcesses[k], myKey)], format='coo')
                else: pass
    return tempDict
@log_entry_exit_trace
def calcXiy1minus(i, y1, myLFES):
    # This function may have become obsolete in new versions.  Retain for reference.
    MLPNegMU = myLFES.transformProcess.MLPNeg.tocsc()
    MLPNegG  = myLFES.holdingProcess.MLPNeg.tocsc()
    e_i_L    = getElVec(i,myLFES.operand.number)
    e_y1_M   = getElVec(y1,myLFES.transformationResource.number)
    e_y1_BS  = getElVec(y1,myLFES.buffer.number)

    A1 = (MLPNegMU.T).dot(e_i_L.dot(e_y1_M.T))
    A2 = coo_array((myLFES.transformProcess.number, myLFES.physicalResource.number - myLFES.transformationResource.number), dtype=bool)
    A = hstack((A1, A2))
    B1 = (MLPNegG.T).dot(e_i_L)
    B2 = kron(e_y1_BS, np.array([[True] * myLFES.buffer.number]).T)
    B  = kron(B1,kron(B2,np.array([[True] * myLFES.physicalResource.number])),'coo')
    xiy1minus = vstack((A, B))
    return xiy1minus
@log_entry_exit_trace
def calcXiy2plus(i, y2, myLFES):
    # This function may have become obsolete in new versions.  Retain for reference.
    MLPPosMU = myLFES.transformProcess.MLPPos.tocsc()
    MLPPosG  = myLFES.holdingProcess.MLPPos.tocsc()
    e_i_L    = getElVec(i,myLFES.operand.number)
    e_y2_M   = getElVec(y2,myLFES.transformationResource.number)
    e_y2_BS  = getElVec(y2,myLFES.buffer.number)

    A1 = (MLPPosMU.T).dot(e_i_L.dot(e_y2_M.T))
    A2 = coo_array((myLFES.transformProcess.number, myLFES.physicalResource.number - myLFES.transformationResource.number), dtype=bool)
    A = hstack((A1, A2))
    B1 = (MLPPosG.T).dot(e_i_L)
    B2 = kron(np.array([[True] * myLFES.buffer.number]).T,e_y2_BS)
    B  = kron(B1,kron(B2,np.array([[True] * myLFES.physicalResource.number])),'coo')
    xiy2plus = vstack((A, B))
    return xiy2plus
@log_entry_exit_trace
def projectVecSystemConcept(AVector, mySystemConcept):
    # This function may have become obsolete in new versions.  Retain for reference.
    myResult = coo_array((mySystemConcept.DOFS,1), dtype=float)
    idx = np.isin(AVector.row, mySystemConcept.idxChiCapability,kind='table')  # Check which rows match
    # idx = isin_numba_set(mySystemConcept.idxChiCapability,AVector.row)
    myResult.row = mySystemConcept.idxPsiCapability[idx]
    myResult.col = np.zeros(len(myResult.row))
    myResult.data = np.ones(len(myResult.row))
    return myResult
@log_entry_exit_trace
def resolvePsiCapabilityIndex(idxPsi, systemConcept):
    idxProcess  = [systemConcept.idxProcess[x] for x in idxPsi]
    idxResource = [systemConcept.idxResource[x] for x in idxPsi]
    idxChi      = [systemConcept.idxChiCapability[x] for x in idxPsi]
    return idxProcess, idxResource, idxChi
## Debugging & Testing Functions  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@log_entry_exit_trace
def debugEquivObjs(objA,objB,myString="", opt=False):
    # NOTE:  Do not trace this function!  It will get bogged down for large datasets!
    if type(objA) != type(objB):
        myFlag = False
        if isinstance(objA, float) and objA.is_integer():
            objA = int(objA)
            myFlag = True
        if isinstance(objB, float) and objB.is_integer():
            objB = int(objB)
            myFlag = True
        if myFlag:
            myResult = objA == objB
        else:
            logger.error('Fail! ObjA and ObjB are not the same type!... Exiting()')
            myResult = False
            return myResult, myString
    else:
        if objA is None: myResult = objA == objB
        elif isinstance(objA, (str, int, bool, float, set, pl.PurePath)): myResult = objA == objB
        elif isinstance(objA, Enum): myResult = objA.value == objB.value
        elif isinstance(objA, list):
            # logger.debug('Investigating list ...')
            if len(objA) != len(objB):
                logger.debug('Length of Obj A and Obj B are not equivalent! See ' + str(len(objA)) + ' vs. ' + str(len(objB)))
                myResult = False
                return myResult, myString
            else:
                if all(isinstance(x, str) for x in objA):
                    objA.sort()
                if all(isinstance(x, str) for x in objB):
                    objB.sort()
                for k in range(len(objA)):
                    tempResult, tempString = debugEquivObjs(objA[k], objB[k], myString + '[' + str(k) + ']')
                    if not tempResult:
                        logger.error('Fail!  Values of Obj A and Obj B are not equivalent! See ' + tempString)
                        debugEquivObjs(objA[k], objB[k], myString + '[' + str(k) + ']')
                        myResult = tempResult
                        myString = tempString
                        return myResult,myString
                # logger.debug('Congratulations! ObjA and ObjB are equivalent lists!')
                myResult = True
        elif isinstance(objA,dict):
            # logger.debug('Investigating dictionaries ...')
            myKeysA = sorted(list(objA.keys()))
            myKeysB = sorted(list(objB.keys()))
            if myKeysA != myKeysB:
                logger.error('Fail! Keys of Obj A and Obj B are not equivalent! See ' + str(set(myKeysB) - set(myKeysA)) + ' or ' + str(set(myKeysA) - set(myKeysB)))
                print(f"My String {myString}")
                myResult = False
                return myResult, myString
            else:
                outputKeys = myKeysA
                for k in range(len(outputKeys)):
                    tempResult,tempString = debugEquivObjs(objA[outputKeys[k]], objB[outputKeys[k]], myString + '.' + outputKeys[k])
                    if not tempResult:
                        logger.error('Fail!  Values of Obj A and Obj B are not equivalent! See ' + tempString)
                        myResult = tempResult
                        myString = tempString
                        return myResult,myString
                logger.success(f"Congratulations! ObjA and ObjB of {myString} are equivalent dictionaries!")
                myResult = True
        elif isinstance(objA, (coo_array,COO,DOK)):
            myResult, myString = debugEquivObjs(SparseMAT(objA), SparseMAT(objB), myString)
            if myResult: logger.debug('Congratulations! ObjA and ObjB are equivalent sparse matrices!')
            else:
                logger.error('Fail!  Values of Obj A and Obj B are not equivalent! See ' + myString)
        else:
            if not hasattr(objA, "__dict__"):
                logger.error('Fail! ObjA and ObjB are unsupported data types!')
            myResult,myString = debugEquivObjs(vars(objA),vars(objB),myString)
    return myResult,myString
@log_entry_exit_trace
def debugEquivTextFiles(filePath1,filePath2):
    """Compare two text files (filePath1 and filePath2).
    Return True if they are equivalent, and False if not.

    Args:
        filePath1 (_type_): _description_
        filePath2 (_type_): _description_

    Returns:
        bool, List[str]: A boolean representing whether the files are equivalent,
            and a list of differences (if any).
    """
    # Read entire file as a single string
    with open(filePath1, 'r', encoding='utf-8') as file:
        stringFile1 = file.read()
    with open(filePath2, 'r', encoding='utf-8') as file:
        stringFile2 = file.read()
    result = stringFile1 == stringFile2
    differences = []
    if not result:
        max_len = max(len(stringFile1), len(stringFile2))
        stringFile1 = stringFile1.ljust(max_len)
        stringFile2 = stringFile2.ljust(max_len)
        for i, (c1, c2) in enumerate(zip(stringFile1, stringFile2)):
            if c1 != c2:
                differences.append((i, c1, c2))
        # Print differences
        logger.error('Fail!  These two text files are NOT equivalent!')
        for index, char1, char2 in differences:
            logger.info(f"Position {index}: '{char1}' -> '{char2}'")
    else:
        logger.success('Success!  These two text files are equivalent!')
    return result, differences
@log_entry_exit_trace
def fixTestLFESFilePaths(myLFES1,myLFES2):
    myLFES2.inputFilePath = myLFES1.inputFilePath
    myLFES2.outputFilePath = myLFES1.outputFilePath
    myLFES2.inputDataFormat = myLFES1.inputDataFormat
    myLFES2.juliaOutputFilePath = myLFES1.juliaOutputFilePath
@log_entry_exit_trace
def calcTestFilePaths2(inputFilePath,):
    outputFilePath = inputFilePath
    outputFilePath = outputFilePath.replace("XMLs", "SysMLs")
    outputFilePath = outputFilePath.replace("Defaultxml", "Sysml")
    outputFilePath = outputFilePath.replace(".xml", ".sysml")
    inputFilePath = pl.Path(inputFilePath)
    outputFilePath = pl.Path(outputFilePath)
    return inputFilePath, outputFilePath
@log_entry_exit_trace
def calcTestFilePaths1(inputFileName,makeBenchmarkFiles):
    mySuffix = pl.Path(inputFileName).suffix
    outputFileName = "myLFES-" + inputFileName.replace(mySuffix, ".json")
    outputDirectory = "3_PyHFGT_Output_Data/"
    outputFilePath = outputDirectory + outputFileName
    benchmarkFilePath = regex.sub(r"\d{4}-\d{2}-\d{2}", "Benchmark", outputFilePath)
    if makeBenchmarkFiles:
        shutil.copy2(outputFilePath, benchmarkFilePath)
    return benchmarkFilePath
@log_entry_exit_trace
def reportTestResult(testName,myResult):
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    logger.info(testName)
    if myResult:
        logger.success(f"Success! {testName}:  ObjA and ObjB are equivalent!")
    else:
        logger.error(f"Failed! {testName} Abort! Abort!")
        exit()
## Visualization functionsference ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@log_entry_exit_trace
def plotTimeSeriesMatrix(A, max_rows_shown=5):
    A = np.asarray(A)
    n_rows, n_cols = A.shape
    t = np.arange(n_cols)

    fig = plotlyGO.Figure()

    # Add traces for all rows but control visibility
    for i in range(n_rows):
        fig.add_trace(
            plotlyGO.Scatter(
                x=t,
                y=A[i],
                mode="lines",
                name=f"Row {i}",
                visible=(i < max_rows_shown)  # show first few initially
            )
        )

    # Create dropdown buttons
    buttons = []

    for start in range(0, n_rows, max_rows_shown):
        end = min(start + max_rows_shown, n_rows)

        visible = [False] * n_rows
        for i in range(start, end):
            visible[i] = True

        buttons.append(
            dict(
                label=f"Rows {start}-{end - 1}",
                method="update",
                args=[{"visible": visible},
                      {"title": f"Rows {start} to {end - 1}"}]
            )
        )

    fig.update_layout(
        title="Time Series Matrix Viewer",

        autosize=True,
        height=800,  # approx 9:16 for typical notebook width

        xaxis=dict(
            title="Time",
            rangeslider=dict(visible=True),  # range slider
            type="linear"
        ),

        yaxis=dict(title="Value"),

        # dropdown above top-left
        updatemenus=[
            dict(
                buttons=buttons,
                direction="down",
                showactive=True,
                x=0,
                xanchor="left",
                y=1.07,
                yanchor="top"
            )
        ],

        # legend just right of plot
        legend=dict(
            x=1.02,
            y=1,
            xanchor="left",
            yanchor="top",
            orientation="v"
        ),

        margin=dict(l=70, r=160, t=100, b=70)
    )
    fig.show(config={"responsive": True})
@log_entry_exit_trace
def plotStackedMatrix(A, max_rows_shown=5):
    A = np.asarray(A)
    n_rows, n_cols = A.shape
    t = np.arange(n_cols)

    fig = plotlyGO.Figure()

    # Add stacked bar traces
    for i in range(n_rows):
        fig.add_trace(
            plotlyGO.Bar(
                x=t,
                y=A[i],
                name=f"Row {i}",
                visible=(i < max_rows_shown)
            )
        )

    # Create dropdown buttons
    buttons = []

    for start in range(0, n_rows, max_rows_shown):
        end = min(start + max_rows_shown, n_rows)

        visible = [False] * n_rows
        for i in range(start, end):
            visible[i] = True

        buttons.append(
            dict(
                label=f"Rows {start}-{end - 1}",
                method="update",
                args=[
                    {"visible": visible},
                    {"title": f"Stacked Time Series: Rows {start}-{end - 1}"}
                ]
            )
        )

    fig.update_layout(
        title="Stacked Time Series Matrix",

        # allow notebook to control width
        autosize=True,
        height=800,  # approx 9:16 for typical notebook width

        barmode="relative",

        xaxis=dict(
            title="Time",
            rangeslider=dict(visible=True),  # range slider
            type="linear"
        ),

        yaxis=dict(title="Value"),

        # dropdown above top-left
        updatemenus=[
            dict(
                buttons=buttons,
                direction="down",
                showactive=True,
                x=0,
                xanchor="left",
                y=1.07,
                yanchor="top"
            )
        ],

        # legend just right of plot
        legend=dict(
            x=1.02,
            y=1,
            xanchor="left",
            yanchor="top",
            orientation="v"
        ),

        margin=dict(l=70, r=160, t=100, b=70)
    )
    fig.show(config={"responsive": True})
## OLD Code -- Keep for reference ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This is old code that demonstrates the profiling function
# profiler = cProfile.Profile()
# profiler.enable()
# # ----------------------------------------------------------------------
# myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
# # ----------------------------------------------------------------------
# profiler.disable()
# # Save profile for later analysis with SnakeViz
# profiler.dump_stats("profile.prof")
# stats = pstats.Stats(profiler)
# print("\n==========================================")
# print("Top 30 by cumulative time")
# print("==========================================")
# stats.sort_stats("cumulative").print_stats(30)
# print("\n==========================================")
# print("Top 30 by internal (total) time")
# print("==========================================")
# stats.sort_stats("tottime").print_stats(30)
# print("\nProfile saved to 'profile.prof'")
# print("View interactively with:")
# print("    snakeviz profile.prof")

# This is example code that demonstrates complex regular expressions.
# To learn advanced recursive regular expression, please see:
# https://learnbyexample.github.io/py_regular_expressions/regex-module.html?highlight=recurs#recursive-matching
# eqn0 = 'a + {b * c} - {d / e}'
# eqn1 = '{{f+x}^y-42}*{{3-g}^z+2}'
# eqn2 = 'a + {b} + {{c}} + {{{d}}}'
# eqn3 = '{3+a} * {{r-2}*{t+2}/6} + 42 * {a{b{c{d{e}}}}}'
# temp0  = regex.findall(r'\{[^{}]++\}', eqn0)
# temp1a = regex.findall(r'\{[^{}]++\}', eqn1)
# temp1b = regex.findall(r'\{(?:[^{}]++|\{[^{}]++\})++\}', eqn1)
# temp2a = regex.findall(r'\{(?:[^{}]++|\{[^{}]++\})++\}', eqn2)
# lvl2   = regex.compile(r'\{(?:[^{}]++|\{[^{}]++\})++\}', flags=regex.X)
# temp2b = lvl2.findall(eqn2)
# lvln   = regex.compile(r'\{(?:[^{}]++|(?0))++\}', flags=regex.X)
# temp2c = lvln.findall(eqn2)
# temp3  = lvln.findall(eqn3)