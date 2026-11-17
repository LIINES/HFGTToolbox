# Copyright (c) 2022-2025 Engineering Systems Analytics LLC
# @author: Amro M. Farid
# @version: 4.6.0
# @Modified: 12/24/2025

using Pkg
Pkg.activate("HFNMCFTools")
using HFNMCFTools          # The leading `.` refers to a local module
using PrettyPrint

############ Load Input Data #################
# You will need to run the HFGT Toolbox first.   For example...
# python src_python/runHFGTStructuralToolbox.py 2_PyHFGTInput_Data/XMLs/miniTEN-Defaultxml-Coordinated-2026-01-05.xml
 

############ Load Input Data #################
# WARNING!  If you are using VSCode, make sure to open the folder with the entire HFGT Toolbox and not just Julia folder.  
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-miniTEN-Coordinated-defaultXML-2026-01-05.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-ExampleNetworkNoOperandNetsHFNMCF-Base-defaultXML-2025-12-20.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-TransportationNetwork-Base-defaultXML-2026-01-05.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-RCPSP1-Defaultxml-Renewable-Resources-2026-01-24.json"
inputFilePath = "3_PyHFGT_Output_Data/myLFES-RCPSP1-Defaultxml-Renewable-Resources-Esn-2026-01-24.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-ElectricPowerSystem-Dynamiceconomicdispatch-defaultXML-2025-12-20.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-ElectricPowerSystem-Staticeconomicdispatch-defaultXML-2025-12-20.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-NEAC-freight-Base-defaultXML-2026-01-19.json"

println("Loading HFNMCF optimization with input file: $inputFilePath")
myLFES = HFNMCFTools.loadHFNMCFData(inputFilePath)
# println("Optimization complete. Results saved to: ", myLFES.juliaOutputFilePath)

# Now explore the myLFES data structure for data that was originally in the XML file.  For example:
myLFES.engSysNet.Mneg
myLFES.engSysNet.pnTransitions.upperBoundFlowNeg