"""
Copyright (c) 2018-2026 Engineering Systems Analytics LLC
@author:    Amro M. Farid, Papa Kwesi Aggrey, Ehsan Ghorbani,
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

import sys, copy  # Needed for the parent function
import pathlib as pl
from .HFGTToolbox import importSysMLFile, df2SysMLDict, sortDictionaryKeys
import pandas as pd
# Logging Modules
from loguru import logger   # Version 0.7.3
from typing import Optional, List # Type hinting
from .logging import update_logging_level, add_file_logger, log_entry_exit_info, log_entry_exit_trace

# TODO: Validate the Instantiated SysML file by running HFGT Analysis after inspecting the code function by function in great detail.
# def generateBaseDict(filePath:str):
#     return hfgt.importSysMLFile(pl.Path(filePath))
# # This function generates a SysML compliant dictionary for the reference file
def matPowerCSV2SysMLDict(inputFilePath, className):
    df = pd.read_csv(inputFilePath, encoding='utf-8')
    df["idxColumn"] = range(1, len(df) + 1)
    idxColumnName = "idxColumn"
    return df2SysMLDict(df, className, idxColumnName)

# This function converts the busDict's MATPOWER architecture to the meta architecture structure
def reformatBusDict(busDict: dict):
    # Reorganizing part defs
    actions = ["Pd", "Qd", "Gs", "Bs"]
    idx = list(busDict["part def"][0]["attribute"])
    oldPart = busDict["part"]
    newPart = []
    idx = [attr for attr in idx if attr not in actions]
    # referenceDict["part def"][0]["attribute"] = pd.Index(idx)

    # Renaming some of the attributes
    rename_map = {
        "Pd": "value",
        "bus_i": "idx"
    }
    actions = [rename_map.get(name, name) for name in actions]
    idx = [rename_map.get(name, name) for name in idx]
    for part in oldPart:
        renamed_part = {}
        for k, v in part.items():
            renamed_part[rename_map.get(k, k)] = v
        newPart.append(renamed_part)

    for myPart in newPart:
        myPart["myName"] = "Demand_Bus" + "_" + str(myPart["myName"])
        myPart["myClass"] = "TransformationResource"

    # Putting it all together and creating action def
    busDict["part def"][0]["attribute"] = idx
    busDict["part"] = newPart
    busDict["part def"][0]["action"] = "consume electricity :> consume electricity"
    busDict["action def"] = [
        {
            "myName": "consume electricity",
            "myClass": "TransformProcess",
            "attribute": actions,
        }
    ]
    return busDict

# This function converts the branch's MATPOWER architecture to the meta architecture structure
def reformatBranchDict(referenceDict: dict):
    actions = ["fbus", "tbus", "angmax", "angmin"]
    idx = list(referenceDict["part def"][0]["attribute"])
    oldPart = referenceDict["part"]
    newPart = []
    idx = [attr for attr in idx if attr not in actions]
    # referenceDict["part def"][0]["attribute"] = pd.Index(idx)

    # Renaming some attributes
    rename_map = {
        "fbus": "origin",
        "tbus": "destination"
    }
    actions = [rename_map.get(name, name) for name in actions]
    idx = [rename_map.get(name, name) for name in idx]
    for part in oldPart:
        renamed_part = {}
        for k, v in part.items():
            renamed_part[rename_map.get(k, k)] = v
        newPart.append(renamed_part)

    for myPart in newPart:
        myPart["myName"] = "Electric_Power_Line" + "_" + str(myPart["myName"])
        myPart["myClass"] = "TransportationResource"

    # Putting it all together
    referenceDict["part def"][0]["attribute"] = idx
    referenceDict["part"] = newPart
    referenceDict["part def"][0]["action"] = "transport_electric_power :> Transport_Electric_Power"
    referenceDict["action def"] = [
        {
            "myName": "Transport_Electric_Power",
            "myClass": "TransportProcess",
            "attribute": actions,
        }
    ]
    return referenceDict
# This function converts the generator's MATPOWER architecture to the meta architecture structure
def reformatGenDict(referenceDict: dict):
    actions = ["Pg", "Qg", "Pmax", "Pmin", "Qmax", "Qmin", "cost_Coefficient1", "cost_Coefficient2"]
    idx = list(referenceDict["part def"][0]["attribute"])
    oldPart = referenceDict["part"]
    newPart = []
    idx = [attr for attr in idx if attr not in actions]
    # referenceDict["part def"][0]["attribute"] = pd.Index(idx)

    # Renaming some attributes
    rename_map = {
        "Pmax": "upperBoundFlowNeg",
        "Pmin": "lowerBoundFlowNeg",
        "cost_Coefficient1": "quadCostCoeffFlowNeg",
        "cost_Coefficient2": "linearCostCoeffFlowNeg",
    }
    actions = [rename_map.get(name, name) for name in actions]
    idx = [rename_map.get(name, name) for name in idx]
    for part in oldPart:
        renamed_part = {}
        for k, v in part.items():
            renamed_part[rename_map.get(k, k)] = v
        newPart.append(renamed_part)

    for myPart in newPart:
        myPart["myName"] = "Generator" + "_" + str(myPart["myName"])
        myPart["myClass"] = "TransformationResource"

    # Putting it all together
    referenceDict["part def"][0]["attribute"] = idx
    referenceDict["part"] = newPart
    referenceDict["part def"][0]["action"] = "generate electricity :> generate electricity"
    referenceDict["action def"] = [
        {
            "myName": "generate electricity",
            "myClass": "TransformProcess",
            "attribute": actions,
        }
    ]
    return referenceDict
# Generator and Bus Part Def Inheritance
def inheritMetaResourceAttributes(baseDict: dict, referenceDict: dict, resourceType: str):
    for k in range(len(baseDict["part def"])):
        if baseDict["part def"][k]["myName"] == resourceType: idx = k
    baseAttributes = list(baseDict["part def"][idx].keys())
    referenceAttributes = referenceDict["part def"][0]["attribute"]
    referenceAttributes.extend(baseAttributes)
    # mergedAttributes = list(set(referenceAttributes))
    mergedAttributes = list(dict.fromkeys(referenceAttributes))
    referenceDict["part def"][0]["attribute"] = mergedAttributes
    return referenceDict

# Branch Part Def Inheritance
# Second part of generator part def inheritance
def inheritBusAttrobites(bus: dict, gen: dict):
    busAttributes = bus["part def"][0]["attribute"]
    generatorAttributes = gen["part def"][0]["attribute"]
    generatorAttributes.extend(busAttributes)
    mergedAttributes = list(dict.fromkeys(generatorAttributes))
    gen["part def"][0]["attribute"] = mergedAttributes

    return gen

# Generator and Bus Action Def Inheritance
def inheritMetaProcessAttributes(baseDict: dict, referenceDict: dict, processType: str):
    for k in range(len(baseDict["action def"])):
        if baseDict["action def"][k]["myName"] == processType: idx = k
    baseAttributes = list(baseDict["action def"][idx].keys())
    referenceAttributes = referenceDict["action def"][0]["attribute"]
    referenceAttributes.extend(baseAttributes)
    mergedAttributes = list(dict.fromkeys(referenceAttributes))
    referenceDict["action def"][0]["attribute"] = mergedAttributes
    return referenceDict

# Branch Action Def Inheritance
# Reorganize the current reference files
def reorderReferenceDictKeys(referenceDict: dict):
    return {
        "part def": referenceDict["part def"],
        "action def": referenceDict["action def"],
        "part": referenceDict["part"]
    }

# Reorganizing bus part
def updateBusPart(referenceDict: dict):
    action_def = referenceDict["action def"][0]
    action_attributes = action_def.get("attribute")
    action_name = action_def.get("myName")
    action_class = action_def.get("myClass")

    resource_defaults = {
        "decisionMaker": "Scheduler",
        "autonomous": "true",
        "gpsX": "0",
        "gpsY": "0",
        "varDomain": "real+",
        "upperBound": "0",
        # "lowerBound": "0",
    }
    action_defaults = {
        "name": action_name,
        "status": "true",
        "inputOperand": "electricity",
        "outputOperand": "",
        "varDomain": "real+",
        "upperBoundFlowNeg": "200",
        "lowerBoundFlowNeg": "0",
        "quadCostCoeffFlowNeg": "0",
        "linearCostCoeffFlowNeg": "0",
    }

    for part in referenceDict["part"]:
        action_part = {
            "myName": action_name,
            "myClass": action_class,
        }

        for attribute in action_attributes:
            if attribute in part and attribute != "idx":
                action_part[attribute] = part.pop(attribute)

        for k, v in resource_defaults.items():
            if k not in part:
                part[k] = v
        for k, v in action_defaults.items():
            if k not in action_part or k == "status":
                action_part[k] = v
        part["transformationResourceName"] = part.get("myName")
        part["action"] = [action_part]

    referenceDict["part"] = [part for part in referenceDict["part"] if part.get("type") == 1]
    return referenceDict
# Reorganizing branch part
def updateBranchPart(referenceDict: dict, busDict: dict, generatorDict: dict):
    merged_transformation_resources = busDict["part"] + generatorDict["part"]
    action_def = referenceDict["action def"][0]
    action_attributes = action_def.get("attribute")
    action_name = action_def.get("myName")
    action_class = action_def.get("myClass")

    resource_defaults = {
        "decisionMaker": "Scheduler",
        "autonomous": "true",
    }

    action_defaults = {
        "name": action_name,
        "status": "true",
        "inputOperand": "electricity",
        "outputOperand": "electricity",
        "varDomain": "real",
        "upperBoundFlowNeg": "1000",
        "lowerBoundFlowNeg": "-10000",
        "quadCostCoeffFlowNeg": "0",
        "linearCostCoeffFlowNeg": "0",
        "refinement": ""

    }

    for part in referenceDict["part"]:
        action_part = {
            "myName": action_name,
            "myClass": action_class,
        }
        for attribute in action_attributes:
            if attribute in part and attribute != "idx":
                if attribute in ["origin", "destination"]:
                    # action_part[attribute] should be merged_transformation_resources.get("myName") of the part with its idx matched
                    action_part[attribute] = next((res.get("myName") for res in merged_transformation_resources if
                                                   res.get("idxColumn") == part.get(attribute)), None)
                else:
                    action_part[attribute] = part.pop(attribute)

        for k, v in resource_defaults.items():
            if k not in part:
                part[k] = v

        for k, v in action_defaults.items():
            if k not in action_part or k == "status":
                action_part[k] = v

        part["transportationResourceName"] = part.get("myName")
        part["action"] = [action_part]

    return referenceDict
# Reorganizing generator part
def updateGeneratorPart(referenceDict: dict):
    action_def = referenceDict["action def"][0]
    action_attributes = action_def.get("attribute")
    action_name = action_def.get("myName")
    action_class = action_def.get("myClass")

    resource_defaults = {
        "decisionMaker": "Scheduler",
        "autonomous": "true",
        "gpsX": "0",
        "gpsY": "0",
        "varDomain": "real+",
        "upperBound": "0",
        # "lowerBound": "0",
    }
    action_defaults = {
        "name": action_name,
        "status": "true",
        "inputOperand": "",
        "outputOperand": "electricity",
        "varDomain": "real+",
        "upperBoundFlowNeg": "0",
        "lowerBoundFlowNeg": "0",
        "quadCostCoeffFlowNeg": "0",
        "linearCostCoeffFlowNeg": "0",
    }
    for part in referenceDict["part"]:
        action_part = {
            "myName": action_name,
            "myClass": action_class,
        }
        for attribute in action_attributes:
            if attribute in part and attribute != "idx":
                action_part[attribute] = part.pop(attribute)

        for k, v in resource_defaults.items():
            if k not in part:
                part[k] = v

        for k, v in action_defaults.items():
            if k not in action_part or k == "status":
                action_part[k] = v
        part["transformationResourceName"] = part.get("myName")
        part["action"] = [action_part]
        # part["action"][0]["name"] = action_name
        print("")
        # part["action"][""]

    return referenceDict
# Export reference Files
def exportReferenceDict(file: dict, filePath: str):
    inputPath = pl.Path(filePath)
    # Change this path Papa!
    # outputFilePath = str(inputPath.parent.parent.parent) + "/2_PyHFGTInput_Data/" + inputPath.stem + ".sysml"
    outputFilePath = str(inputPath.parent.parent) + "/2_PyHFGTInput_Data/" + inputPath.stem + ".sysml"

    return hfgt.exportSysMLFile(file, outputFilePath)
# Instantiated Architecture
def mergeDict(baseDict: dict, referenceDicts: list):
    appendPart_defs(baseDict["part def"], referenceDicts)
    appendAction_defs(baseDict["action def"], referenceDicts)
    appendParts(baseDict["part"], referenceDicts)
    return baseDict
def appendPart_defs(baseDictPartDef: list, referenceDicts: list):
    for ref in referenceDicts:
        for refPartDef in ref["part def"]:
            baseDictPartDef.append(refPartDef)
def appendAction_defs(baseDictActionDef: list, referenceDicts: list):
    for ref in referenceDicts:
        for refActionDef in ref["action def"]:
            baseDictActionDef.append(refActionDef)
def appendParts(baseDictPart: list, referenceDicts: list):
    baseDictPart = baseDictPart[0]
    for ref in referenceDicts:
        for refPart in ref["part"]:
            if "part" not in baseDictPart:
                baseDictPart["part"] = []
            baseDictPart["part"].append(refPart)
def importMatPowerData(epsSysMLStemFilePath,epsGenCSVFilePath,epsBusCSVFilePath,epsBranchFilePath):
    # Generate a SysML compliant dictionary from the Electric Power System Stem File and the MatPower CSVs
    sysMLStemDict = importSysMLFile(epsSysMLStemFilePath)
    generatorDict = matPowerCSV2SysMLDict(epsGenCSVFilePath,"Generator")
    busDict = matPowerCSV2SysMLDict(epsBusCSVFilePath,"Demand_Bus")
    branchDict = matPowerCSV2SysMLDict(epsBranchFilePath,"Electric_Power_Line")
    return sysMLStemDict, generatorDict, busDict, branchDict

def importRefArchElement(sysMLRefArchDict:dict, numInstances:int) -> tuple[dict,set]:
    """
    Import the Reference Architecture Element as many times as specified by numInstances.
    Args:
        sysMLRefArchDict:  A SysML-compliant dictionary describing the reference architecture.
        numInstances:    The number of instances to import.
    Returns:
        sysMLInsArchListDict:  A List of Dictionaries describing the instantiated architecture for that element.
        refDictKeys:  The names of the attributes that element.
    """
    # Import the reference architecture element without any of its parts or items.
    tempDict = copy.deepcopy({k: v for k, v in sysMLRefArchDict.items() if k not in ['part', 'item']})
    # Attributes without values need to be unpacked.
    if "attribute" in tempDict:
        for k in range(len(tempDict['attribute'])):
            tempDict[tempDict['attribute'][k]['myName']] = ""
        del tempDict['attribute']
    # Because this a reference architecture element the name of the element is the same as its class.
    tempDict['myClass'] = tempDict['myName']
    # myName now becomes the name of the instance -- but we don't know what it is yet.
    tempDict['myName'] = ''
    refDictKeys = set(tempDict.keys())
    if 'item' in sysMLRefArchDict.keys(): tempDict['item'] = []
    if 'part' in sysMLRefArchDict.keys(): tempDict['part'] = []
    # Definitely do NOT set the actions to []!  It will break downstream functions!
    # if 'action' in sysMLRefArchDict.keys(): tempDict['action'] = []
    sysMLInsArchListDict = [copy.deepcopy(tempDict) for _ in range(numInstances)]
    return sysMLInsArchListDict, refDictKeys
def validateCSVElemDict(refDictKeys:set,csvListDict:list,csvFileName:str) -> list:
    """
    This function validates the dictionary describing the CSV element.  More specifically, it checks if all the column
    names appear in the reference architecture.

    Note!  This function does not check if CSV file has all the attributes of the associated reference architecture element
    as this would create a cumbersome CSV importing functionality.
    Args:
        refDictKeys:  The names of the attributes that element.
        csvListDict:  A list of dictionaries describing the CSV file.
        csvFileName:  The name of the CSV file that was imported.
    Returns:
        csvListDict:  A list of dictionaries describing the CSV file.
    """
    extraKeys = set(csvListDict[0].keys()) - refDictKeys
    try:
        if extraKeys:
            raise ValueError(f"This CSV File {csvFileName} has the following column names that do not belong in the "
                             f"reference architecture: {extraKeys}. Abort! Abort!")
    except ValueError as e:
        logger.error(e)
        sys.exit(1)
    return csvListDict
def insertCSVElemDict(targetListDict:list, csvListDict:list, csvFileName:str) -> list:
    """
    Now copy the values of the list of dictionaries pertaining to the CSV data into the target list of dictionaries.
    Args:
        targetListDict:  The list of dictionaries describing the instantiated archictecture element.
        csvListDict:  A list of dictionaries describing the CSV file.
        csvFileName:  The name of the CSV file that was imported.
    Returns:
        targetListDict:  The list of dictionaries describing the instantiated archictecture element.
    """
    for k in range(len(csvListDict)):
        for myKey in csvListDict[k]:
            targetListDict[k][myKey] = csvListDict[k][myKey]
            # Because the HFGT Toolbox has different name fields for different elements, we have this rather awkward approach...
        if 'name' in csvListDict[k]: targetListDict[k]['myName'] = csvListDict[k]['name']
        elif 'operandName' in csvListDict[k]: targetListDict[k]['myName'] = csvListDict[k]['operandName']
        elif 'transformationResourceName' in csvListDict[k]: targetListDict[k]['myName'] = csvListDict[k]['transformationResourceName']
        elif 'independentBufferName' in csvListDict[k]: targetListDict[k]['myName'] = csvListDict[k]['independentBufferName']
        elif 'transportationResourceName' in csvListDict[k]: targetListDict[k]['myName'] = csvListDict[k]['transportationResourceName']
        else:
            logger.error(f"This csv file {csvFileName} does not have a column dedicated to element names!")
            sys.exit(1)
    return targetListDict
def safeReadCSV(csvFilePath:pl.Path, fillValue=None, dfOrient:str = "records") -> dict | list:
    """
    Read a CSV file "safely" making sure to replace NaNs with a value of your choice.  The output can be either a
    list of dictionaries or a dictionary of lists.
    Args:
        csvFilePath: The path to a CSV file that instantiates the reference architecture.
        fillValue:  The value to fill in the NaN values with. (e.g. None, "", etc.)
        dfOrient:  The orientation of the dictionary (e.g. "records", "list"
    Returns:
        csvListDict:  A list of dictionaries or a dictionary of lists describing the CSV file.
    """
    dfTemp = pd.read_csv(csvFilePath, dtype="str", skipinitialspace=True)
    # Replace all NaNs with Nones.
    if dfTemp.isna().to_numpy().any():
        dfTemp = dfTemp.where(pd.notna(dfTemp), fillValue)
    else: pass
    if dfOrient == "records":
        csvListDict = dfTemp.to_dict(orient=dfOrient)
    else:
        csvListDict = dfTemp.to_dict(orient="list")
    return csvListDict
def safeWriteCSV(dataDict,csvFilePath):
    dfTemp = pd.DataFrame(dataDict)
    dfTemp.to_csv(csvFilePath, index=False,na_rep='',encoding='utf-8')
    return True

def instantiateRefArchElemDict(sysMLInsArchDict:dict,sysMLRefArchDict:dict,csvFilePath: pl.Path) -> dict:
    """
    Given a SysML-compliant dictionary describing an instantiated architecture, a SysML-compliant dictionary describing
    a reference architecture, and the path to a specific Reference Architecture Compliant CSV file, instantiate the
    associate element of the reference architecture.
    Args:
        sysMLInsArchDict:  A SysML-compliant dictionary describing the instantiated architecture.
        sysMLRefArchDict:  A SysML-compliant dictionary describing the reference architecture.
        csvFilePath: The path to a CSV file that instantiates the reference architecture.
    Returns:
        sysMLInsArchDict:  A SysML-compliant dictionary describing the instantiated architecture.
    """
    csvListDict = safeReadCSV(csvFilePath,'')
    tempListDict, refDictKeys = importRefArchElement(sysMLRefArchDict, len(csvListDict))
    validateCSVElemDict(refDictKeys, csvListDict, str(csvFilePath.name))
    tempListDict = insertCSVElemDict(tempListDict,csvListDict,csvFilePath.name)
    sysMLInsArchDict.extend(tempListDict)
    return sysMLInsArchDict
def instantiateRefArchSystemDict(sysMLRefArchDict:dict,refArchName:str,csvFolderPath: pl.Path):
    """
    Given the path to a folder full of Reference Architecture Compliant CSV, instantiate a SysML Reference Architecture
    Dictionary based on the CSV data.
    Args:
        sysMLRefArchDict:  A SysML-compliant dictionary describing the reference architecture.
        refArchName:  The name of the reference architecture.
        csvFolderPathoutputDirectory (optional, str): The output directory to output to.
    Returns:
        sysMLInsArchDict:  A SysML-compliant dictionary describing the instantiated architecture.
    """
    # Section 1:  Create hash tables for the indices of all the part defs, item defs, and action defs.
    idxMapRefArchPartDict   = {sysMLRefArchDict['part def'][k]['myName']: k for k in range(len(sysMLRefArchDict['part def']))}
    idxMapRefArchItemDict   = {sysMLRefArchDict['item def'][k]['myName']: k for k in range(len(sysMLRefArchDict['item def']))}
    idxMapRefArchActionDict = {sysMLRefArchDict['action def'][k]['myName']: k for k in range(len(sysMLRefArchDict['action def']))}

    # Section 2:  Instantiate the top level part/system
    sysMLInsArchDict = copy.deepcopy(sysMLRefArchDict)
    csvFilePath = csvFolderPath / (refArchName + ".csv")
    sysMLInsArchDict['part'] = []
    idx = idxMapRefArchPartDict.get(refArchName)
    if idx is None:
        logger.error(f"{refArchName} is not in the Reference Architecture! Reconcile!  Abort! Abort!")
        sys.exit(1)
    sysMLInsArchDict['part'] = instantiateRefArchElemDict(sysMLInsArchDict['part'],sysMLInsArchDict['part def'][idx],csvFilePath)

    # Section 3:  Instantiate the operands/items
    csvItemFolderPath = csvFolderPath / "items"
    csvItemFilePaths  = sorted(csvItemFolderPath.glob("*.csv"))
    sysMLInsArchDict['part'][0]['item'] = []
    # Loop over item csv files.  No instantiation of items for which there is no csv file!
    for k in range(len(csvItemFilePaths)):
        csvFilePath = csvItemFilePaths[k]
        idx = idxMapRefArchItemDict.get(csvFilePath.stem)
        if idx is None:
            logger.error(f"{csvFilePath.stem} is not in the Reference Architecture! Reconcile!  Abort! Abort!")
            sys.exit(1)
        sysMLInsArchDict['part'][0]['item'] = instantiateRefArchElemDict(sysMLInsArchDict['part'][0]['item'],
                                                              sysMLInsArchDict['item def'][idx], csvFilePath)

        # Section 3.1:  Instantiate the parts of the operands/items -- The OperandPlaces and OperandTransitions
        if (csvFilePath.parent / (csvFilePath.stem + "-parts")).is_dir():
            csvItemPartsFolderPath = (csvFilePath.parent / (csvFilePath.stem + "-parts"))
            csvItemPartsFilePaths = sorted(csvItemPartsFolderPath.glob("*.csv"))

            sysMLInsArchDict['part'][0]['item'][k]['part'] = []
            for k1 in range(len(csvItemPartsFilePaths)):
                csvFilePath = csvItemPartsFilePaths[k1]
                idx1 = idxMapRefArchPartDict.get(csvFilePath.stem)
                if idx1 is None:
                    logger.error(f"{csvFilePath.stem} is not in the Reference Architecture! Reconcile!  Abort! Abort!")
                    sys.exit(1)
                sysMLInsArchDict['part'][0]['item'][k]['part'] = instantiateRefArchElemDict(sysMLInsArchDict['part'][0]['item'][k]['part'],
                                                                                            sysMLInsArchDict['part def'][idx1],
                                                                                            csvFilePath)
    # Section 4:  Instantiate the parts
    csvPartFolderPath = csvFolderPath / "parts"
    csvPartFilePaths = sorted(csvPartFolderPath.glob("*.csv"))
    sysMLInsArchDict['part'][0]['part'] = []
    listDictKeys = [{} for _ in range(len(csvPartFilePaths))]
    # Loop over part csv files. No instantiation of parts for which there is no csv file!
    for k in range(len(csvPartFilePaths)):
        csvFilePath = csvPartFilePaths[k]
        idx = idxMapRefArchPartDict.get(csvFilePath.stem)
        if idx is None:
            logger.error(f"{csvFilePath.stem} is not in the Reference Architecture! Reconcile!  Abort! Abort!")
            sys.exit(1)
        tempSysMLRefArchDict = copy.deepcopy(sysMLInsArchDict['part def'][idx])
        # Each part def element in the reference architecture is flat, so we need to get the attributes of the associated actions.
        tempList = tempSysMLRefArchDict['action']
        tempList = [x for x in tempList if x not in ('transformProcess', 'transportProcess')]
        try:
            if len(tempList) > 1:
                raise ValueError(f"This reference part {tempSysMLRefArchDict['myName']} has more than one action!"
                                 f"This workflow assumes 1 action per part! Abort! Abort!")
        except ValueError as e:
            logger.error(e)
            sys.exit(1)
        # Note:  In this design, the CSV file has the attributes of both the part and the action!
        # Note:  Merge the attributes of the action with the attributes of the part.  This is potentially problematic
        # because the attributes of the part and of the action are likely to have an intersection.  This is handled in two
        # ways.  When the CSV data is imported, we assume that the data only applies to attributes that are NOT in the intersection.
        # and then we only copy back the elements that are not in the intersection.  CSV data is ugly!


        print('hello.  You need exception handling on the reference architecture needs to give you the class info!')
        tempSysMLRefArchDict = copy.deepcopy(sysMLRefArchDict['action def'][idxMapRefArchActionDict[tempList[0]['myClass']]]) | copy.deepcopy(tempSysMLRefArchDict)
        sysMLInsArchDict['part'][0]['part'] = instantiateRefArchElemDict(sysMLInsArchDict['part'][0]['part'],tempSysMLRefArchDict, csvFilePath)

    # Loop over parts and put their action attributes back into the attributes.
    for k in range(len(sysMLInsArchDict['part'][0]['part'])):
        # Note that each part only has one action in its reference architecture!
        idx = [i for i, x in enumerate(sysMLInsArchDict['part'][0]['part'][k]['action']) if x not in ('transformProcess', 'transportProcess')][0]
        # Just get the instance from the reference architecture and its default values
        tempDict = copy.deepcopy(sysMLRefArchDict['action def'][idxMapRefArchActionDict[sysMLInsArchDict['part'][0]['part'][k]['action'][idx]['myClass']]])
        # Get the keys from the associated part that has action attributes...
        actionKeys1 = set(sysMLInsArchDict['part def'][idxMapRefArchPartDict[sysMLInsArchDict['part'][0]['part'][k]['myClass']]].keys())
        actionKeys2 = set(tempDict.keys())
        actionKeys  = sorted(actionKeys2 - actionKeys1)
        for myKey in actionKeys:
            tempDict[myKey] = sysMLInsArchDict['part'][0]['part'][k][myKey]
            del sysMLInsArchDict['part'][0]['part'][k][myKey]
        # Because this a reference architecture element the name of the element is the same as its class.
        tempDict['myClass'] = tempDict['myName']
        # myName now becomes the name of the instance -- but we don't know what it is yet.
        tempDict['myName'] = tempDict['name']
        sysMLInsArchDict['part'][0]['part'][k]['action'][idx] = copy.deepcopy(tempDict)
    return sysMLInsArchDict

def translateCSVFolderToRefArch(csvFolderPath,translatorFile):
    # The SysML file that translates the Matpower CSV files to CSV files that are compliant with the reference architecture
    translatorPath = csvFolderPath /  translatorFile
    # Import the translator
    translatorDict = importSysMLFile(translatorPath)
    rawCSVFolderPath = csvFolderPath / "raw"
    rawCSVFilePaths  = sorted(rawCSVFolderPath.glob("*.csv"))
    # Create a hash table for the part defs in the SysML translator
    idxMapTranslatorDict = {translatorDict['part def'][k]['myName'] : k for k in range(len(translatorDict['part def']))}
    refCSVDictData = {}
    # Read each CSV file, translate it, export the translated CSV file
    for k in range(len(rawCSVFilePaths)):
        rawCSVDictData = safeReadCSV(rawCSVFilePaths[k], dfOrient="list")
        idx = idxMapTranslatorDict.get(rawCSVFilePaths[k].stem)
        if idx is None:
            logger.error(f"{rawCSVFilePaths[k].name} is not in the SoS-Reference-Translator!  Reconcile!  Abort! Abort!")
            sys.exit(1)
        myKey = translatorDict['part def'][idx][rawCSVFilePaths[k].stem]
        refCSVDictData[myKey] = {translatorDict['part def'][idx][myKey]: rawCSVDictData[myKey] for myKey in rawCSVDictData}
        refCSVFilePath = csvFolderPath / "parts" / f"{translatorDict['part def'][idx][rawCSVFilePaths[k].stem]}.csv"
        safeWriteCSV(refCSVDictData[myKey], refCSVFilePath)
    return refCSVDictData

def applyESPRefArch(generatorDict, busDict, branchDict):
    # Reformating the MATPOWER dictionaries:  Separating the part attributes into part (resource) and action (process)
    generatorDict = reformatGenDict(generatorDict)
    busDict = reformatBusDict(busDict)
    branchDict = reformatBranchDict(branchDict)
    return generatorDict, busDict, branchDict
def applyHFGTMetaArch2EPS(sysMLStemDict,generatorDict, busDict, branchDict):
    # Applying the HFGT Meta-Architecture
    # Collating part def for generator, bus and branch data
    busDict = inheritMetaResourceAttributes(sysMLStemDict, busDict,"TransformationResource")
    generatorDict = inheritMetaResourceAttributes(sysMLStemDict, generatorDict,"TransformationResource")
    generatorDict = inheritBusAttrobites(busDict, generatorDict)
    branchDict = inheritMetaResourceAttributes(sysMLStemDict, branchDict, "TransportationResource")

    # Generating action def for generator, bus and branch data
    busDict = inheritMetaProcessAttributes(sysMLStemDict, busDict, "TransformProcess")
    generatorDict = inheritMetaProcessAttributes(sysMLStemDict, generatorDict, "TransformProcess")
    branchDict = inheritMetaProcessAttributes(sysMLStemDict, branchDict,"TransportProcess")
    return generatorDict, busDict, branchDict
def applySysMLV2Syntax(sysMLStemDict,generatorDict, busDict, branchDict):
    # Applying SysML Syntax
    # Rearranging the dictionary so its order is part def, action def, and then part
    busDict = reorderReferenceDictKeys(busDict)
    generatorDict = reorderReferenceDictKeys(generatorDict)
    branchDict = reorderReferenceDictKeys(branchDict)

    # Reorganizing Bus, Branch and Generator Part
    busDict = updateBusPart(busDict)
    generatorDict = updateGeneratorPart(generatorDict)
    branchDict = updateBranchPart(branchDict, busDict, generatorDict)

    # Merging the 3 dictionaries with the base dictionary to create the Instantiated file
    mergedDict = mergeDict(sysMLStemDict, [generatorDict, busDict, branchDict])
    return mergedDict
def runMatpower2HFGT(epsSysMLStemFilePath,epsGenCSVFilePath,epsBusCSVFilePath,epsBranchFilePath):
    # Generate a SysML compliant dictionary from the Electric Power System Stem File and the MatPower CSVs
    sysMLStemDict, generatorDict, busDict, branchDict = importMatPowerData(epsSysMLStemFilePath,epsGenCSVFilePath,epsBusCSVFilePath,epsBranchFilePath)

    # Applying the Electric Power System Reference Architecture
    # Reformating the MATPOWER dictionaries:  Separating the part attributes into part (resource) and action (process)
    generatorDict, busDict, branchDict = applyESPRefArch(generatorDict, busDict, branchDict)

    # Applying the HFGT Meta-Architecture
    generatorDict, busDict, branchDict =  applyHFGTMetaArch2EPS(sysMLStemDict,generatorDict, busDict, branchDict)

    # Applying SysML Syntax
    mergedDict = applySysMLV2Syntax(sysMLStemDict,generatorDict, busDict, branchDict)
    return mergedDict