"""
Copyright (c) 2018-2025 Engineering Systems Analytics LLC
@author: Amro M. Farid
@version 4.5.2
@Note:  Version 4.0 is a major release constituting a full rewrite of the entire code base.
@Acknowledgement:  Thanks goes to Dr. Amro M. Farid, Dr. Wester C. H. Schoonenberg, and Dr. Dakota Thompson as the principal
                    authors of Versions 1, 2, 3 respectively.
@Modified: 10/22/2025
@ Provided under the Creative Commons 4.0 License
"""
import os
import pytest
import sys, os, copy
import pathlib as pl
import pandas as pd
from hfgt_toolbox.HFGTToolbox import (
    GIS2SysMLFile, runHFGTAnalysis, runHFGTStructuralAnalysis, loadMyData, importInputData, importSysMLFile,
    exportSysMLFile, debugEquivTextFiles, sortDictionaryKeys
)
from .utils import julia_test, compare_objects

# Keys that are not considered when comparing objects


@pytest.mark.output_ext(".sysml")
def test_gis_to_sysml(input_path, output_path, benchmark_path):
    """Test to ensure that GIS2Sysml works as expected.

    Args:
        input_path (str): Input filepath.
        output_path (str): Output filepath.
        class_name (str): Name of the class e.g. "Power Plant".
        index_column_name (str): Name of the identifying column e.g. "id".
    """
    # TODO - think of a way to make geoDataClassName and city dynamic
    # (perhaps read them from the file)
    GIS2SysMLFile(input_path, output_path, "geoDataClassName", "city")
    debugEquivTextFiles(output_path, benchmark_path)


def test_xml_structural_analysis_roundtrip(input_path, output_directory, julia_output_directory, benchmark_path):
    """ This test checks if we can run a default structural analysis,
    save the result to disk, and load it back again without change."""
    
    myLFES1 = runHFGTAnalysis(input_path,
                             outputDirectory = output_directory,
                             juliaOutputDirectory = julia_output_directory)
    myLFES2 = loadMyData(myLFES1.outputFilePath)

    # Ignore these keys as they are irrelevant to whether the output is
    # correct or not.
    # Without ignoring these keys, compare_objects will fail because the output paths
    # etc for myLFES1 are different from myLFES2.
    same_objects, err_message = compare_objects(myLFES1, myLFES2)
    if not same_objects:
        pytest.fail(f"Test failed ({err_message})")

@pytest.mark.output_ext(".sysml")
def test_sysml_round_trip_equivalence(input_path, output_path):
    """
        Round Trip Equivalance of Input SysML File to Output SysML File')
        This test checks if I load a SysML input file, then export it again, then two SysML text files are equivalent.

        input_path (str): The input path to import (SysML).
        output_path (str): The output path (SysML).        
    """
    mySysMLDict = importSysMLFile(input_path)
    exportSysMLFile(mySysMLDict, output_path)
    same_objects = debugEquivTextFiles(input_path, output_path)
    assert same_objects


def test_equivalence_xml_sysml_import(input_path_1, input_path_2):
    """ This test checks if I load one input file in SysML format and then load one
    input file in XML format, then they will produce equivalent data in memory.

    Args:
        input_path_1 (str): The first input path to import (SysML).
        input_path_2 (str): The first input path to import (XML).
    """

    myLFES1 = importInputData(input_path_1)
    myLFES2 = importInputData(input_path_2)
    
    myLFES2.inputFilePath = myLFES1.inputFilePath
    myLFES2.outputFilePath = myLFES1.outputFilePath
    myLFES2.inputDataFormat = myLFES1.inputDataFormat
    myLFES2.juliaOutputFilePath = myLFES1.juliaOutputFilePath
    myLFES2.view = None
    same_objects, err_message = compare_objects(myLFES1, myLFES2)
    if not same_objects:
        pytest.fail(f"Test failed ({err_message})")

