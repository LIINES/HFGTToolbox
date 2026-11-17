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

import sys, os, copy, shutil
import pathlib as pl
import regex                # Version 2025.7.34
from hfgt_toolbox.HFGTToolbox import (GIS2SysMLFile, runHFGTAnalysis, loadMyData, importInputData,
                                      importSysMLFile, saveMyData, exportSysMLFile, convertCSV2SysML, debugEquivObjs,
                                      debugEquivTextFiles, dictify, sortDictionaryKeys, reportTestResult, calcTestFilePaths1,
                                      calcTestFilePaths2, fixTestLFESFilePaths)
import hfgt_toolbox.matpower2HFGT as mpHFGT
import cProfile
import pstats

if __name__ == '__main__':
    makeBenchmarkFiles = True
    devMode = True
    listOfTests = ['all']

    # Test 0 Block:  These tests are related to the serialization/deserialization of XML and SysML files.
    testName = "Test 0a:  Convert GIS Data in CSV Format to SysML"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if GIS data in CSV format can be converted into the corresponding SysML file.
    if '0a' in listOfTests or 'all' in listOfTests:
        myResult = GIS2SysMLFile("1_Cleaned_Raw_Data/CSVs/geodata.csv",    # The input path of the CSV file
                      "2_PyHFGTInput_Data/SysMLs/geodata.sysml",         # The output path of the SysML File
                      "geoDataClassName",                                   # The name of the class that the CSV data describes
                      'city')                                           # The index of the column that has the unique names of the CSV data.
        reportTestResult(testName,myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 0b - ExampleNetwork-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if we can run a default structural analysis, save the result to disk, and load
    # it back again without change.
    if '0b' in listOfTests or 'all' in listOfTests:
        myLFES1 = runHFGTAnalysis("2_PyHFGTInput_Data/XMLs/ExampleNetwork-Defaultxml-Base-2026-11-10.xml")
        myLFES2 = loadMyData(myLFES1.outputFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName,myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 0c -- Round Trip Equivalance of Input SysML File to Output SysML File"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I load a SysML input file, then export it again, then the two SysML text
    # files are equivalent.
    if '0c' in listOfTests or 'all' in listOfTests:
        inputFilePath = pl.Path("2_PyHFGTInput_Data/SysMLs/TransportationNetwork-Sysml-Base-2026-11-10.sysml")
        outputFilePath = pl.Path("3_PyHFGT_Output_Data/myLFES-Default-TransportationNetwork-Default-Sysml-2026-11-10.sysml")
        mySysMLDict = importSysMLFile(inputFilePath)
        exportSysMLFile(mySysMLDict, outputFilePath)
        myResult, myString = debugEquivTextFiles(inputFilePath, outputFilePath)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 0d -- Equivalance of XML Import and SysML Import"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I load one input file in XML format and then load a corresponding input
    # file in SysML format, then they will produce equivalent data in memory.
    if '0d' in listOfTests or 'all' in listOfTests:
        inputFilePath1 = pl.Path("2_PyHFGTInput_Data/XMLs/TransportationNetwork-Defaultxml-Base-2026-11-10.xml")              # Convert input file path string to Path object.
        inputFilePath2 = pl.Path("2_PyHFGTInput_Data/SysMLs/TransportationNetwork-Sysml-Base-2026-11-10.sysml")          # Convert input file path string to Path object.
        myLFES1 = importInputData(inputFilePath1)
        myLFES2 = importInputData(inputFilePath2)
        myLFES2.inputFilePath = myLFES1.inputFilePath
        myLFES2.outputFilePath = myLFES1.outputFilePath
        myLFES2.inputDataFormat = myLFES1.inputDataFormat
        myLFES2.juliaOutputFilePath = myLFES1.juliaOutputFilePath
        myLFES2.view = None
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 0e.1 -- Round Trip SysML Import Export"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import a SysML file into a dictionary, and I load the same SysML file
    # into a myLFES ojbect and then convert it into a dictionary, then the two dictionaries are equivalent.
    # It then double-checks that if I export both of these dictionaries to a SysML file, then they are equivalent.
    if '0e.1' in listOfTests or 'all' in listOfTests:
        inputFilePath = pl.Path("2_PyHFGTInput_Data/SysMLs/TransportationNetwork-Sysml-Base-2026-11-10.sysml")
        mySysMLDict1 = importSysMLFile(inputFilePath)
        myLFES = importInputData(inputFilePath)
        mySysMLDict2 = myLFES.convertLFES2SysMLDict()
        myResult, myString = debugEquivObjs(mySysMLDict1, mySysMLDict2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 0e.2 -- Round Trip SysML Import Export"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  Building on the results of the previous test (0e.1), this test double-checks that if I export
    # both of these dictionaries to a SysML file, then they are equivalent.
    if '0e.2' in listOfTests or 'all' in listOfTests:
        outputFilePath1 = pl.Path("3_PyHFGT_Output_Data/myLFES-Default-TransportationNetwork-Default-Sysml-2026-11-10-1.sysml")
        outputFilePath2 = pl.Path("3_PyHFGT_Output_Data/myLFES-Default-TransportationNetwork-Default-Sysml-2026-11-10-2.sysml")
        mySysMLDict1 = sortDictionaryKeys(mySysMLDict1,False)
        mySysMLDict2 = sortDictionaryKeys(mySysMLDict2,False)
        exportSysMLFile(mySysMLDict1, outputFilePath1)
        exportSysMLFile(mySysMLDict2, outputFilePath2)
        myResult, myString = debugEquivTextFiles(outputFilePath1, outputFilePath2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 0f -- Conversion of XML Data to SysML Data --Example Network Case"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dictionary, then write that to a SysML file, and then import the SysML file again to create
    # myLFES2, then myLFES1 == myLFES2
    if '0f' in listOfTests or 'all' in listOfTests:
        inputFilePath  = pl.Path("2_PyHFGTInput_Data/XMLs/ExampleNetwork-Defaultxml-Base-2026-11-10.xml")
        outputFilePath = pl.Path("2_PyHFGTInput_Data/SysMLs/ExampleNetwork-Sysml-Base-2026-11-10.sysml")
        myLFES1 = importInputData(inputFilePath)
        tempLFES = copy.deepcopy(myLFES1)
        mySysMLDict = tempLFES.convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        myLFES2.inputFilePath = myLFES1.inputFilePath
        myLFES2.outputFilePath = myLFES1.outputFilePath
        myLFES2.inputDataFormat = myLFES1.inputDataFormat
        myLFES2.juliaOutputFilePath = myLFES1.juliaOutputFilePath
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 1 Block:  These tests are related to the HFGT Textbook example.
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    testName = "Test 1a.1:  ExampleNetwork-Defaultxml-Base-2026-11-10.xml"
    # Test Description:  This test runs a HFGT analysis on the input XML file pertaining to Ch. 4 of the HFGT textbook
    # and compares to a benchmark result.
    if '1a.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ExampleNetwork-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1a.2 -- Conversion of XML Data to SysML Data -- ExampleNetwork"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '1a.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ExampleNetwork-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1a.3:  ExampleNetwork-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFGT analysis on the input SysML file pertaining to Ch. 4 of the HFGT textbook
    # and compares to a benchmark result.
    if '1a.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "ExampleNetwork-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1b.1:  ExampleNetworkNoOperandNets-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs the input XML file pertaining to Ch. 4 of the HFGT textboo, but without the
    # operand net, and compares it to a benchmark result.
    if '1b.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ExampleNetworkNoOperandNets-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1b.2 -- Conversion of XML Data to SysML Data -- ExampleNetworkNoOperandNets"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '1b.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ExampleNetworkNoOperandNets-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1b.3:  ExampleNetworkNoOperandNets-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs the input XML file pertaining to Ch. 4 of the HFGT textboo, but without the
    # operand net, and compares it to a benchmark result.
    if '1b.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "ExampleNetworkNoOperandNets-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1c.1:  ExampleNetworkNoOperandNetsHFNMCF-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs the input XML file pertaining to Ch. 4 of the HFGT textbook, but without the
    # operand net, but with HFNMCF funcitonality and compares to a benchmark result.
    if '1c.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ExampleNetworkNoOperandNetsHFNMCF-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1c.2 -- Conversion of XML Data to SysML Data -- ExampleNetworkNoOperandNetsHFNMCF"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '1c.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ExampleNetworkNoOperandNetsHFNMCF-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 1c.3:  ExampleNetworkNoOperandNetsHFNMCF-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs the input XML file pertaining to Ch. 4 of the HFGT textbook, but without the
    # operand net, but with HFNMCF funcitonality and compares to a benchmark result.
    if '1c.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "ExampleNetworkNoOperandNetsHFNMCF-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 2 Block:  These tests are related to conducting resilience analyses.
    testName = "Test 2.1:  ResilientICI-Data-Defaultxml-Default-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs the systems-of-systems resilience analysis in A. M. Farid, “A Hetero-functional
    # Graph Resilience Analysis for Convergent Systems-of-Systems,” International Journal of Systems Science, pp. 1–26, 2025.
    # and then compares to a benchmark result.
    if '2.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ResilientICI-Data-Defaultxml-Default-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 2.2 -- Conversion of XML Data to SysML Data -- ResilientICI-Data"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '2.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ResilientICI-Data-Defaultxml-Default-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 2.3:  ResilientICI-Data-Sysml-Default-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs the systems-of-systems resilience analysis in A. M. Farid, “A Hetero-functional
    # Graph Resilience Analysis for Convergent Systems-of-Systems,” International Journal of Systems Science, pp. 1–26, 2025.
    # and then compares to a benchmark result.
    if '2.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "ResilientICI-Data-Sysml-Default-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 3 Block:  These tests are related to transportation systems.
    testName = "Test 3a.1:  TransportationNetwork-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on Figure 9.12 of F. S. Hillier, Introduction to operations
    # research. New York, NY, USA: Tata McGraw-Hill Education, 9th ed., 2010. and then compares to a benchmark result.
    if '3a.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "TransportationNetwork-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3a.2 -- Conversion of XML Data to SysML Data -- TransportationNetwork"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '3a.2' in listOfTests or 'all' in listOfTests:
        # Because the SysML file for the Transportation Network was generated by hand and used to establish Test 0a - Of,
        # this test is empty.
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3a.3:  TransportationNetwork-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on Figure 9.12 of F. S. Hillier, Introduction to operations
    # research. New York, NY, USA: Tata McGraw-Hill Education, 9th ed., 2010. and then compares to a benchmark result.
    if '3a.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "TransportationNetwork-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3b.1:  miniTEN-Defaultxml-Coordinated-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on the electrified transportation nexus system found in:
    # J. Qiu, D. J. Thompson, K. Youcef-Toumi, and A. M. Farid, “Optimal Multi-Modal Transportation and Electric Power
    # Flow: The Value of Coordinated Dynamic Operation,” https://arxiv.org/abs/2510.10914., 2025.
    if '3b.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "miniTEN-Defaultxml-Coordinated-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3b.2 -- Conversion of XML Data to SysML Data -- Mini-TEN"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '3b.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/miniTEN-Defaultxml-Coordinated-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3b.3:  miniTEN-Defaultxml-Coordinated-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on the electrified transportation nexus system found in:
    # J. Qiu, D. J. Thompson, K. Youcef-Toumi, and A. M. Farid, “Optimal Multi-Modal Transportation and Electric Power
    # Flow: The Value of Coordinated Dynamic Operation,” https://arxiv.org/abs/2510.10914., 2025.
    if '3b.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "miniTEN-Defaultxml-Coordinated-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3c.1:  NEAC-freight-Defaultxml-Place-Specific-Fatigue-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on a synthetic heavy-freight corridor that is place-specific with
    # the full set of Australian fatigue rules.
    if '3c.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "NEAC-freight-Defaultxml-Place-Specific-Fatigue-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3c.2 -- Conversion of XML Data to SysML Data -- NEAC Freight Place Specific w/ Fatigue"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '3b.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/NEAC-freight-Defaultxml-Place-Specific-Fatigue-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 3c.3:  NEAC-freight-Sysml-Place-Specific-Fatigue-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on a synthetic heavy-freight corridor that is place-specific with
    # the full set of Australian fatigue rules.
    if '3c.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "NEAC-freight-Sysml-Place-Specific-Fatigue-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 4 Block:  These tests are related to resource-constrained project scheduling.
    testName = "Test 4a.1:  RCPSP1-Defaultxml-Renewable-Resources-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Renewable Resource Constrained Project Scheduling Problem
    # in A. Hosseini and A. M. Farid, “Extending Resource Constrained Project Scheduling to Mega-Projects with Model-Based
    # Systems Engineering & Hetero-functional Graph Theory,” https://arxiv.org/abs/2510.19035. 2025. and then compares
    # to a benchmark result.
    if '4a.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "RCPSP1-Defaultxml-Renewable-Resources-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 4a.2 -- Conversion of XML Data to SysML Data -- RCPSP1"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '4a.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/RCPSP1-Defaultxml-Renewable-Resources-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 4a.3:  RCPSP1-Sysml-Renewable-Resources-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Renewable Resource Constrained Project Scheduling Problem
    # in A. Hosseini and A. M. Farid, “Extending Resource Constrained Project Scheduling to Mega-Projects with Model-Based
    # Systems Engineering & Hetero-functional Graph Theory,” https://arxiv.org/abs/2510.19035. 2025. and then compares
    # to a benchmark result.
    if '4a.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "RCPSP1-Sysml-Renewable-Resources-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 4b.1: RCPSP1-Defaultxml-Renewable-Resources-Esn-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Renewable Resource Constrained Project Scheduling Problem
    # in A. Hosseini and A. M. Farid, “Extending Resource Constrained Project Scheduling to Mega-Projects with Model-Based
    # Systems Engineering & Hetero-functional Graph Theory,” https://arxiv.org/abs/2510.19035. 2025. and then compares
    # to a benchmark result.  The main difference to Test 4a is that addition of a synchronized engineering system net.
    if '4b.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "RCPSP1-Defaultxml-Renewable-Resources-Esn-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 4b.2 -- Conversion of XML Data to SysML Data -- RCPSP1 w/ ESN"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '4b.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/RCPSP1-Defaultxml-Renewable-Resources-Esn-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 4b.3:  RCPSP1-Sysml-Renewable-Resources-Esn-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Renewable Resource Constrained Project Scheduling Problem
    # in A. Hosseini and A. M. Farid, “Extending Resource Constrained Project Scheduling to Mega-Projects with Model-Based
    # Systems Engineering & Hetero-functional Graph Theory,” https://arxiv.org/abs/2510.19035. 2025. and then compares
    # to a benchmark result.  The main difference to Test 4a is that addition of a synchronized engineering system net.
    if '4b.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "RCPSP1-Sysml-Renewable-Resources-Esn-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 5 Block:  These tests are related to electric power systems.
    testName = "Test 5a.1: ElectricPowerSystem-Defaultxml-StaticEconomicDispatch-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Economic Dispatch Problem of an Electric Power System
    # and then compares to a benchmark result.
    if '5a.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ElectricPowerSystem-Defaultxml-StaticEconomicDispatch-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5a.2 -- Conversion of XML Data to SysML Data -- Electric Power System Economic Dispatch"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '5a.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ElectricPowerSystem-Defaultxml-StaticEconomicDispatch-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5a.3:  ElectricPowerSystem-Sysml-Staticeconomicdispatch-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Economic Dispatch Problem of an Electric Power System
    # and then compares to a benchmark result.
    if '5a.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "ElectricPowerSystem-Sysml-Staticeconomicdispatch-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5b.1: ElectricPowerSystem-Defaultxml-DynamicEconomicDispatch-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Dynamic Economic Dispatch Problem of an Electric Power
    # System and then compares to a benchmark result.
    if '5b.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ElectricPowerSystem-Defaultxml-DynamicEconomicDispatch-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5b.2 -- Conversion of XML Data to SysML Data -- Electric Power System Dynamic Economic Dispatch"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '5b.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ElectricPowerSystem-Defaultxml-DynamicEconomicDispatch-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5b.3: ElectricPowerSystem-Sysml-Dynamiceconomicdispatch-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Dynamic Economic Dispatch Problem of an Electric Power
    # System and then compares to a benchmark result.
    if '5b.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "ElectricPowerSystem-Sysml-Dynamiceconomicdispatch-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5c.1: EPS9-DCOPF-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the DC Optimal Power Flow Problem of an Electric Power
    # System and then compares to a benchmark result.
    if '5c.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "EPS9-DCOPF-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = ("Test 5c.2 -- Conversion of XML Data to SysML Data -- 9Bus DC Optimal Power Flow")
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '5c.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/EPS9-DCOPF-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5c.3: EPS9-DCOPF-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the DC Optimal Power Flow Problem of an Electric Power
    # System and then compares to a benchmark result.
    if '5c.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "EPS9-DCOPF-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5d.1: EPS2-UnitCommitment-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the DC Optimal Power Flow Problem of an Electric Power
    # System and then compares to a benchmark result.
    if '5d.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "EPS2-UnitCommitment-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = ("Test 5d.2 -- Conversion of XML Data to SysML Data -- EPS2 Unit Commitment")
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '5d.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/EPS2-UnitCommitment-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 5d.3: EPS2-UnitCommitment-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the Unit Commitment of an Electric Power System and then
    # compares to a benchmark result.
    if '5d.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "EPS2-UnitCommitment-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # testName = "Test 5e.4: Matpower2HFGT Workflow"
    # print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    # print(f"{testName}")
    # # Test Description:  This test starts from MATPOWER CSV data and then runs a HFNMCF analysis on the DC Optimal Power
    # # Flow Problem of an Electric Power System and then compares to a benchmark result.
    # # Define Input and Output File Paths.  This tests the entire workflow for the 9-Bus system.
    # if '5e.4' in listOfTests or 'all' in listOfTests or True:
    #     epsSysMLStemFilePath = pl.Path("1_Cleaned_Raw_Data/SysMLs/MAT-EPS-DCOPF-STEM-Sysml-Base-2026-11-10.sysml")
    #     epsGenCSVFilePath    = pl.Path("1_Cleaned_Raw_Data/CSVs/genCase9.csv")
    #     epsBusCSVFilePath    = pl.Path("1_Cleaned_Raw_Data/CSVs/busCase9.csv")
    #     epsBranchFilePath    = pl.Path("1_Cleaned_Raw_Data/CSVs/branchCase9.csv")
    #     inputFileName        = "MAT-EPS9-DCOPF-Sysml-Base-2026-11-10.sysml"
    #     outputFilePath       = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
    #     # Run The MatPower2HFGT Workflow   myLFES-EPS9-DCOPF-Sysml-Base-2026-11-10.json
    #     epsSysMLV2Dict = mpHFGT.runMatpower2HFGT(epsSysMLStemFilePath,epsGenCSVFilePath,epsBusCSVFilePath,epsBranchFilePath)
    #     # Export the SysML-Compliant Electric Power System Data
    #     exportSysMLFile(epsSysMLV2Dict, outputFilePath)
    #     # Run HFGT Analysis
    #     myLFES = runHFGTAnalysis(outputFilePath)
    #     benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
    #     benchmarkLFES = loadMyData(benchmarkFilePath)
    #     myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
    #     reportTestResult(testName, myResult)
    #     print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 6 Block:  These tests are related to Energy Systems in the TIMES training manuals.
    testName = "Test 6a.1: TIMESCoalSystem-Defaultxml-Staticeconomicdispatch-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on Example 1 - Coal System in the TIMES Traning Manual
    # and then compares to a benchmark result.
    if '6a.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "TIMESCoalSystem-Defaultxml-Staticeconomicdispatch-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 6a.2 -- Conversion of XML Data to SysML Data -- TIMES Coal System"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '6a.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/TIMESCoalSystem-Defaultxml-Staticeconomicdispatch-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 6a.3: TIMESCoalSystem-Sysml-Staticeconomicdispatch-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on Example 1 - Coal System in the TIMES Traning Manual
    # and then compares to a benchmark result.
    if '6a.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "TIMESCoalSystem-Sysml-Staticeconomicdispatch-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 7 Block:  These tests are related to economic input-output systems.
    testName = "Test 7.1: EIO-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on an Economic Input Output System
    # and then compares to a benchmark result.
    if '7.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "EIO-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 7.2 -- Conversion of XML Data to SysML Data -- Economic Input Output"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '7.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/EIO-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 7.3: EIO-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on an Economic Input Output System
    # and then compares to a benchmark result.
    if '7.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "EIO-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 8 Block:  These tests are related to system dynamics models (Forreter Style).
    testName = "Test 8.1: MonoLakeSystemDynamics-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on a System Dynamics model of the Mono Lake hydrological system
    # and then compares to a benchmark result.
    if '8.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "MonoLakeSystemDynamics-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 8.2 -- Conversion of XML Data to SysML Data -- System Dynamics Mono Lake System"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '8.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/MonoLakeSystemDynamics-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 8.3: MonoLakeSystemDynamics-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on a System Dynamics model of the Mono Lake hydrological system
    # and then compares to a benchmark result.
    if '8.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "MonoLakeSystemDynamics-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 9 Block:  These tests are related to multi-energy systems.
    testName = "Test 9a.1: H2NG-NetherlandsAMF-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the integrated hydrogen-natural gas system in
    # W. C. Schoonenberg and A. M. Farid, “Hetero-functional Network Minimum Cost Flow Optimization: : A
    # hydrogen–natural gas network example,” Sustainable Energy Grids and Networks, vol. 31, no. 100749, pp. 1–18, 2022.
    if '9a.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "H2NG-NetherlandsAMF-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 9a.2 -- Conversion of XML Data to SysML Data -- Hydrogen-Natural Gas System"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '9a.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/H2NG-NetherlandsAMF-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 9a.3: H2NG-NetherlandsAMF-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFNMCF analysis on the integrated hydrogen-natural gas system in
    # W. C. Schoonenberg and A. M. Farid, “Hetero-functional Network Minimum Cost Flow Optimization: : A
    # hydrogen–natural gas network example,” Sustainable Energy Grids and Networks, vol. 31, no. 100749, pp. 1–18, 2022.
    if '9a.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "H2NG-NetherlandsAMF-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 9b.1: AMES-NY-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on New York's multi-modal energy system as reported in:
    # D. Thompson and A. M. Farid, “A hetero-functional graph structural analysis of the american multi-modal energy
    # system,” Sustainable Energy, Grids, and Networks, vol. 38, no. 1, pp. 101254–101269, 2024.
    if '9b.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "AMES-NY-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 9b.2 -- Conversion of XML Data to SysML Data -- New York Multi-Modal Energy System"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '9b.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/AMES-NY-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 9b.3: AMES-NY-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on New York's multi-modal energy system as reported in:
    # D. Thompson and A. M. Farid, “A hetero-functional graph structural analysis of the american multi-modal energy
    # system,” Sustainable Energy, Grids, and Networks, vol. 38, no. 1, pp. 101254–101269, 2024.
    if '9b.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "AMES-NY-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 10 Block:  These tests are related to hydrological/watershed systems.
    testName = "Test 10.1: ChesapeakeBayWatershedSystem-Defaultxml-Nitrogenphosphorusdelivery-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on the Chesapeake Bay Watershed as reported in: XXX
    if '10.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ChesapeakeBayWatershedSystem-Defaultxml-Nitrogenphosphorusdelivery-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 10.2 -- Conversion of XML Data to SysML Data -- Chesapeake Bay Watershed System"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '10.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/ChesapeakeBayWatershedSystem-Defaultxml-Nitrogenphosphorusdelivery-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 10.3: ChesapeakeBayWatershedSystem-Sysml-Nitrogenphosphorusdelivery-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on the Chesapeake Bay Watershed as reported in: XXX
    if '10.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "ChesapeakeBayWatershedSystem-Sysml-Nitrogenphosphorusdelivery-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    # Test 11 Block:  These tests are related to healthcare systems.
    testName = "Test 11.1: EndOfLifeCancerCare-Defaultxml-Base-2026-11-10.xml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on a hypothetical healthcare delivery system.
    if '11.1' in listOfTests or 'all' in listOfTests:
        inputFileName = "EndOfLifeCancerCare-Defaultxml-Base-2026-11-10.xml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 11.2 -- Conversion of XML Data to SysML Data -- Synthetic Healthcare Delivery System"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test checks if I import an input XML file to create myLFES1, then convert it into a
    # SysML-compliant dict, then write that to a SysML file, and then import the SysML file again to create myLFES2,
    # then myLFES1==myLFES2
    if '11.2' in listOfTests or 'all' in listOfTests:
        inputFilePath = "2_PyHFGTInput_Data/XMLs/EndOfLifeCancerCare-Defaultxml-Base-2026-11-10.xml"
        inputFilePath, outputFilePath = calcTestFilePaths2(inputFilePath)
        myLFES1 = importInputData(inputFilePath)
        mySysMLDict = (copy.deepcopy(myLFES1)).convertLFES2SysMLDict()
        exportSysMLFile(mySysMLDict, outputFilePath)
        myLFES2 = importInputData(outputFilePath)
        fixTestLFESFilePaths(myLFES1, myLFES2)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(myLFES1, myLFES2)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

    testName = "Test 11.3: EndOfLifeCancerCare-Sysml-Base-2026-11-10.sysml"
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(f"{testName}")
    # Test Description:  This test runs a HFG structural analysis on a hypothetical healthcare delivery system.
    if '11.3' in listOfTests or 'all' in listOfTests:
        inputFileName = "EndOfLifeCancerCare-Sysml-Base-2026-11-10.sysml"
        if pl.Path(inputFileName).suffix == ".xml": inputFilePath = "2_PyHFGTInput_Data/XMLs/" + inputFileName
        else: inputFilePath = "2_PyHFGTInput_Data/SysMLs/" + inputFileName
        myLFES = runHFGTAnalysis(inputFilePath)
        benchmarkFilePath = calcTestFilePaths1(inputFileName, makeBenchmarkFiles)
        benchmarkLFES = loadMyData(benchmarkFilePath)
        print("Testing for Equivalence ...")
        myResult, myString = debugEquivObjs(benchmarkLFES, myLFES)
        reportTestResult(testName, myResult)
        print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')