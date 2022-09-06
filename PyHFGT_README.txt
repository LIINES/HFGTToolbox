The HFGT toolbox repository contains the following directories:
1) XML2LFES
	The XML2LFES repository has the following subfolders:
	a) XML2LFES_classes
		Sets up the LFES class structure
	b) XML2LFES_functions
		Functions that help read the XML file and convert it to the LFES class structure.
2)raw2FullLFES
	The raw2Full repository has the following subfolders:
	a) raw2FullLFES_functions
		Functions that perform the HFGT analysis.

The PyHFGTToolbox_Analysis.inpyb file shows how to use the toolbox. Additionally, the toolbox repository contains three sample input XML files:
I) Trimetrica-3layer-Data-v9.xml - V9 of the XML file needed for the HFGT analysis.
II) saadat_6bus_centralized_hfgt.xml - Steffi's XML file for the cyber-physical work.
III) Example_Network.xml - The example network from Chapter 4 of the HFGT book.

For parallelized computation of AR, set verboseMode = 1 in the raw2FullLFES.py file.

The HFGT_Tensors.inpyb notebook computes the HFGT tensors. For it to function, please ensure that you have the sparse library found under LIINES-common/3-SoftwareTools/4-Python/sparse in your root Anaconda installation.

NOTE : In contrast to the MATLAB toolbox where functions return values, the assignment of values to parameters in the LFES class structure happens within the functions.

Also NOTE : This version of the toolbox is work in progress. 
********************************************************************************
JS is likely to be incorrect (Incorporates cyber resources and processes). Latest edits to Steffi's work need to be complete.
********************************************************************************
The service feasibility matrices might still be incorrect as in the book. Need to upgrade to V-10 trimetrica to test and might need to change the usage of the map function in the service matrices to regex.
********************************************************************************
Latest default method to calculate the Heterofunctional Adjacency Matrix in the MATLAB toolbox is using the tensor formulation. This still needs to be updated. This would be much faster than the parallelized version of calcareous as well.
********************************************************************************