@pytest.mark.output_ext(".sysml")
def test_sysml_round_trip_export(input_path, output_path):
    """
    This test checks if I import a SysML file into a dictionary, and I load the same SysML file into a myLFES object and
    then convert it into a dictionary, then the two dictionaries are equivalent.
    It then double-checks that if I export both of these dictionaries to a SysML file, then they are equivalent.

    Args:
        input_path(str): Path to the input SysML file.
        output_path (str): Path to the output SysML file.

    """
    mySysMLDict1 = importSysMLFile(input_path)
    myLFES = importInputData(input_path)
    mySysMLDict2 = myLFES.convertLFES2SysMLDict()
    my_result, _ = compare_objects(mySysMLDict1, mySysMLDict2)    
    assert my_result

    mySysMLDict1 = sortDictionaryKeys(mySysMLDict1,False)
    mySysMLDict2 = sortDictionaryKeys(mySysMLDict2,False)

    # Create another output path (same file name as the first, with a _2 at the end).
    output_path_2 = output_path.with_name(f"{output_path.stem}_2{output_path.suffix}")
    exportSysMLFile(mySysMLDict1, output_path)
    exportSysMLFile(mySysMLDict2, output_path_2)
    print(output_path_2)
    same_objects = debugEquivTextFiles(output_path, output_path_2)
    if not same_objects:
        pytest.fail(f"Test failed ({err_message})")

@pytest.mark.output_ext(".sysml")
def test_xml_to_sysml(input_path, output_path):
    """
    This test checks if I import an input XML file to create myLFES1, then convert it into a SysML-compliant dict, then
    write that to a SysML file, and then import the SysML file again to create myLFES2, then myLFES1==myLFES2.

    Args:
        input_path (str): Path to the input XML file.
        output_path (str): Path to the output SysML file.

    """
    myLFES1 = importInputData(input_path)
    tempLFES = copy.deepcopy(myLFES1)
    mySysMLDict = tempLFES.convertLFES2SysMLDict()
    exportSysMLFile(mySysMLDict, output_path)
    myLFES2 = importInputData(output_path)
    myLFES2.inputFilePath = myLFES1.inputFilePath
    myLFES2.outputFilePath = myLFES1.outputFilePath
    myLFES2.inputDataFormat = myLFES1.inputDataFormat
    myLFES2.juliaOutputFilePath = myLFES1.juliaOutputFilePath
    same_objects = compare_objects(myLFES1, myLFES2)
    if not same_objects:
        pytest.fail(f"Test failed ({err_message})")

def _test_hfgt_analysis(input_path, output_directory, julia_output_directory, benchmark_path):
    """Generic test_hfgt_analysis function. Called by the more specific hfgt analysis
    tests below.

    Args:
        input_path (str): Path to the input file.
        output_directory (_type_): Path of the Python output directory.
        julia_output_directory (_type_): Path of the Julia output directory.
        benchmark_path (_type_): Path of the benchmark file.
    """
    myLFES = runHFGTAnalysis(input_path,
                            outputDirectory = output_directory,
                            juliaOutputDirectory = julia_output_directory)
    benchmarkLFES = loadMyData(benchmark_path)    

    same_objects, err_message = compare_objects(benchmarkLFES, myLFES)
    if not same_objects:
        pytest.fail(f"Test failed ({err_message})")

def test_hfgt_analysis_default(input_path, output_directory, julia_output_directory, benchmark_path):
    _test_hfgt_analysis(input_path, output_directory, julia_output_directory, benchmark_path)

@julia_test()
def test_hfgt_analysis_hfnmcf(input_path, output_directory, julia_output_directory, benchmark_path):
    _test_hfgt_analysis(input_path, output_directory, julia_output_directory, benchmark_path)

def test_hfgt_analysis_sosresilience(input_path, output_directory, julia_output_directory, benchmark_path):
    _test_hfgt_analysis(input_path, output_directory, julia_output_directory, benchmark_path)

def test_hfgt_structural_analysis(input_path, output_directory, benchmark_path):
    """Test the HFGT Structural Analysis.

    Args:
        input_path (str): Path to the input file.
        output_directory (str): Path of the Python output directory.
        benchmark_path (str): Path of the benchmark file.
    """    
    myLFES = runHFGTStructuralAnalysis(input_path, outputDirectory = output_directory)
    benchmarkLFES = loadMyData(benchmark_path)
    same_objects, err_message = compare_objects(benchmarkLFES,myLFES)
    if not same_objects:
        pytest.fail(f"Test failed ({err_message})")