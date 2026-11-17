"""
Copyright (c) 2018-2026 Engineering Systems Analytics LLC, Stevens Institute of Technology
@author:  Amro M. Farid
@version: 4.7.6
@Note:  Version 4.0 is a major release constituting a full rewrite of the entire code base.
@Note:  See Bitbucket Commit History for an understanding the contributions of each author.
@Acknowledgement:  Thanks goes to Dr. Amro M. Farid, Dr. Wester C. H. Schoonenberg, and Dr. Dakota Thompson as the principal
                    authors of Versions 1, 2, 3 respectively.
@Modified: 04/02/2026
@ Provided under the Creative Commons 4.0 License
Developed with Python 3.11.9
"""

import sys
import pathlib as pl
import hfgt_toolbox.HFGTToolbox as hfgt
import hfgt_toolbox.matpower2HFGT as mpHFGT
from loguru import logger
import copy
import os
import pandas as pd
import plotly.express as px



if __name__ == '__main__':
    # This demonstrates a complete SysML file with an included reference architecture.  This is the most flexible option
    # for storing and loading data for complex engineering system.
    refArchFilePath = pl.Path("1_Cleaned_Raw_Data/SysMLs/SoS-Reference-Architecture-Sysml-Base-2026-11-10.sysml")
    sysMLRefArchDict = hfgt.importSysMLFile(refArchFilePath)
    sysMLRefArchDict = hfgt.validateSysMLDict(sysMLRefArchDict,'reference','revise')

    sysMLInsArchDict1 = hfgt.importSysMLFile("2_PyHFGTInput_Data/SysMLs/NEAC-freight-Sysml-Place-Specific-Fatigue-Experimental.sysml")
    sysMLInsArchDict1 = sysMLRefArchDict | sysMLInsArchDict1
    sysMLInsArchDict1 = hfgt.validateSysMLDict(sysMLInsArchDict1,'instantiated','revise')


    # In some simplified cases, the data can be stored in a reference architecture plus a folder full of CSV files with
    # no more than one process per resource.
    csvFolderPath = pl.Path("1_Cleaned_Raw_Data/CSVs/NEAC-freight-Sysml-Place-Specific-Fatigue-2026-11-10/")
    sysMLInsArchDict2 = mpHFGT.instantiateRefArchSystemDict(sysMLRefArchDict,'SoS-Reference',csvFolderPath)
    myResult, myString = hfgt.debugEquivObjs(sysMLInsArchDict1, sysMLInsArchDict2)
    print('I have finished successfully!')


    testName = "Test 5e.4: Matpower2HFGT Workflow"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test starts from MATPOWER CSV data and then runs a HFNMCF analysis on the DC Optimal Power
    # Flow Problem of a 9-Bus Electric Power System and then compares to a benchmark result.
    # The input data folder for the IEEE Test Case in CSV format
    csvFolderPath  = pl.Path("1_Cleaned_Raw_Data/CSVs/IEEE-TestCase-9/")
    # The name of the translatorFile for the IEEE Test Case
    translatorFile = "SoS-Reference-Translator-2026-11-10.sysml"
    # The name of the SysML Reference Architecture file
    refArchFilePath = pl.Path("1_Cleaned_Raw_Data/SysMLs/SoS-Reference-Architecture-Sysml-Base-2026-11-10.sysml")
    # Step 1:  Tanslate the Matpower CSV files to CSV files that are compliant with the reference architecture
    refCSVDictData = mpHFGT.translateCSVFolderToRefArch(csvFolderPath, translatorFile)
    # Step 2:  Import the Reference Architecture and Validate it for Correctness.
    sysMLRefArchDict = hfgt.importSysMLFile(refArchFilePath)
    sysMLRefArchDict = hfgt.validateSysMLDict(sysMLRefArchDict,'reference','revise')
    # Step 3:  Use the new CSV data to instantiate the reference architecture
    sysMLInsArchDict = mpHFGT.instantiateRefArchSystemDict(sysMLRefArchDict, 'SoS-Reference', csvFolderPath)
    print('hello')

    sysMLRefArchDict = hfgt.importSysMLFile(refArchFilePath)
    sysMLRefArchDict = hfgt.validateSysMLDict(sysMLRefArchDict,'reference','revise')

    epsSysMLStemFilePath = pl.Path("1_Cleaned_Raw_Data/SysMLs/MAT-EPS-DCOPF-STEM-Sysml-Base-2026-11-10.sysml")
    epsGenCSVFilePath    = pl.Path("1_Cleaned_Raw_Data/CSVs/genCase9.csv")
    epsBusCSVFilePath    = pl.Path("1_Cleaned_Raw_Data/CSVs/busCase9.csv")
    epsBranchFilePath    = pl.Path("1_Cleaned_Raw_Data/CSVs/branchCase9.csv")
    inputFileName        = "MAT-EPS9-DCOPF-Sysml-Base-2026-11-10.sysml"
    outputFilePath       = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
    # Run The MatPower2HFGT Workflow   myLFES-EPS9-DCOPF-Sysml-Base-2026-11-10.json
    epsSysMLV2Dict = mpHFGT.runMatpower2HFGT(epsSysMLStemFilePath,epsGenCSVFilePath,epsBusCSVFilePath,epsBranchFilePath)
    # Export the SysML-Compliant Electric Power System Data
    exportSysMLFile(epsSysMLV2Dict, outputFilePath)
    # Run HFGT Analysis
    myLFES = runHFGTAnalysis(outputFilePath)
    benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
    benchmarkLFES = loadMyData(benchmarkFilePath)
    myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
    reportTestResult(testName, myResult)
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')






    # # Define Input and Output File Paths
    # freightDecarbCSVFilePath = pl.Path("../1_Cleaned_Raw_Data/CSVs/trip_segments_MelbourneSydney_BEHV_v0013-PBS1_t0018.csv")
    # freightEnergyDF = pd.read_csv(freightDecarbCSVFilePath, encoding='utf-8')
    #
    # # Convert segment time from hours to seconds.
    # freightEnergyDF["segment_time"] = 3600 * freightEnergyDF["segment_time"]
    # # Calculate Histogram Properties
    # x = freightEnergyDF["segment_time"].dropna()
    # x = x[x < 0.5*3600]
    # xmin = x.min()
    # xmax = x.max()
    # nbins = 20
    # bin_size = (xmax - xmin) / nbins
    # # Visualize Histogram
    # fig = px.histogram(freightEnergyDF, x="segment_time")  # Segment Time is in Seconds.
    # fig.update_traces(
    #     xbins=dict(
    #         start=xmin,
    #         end=xmax,
    #         size=bin_size
    #     )
    # )
    # fig.show()
    #
    # freightEnergyDict = freightEnergyDF.to_dict(orient="records")
    # freightEnergyDict = mpHFGT.matPowerCSV2SysMLDict(freightDecarbCSVFilePath, "FreightEnergyData")

# LINESTRING (1142605.4396066212 -4193907.6291571804,
#             1142605.4396066212 -4193907.6291571804,
#             1142605.4396066212 -4193907.6291571804,
#             1142660.5314204304 -4193899.9153292077,
#             1142715.5119415417 -4193893.299231413)
# LINESTRING (1142715.5119415417 -4193893.299231413,
#             1142774.8987223404 -4193887.130646186,
#             1142835.0554278188 -4193882.1492900546)
