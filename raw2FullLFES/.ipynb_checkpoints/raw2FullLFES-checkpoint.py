import os.path
from os import path
from HFGT_tensors import *
from .raw2FullLFES_Functions import *

global verboseMode
verboseMode = 2

def raw2FullLFES(LFES):
    '''
    This function processes the output of XML2LFES function and computes HFGT mathematical models.
    :param LFES: Instantiated LFES object with HFGT meta-elements already set-up
    :return: myLFES: Complete LFES, containing HFGT mathematical models
    '''
    print("I am entering raw2FullLFES.py")
    # Calculate Resource Counts
    calcResourceCounts(LFES)
    
    # Calculate Resource Indices
    calcResourceIndices(LFES)
    
    # Calculate Resource Set
    calcResourceSet(LFES)
    
    # Pack Set of Transformation Processes
    if LFES.DOFM > 0:
        packSetTransformProcess(LFES)
        
    # Make Set of Transportation Processes
    if verboseMode >= 2:
        if LFES.DOFH > 0:
            makeSetTransportProcess(LFES)
    else:
        LFES.numTransportProcess = LFES.numBuffers**2
        
    # Make Set of Refined Transportation Processes
    if verboseMode >= 2:
        if LFES.DOFH > 0:
            makeSetTransportRefProcess(LFES)
    else:
        LFES.numTransportRefProcess = len(LFES.abstract.methodsxPort.name)*(LFES.numBuffers**2)
        LFES.numHoldingProcess = len(np.unique(LFES.abstract.methodsxPort.ref))
        
    # Pack Set of Transformation Processes    
    if LFES.DOFC > 0:
        packSetControlProcess(LFES)
        
    # Make Abstract Method Pair Process Index    
    if verboseMode < 2:
        if LFES.abstract.methodPair.name1:
            calcMethodPairIdxProc(LFES)

    # Initialize Knowledge Bases and Constraint Matrices
    initializeKnowledgeBasesConstraintsMatrices(LFES)
    if path.isfile('HFGT_tensors.py'):
        initializeKnowledgeBasesConstraintsTensors(LFES)
    
    # Calculate Transformation Knowledge Base JM, Constraints Matrix KM, and Transformation Concept AM
    if LFES.DOFM > 0:
        calcJM_KM_AM(LFES)
        
    # Calc Indices
    if LFES.numMachines > 0:
        calcMachineIdxForm(LFES)
        calcMachineIdxPort(LFES)
    if LFES.numIndBuffers > 0:
        calcIndBufferIdxPort(LFES)
    if LFES.numTransporters > 0:
        calcTransporterIdxPort(LFES)
        
    if verboseMode < 2:
        delattr(LFES, 'resources')
    
    # Calculate Transportation Knowledge Base JH, Constraints Matrix KH, and Transformation Concept AH
    if LFES.DOFH > 0:
        calcJH_KH_AH(LFES)
        if path.isfile('HFGT_tensors.py'):
            calcJHT_KHT_AHT(LFES)
            
    # Calculate Refined Transportation Knowledge Base JH, Constraints Matrix KH, and Transformation Concept AH
    if LFES.DOFH > 0:
        calcJHref_KHref_AHref(LFES)
        if path.isfile('HFGT_tensors.py'):
            calcJHrefT_KHrefT_AHrefT(LFES)
    
    # Calculate Sequence Independent DOF Measures
    calcStrucDOF(LFES)
    
    # Calculate System Knowledge base JS, System Constraints Matrix KS, and System Concept AS
    calcJS_KS_AS(LFES)
    
    # Initialize Control Structure within myLFES
    initializeControl(LFES)
    
    if LFES.numControllers > 0:
        if verboseMode >= 2:
            # Calculate Cyber Physical Resource Agency Matrix
            makeCPRAM(LFES)
            # Calculate Cyber Physical Process Agregation Matrix
            makeCPPAM(LFES)
            # Calculate Cyber Physical JS
            calcControllerJS(LFES)
            # Calculate Controller Adjacency Matrix
            makeCADM(LFES)
#             makeCAM(LFES) # obsolete because CAM is calculated in makeCPRAM
    
    # Calculate Service Nets
    if LFES.numServices > 0:
        if verboseMode >= 2:
#             makeServiceGraph(LFES)
            makeServiceNet(LFES)
    
    # Calculate Service Feasibility Matrix
    if LFES.numServices > 0:
        if verboseMode >= 2:
            makeServiceFeasibility(LFES)
    
    # Calculate Incidence Tensors
    if verboseMode >= 2:
        if path.isfile('HFGT_tensors.py'):
            calcMLP(LFES)
            calcMRT(LFES)
    
    # Calculate Heterofunctional Adjacency Matrix AR
    if verboseMode < 2:
        calcARPar(LFES)
    elif verboseMode == 2:
        calcARBasic(LFES)
    elif verboseMode == 3:
        calcARInc(LFES)
        
    # Combine DOFS & HFAM with CAM & CADM
    if LFES.numControllers > 0:
        if verboseMode >= 2:
            combineHFAMandCADM(LFES)
    
    # Combine SAM with Services
    if LFES.numServices > 0 and LFES.numControllers > 0:
        if verboseMode == 2:
            combineHFAMCADMService(LFES)
    
    # Mark the LFES Data as Fully Calculated
    LFES.dataState = 'full'
    print("I am exiting raw2FullLFES.py")
    return LFES
