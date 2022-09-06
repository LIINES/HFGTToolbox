from .raw2FullLFES_Functions import *

def raw2FullLFES(LFES,verboseMode):
    '''
    This function processes the output of XML2LFES function and computes HFGT mathematical models.
    :param LFES: Instantiated LFES object with HFGT meta-elements already set-up
    :return: myLFES: Complete LFES, containing HFGT mathematical models
    '''
    print("I am entering raw2FullLFES.py")

    if verboseMode <= 2:
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
        if LFES.DOFH > 0:
            makeSetTransportProcess(LFES)

        # Make Set of Refined Transportation Processes
        if LFES.DOFH > 0:
            makeSetTransportRefProcess(LFES)
        else:
            LFES.numTransportRefProcess = len(LFES.abstract.methodsxPort.name)*(LFES.numBuffers**2)
            LFES.numHoldingProcess = len(np.unique(LFES.abstract.methodsxPort.ref))

        # Pack Set of Transformation Processes
        if LFES.DOFC > 0:
            packSetControlProcess(LFES)


        # Make Abstract Method Pair Process Index
        if LFES.abstract.methodPair.name1:
            calcMethodPairIdxProc(LFES)

        # Initialize Knowledge Bases and Constraint Matrices
        initializeKnowledgeBasesConstraintsMatrices(LFES)
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

        # Calculate Transportation Knowledge Base JH, Constraints Matrix KH, and Transformation Concept AH
        if LFES.DOFH > 0:
            calcJH_KH_AH(LFES)
            calcJHT_KHT_AHT(LFES)

        # Calculate Refined Transportation Knowledge Base JH, Constraints Matrix KH, and Transformation Concept AH
        if LFES.DOFH > 0:
            calcJHref_KHref_AHref(LFES)
            calcJHrefT_KHrefT_AHrefT(LFES)

        # Calculate Sequence Independent DOF Measures
        calcStrucDOF(LFES)

        # Calculate System Knowledge base JS, System Constraints Matrix KS, and System Concept AS
        calcJS_KS_AS(LFES)

        # Initialize Control Structure within myLFES
        initializeControl(LFES)

        if LFES.numControllers > 0:
            # Calculate Cyber Physical Resource Agency Matrix
            makeCPRAM(LFES)
            # Calculate Cyber Physical Process Agregation Matrix
            makeCPPAM(LFES)
            # Calculate Cyber Physical JS
            calcControllerJS(LFES)
            # Calculate Controller Adjacency Matrix
            makeCADM(LFES)

        # Calculate Service Nets
        if LFES.numServices > 0:
            # makeServiceGraph(LFES)  # was commented out
            makeServiceNet(LFES)

        # Calculate Service Feasibility Matrix
        if LFES.numServices > 0:
            makeServiceFeasibility(LFES)  # Was commented out

        # Calculate Incidence Tensors
        # if verboseMode == 0 or verboseMode == 2:
        calcMLP(LFES)
        calcMRT(LFES)

        # Calculate Hetero-functional Adjacency Matrix AR
        if verboseMode == 0:
            calcARBasic(LFES)
        elif verboseMode == 1:
            calcARPar(LFES)
        elif verboseMode == 2:
            calcARInc(LFES)

        # Combine DOFS & HFAM with CAM & CADM
        if LFES.numControllers > 0:
            if verboseMode == 0:
                combineHFAMandCADM(LFES)

    else:
        # populate only the necesary indices
        methodsToInc(LFES)

        # CalcAR
        print('Entering calcAR')
        calc_t = time.time()
        calcARIncJulia(LFES)
        end_t = time.time()
        print('total time taken calcAR: %f' % (end_t - calc_t))


    # Mark the LFES Data as Fully Calculated
    LFES.dataState = 'full'
    print("I am exiting raw2FullLFES.py")
    return LFES


