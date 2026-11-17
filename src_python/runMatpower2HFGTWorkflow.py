"""
Copyright (c) 2018-2026 Engineering Systems Analytics LLC, Stevens Institute of Technology
@author: Papa Kwesi Aggrey, Ehsan Ghorbani, Amro M. Farid
@version: 4.6.9
@Note:  Version 4.0 is a major release constituting a full rewrite of the entire code base.
@Note:  See Bitbucket Commit History for an understanding the contributions of each author.
@Acknowledgement:  Thanks goes to Dr. Amro M. Farid, Dr. Wester C. H. Schoonenberg, and Dr. Dakota Thompson as the principal
                    authors of Versions 1, 2, 3 respectively.
@Modified: 04/02/2026
@ Provided under the Creative Commons 4.0 License
Developed with Python 3.11.9
"""

import pathlib as pl
import hfgt_toolbox.HFGTToolbox as hfgt
import hfgt_toolbox.matpower2HFGT as mpHFGT

if __name__ == '__main__':
    # Define Input and Output File Paths
    epsSysMLStemFilePath = pl.Path("1_Cleaned_Raw_Data/SysMLs/epsDCOPF-STEM-Sysml-Base-2026-04-11.sysml")
    epsGenCSVFilePath = pl.Path("1_Cleaned_Raw_Data/CSVs/genCase9.csv")
    epsBusCSVFilePath = pl.Path("1_Cleaned_Raw_Data/CSVs/busCase9.csv")
    epsBranchFilePath = pl.Path("1_Cleaned_Raw_Data/CSVs/branchCase9.csv")
    outputFilePath = pl.Path("2_PyHFGTInput_Data/SysMLs/epsDCOPFCase9-Sysml-2026-03-30.sysml")

    # Run The MatPower2HFGT Workflow
    epsSysMLV2Dict = mpHFGT.runMatpower2HFGT(epsSysMLStemFilePath,epsGenCSVFilePath,epsBusCSVFilePath,epsBranchFilePath)
    # Export the SysML-Compliant Electric Power System Data
    hfgt.exportSysMLFile(epsSysMLV2Dict, outputFilePath)
    # Run HFGT Analysis
    hfgt.runHFGTAnalysis(outputFilePath)