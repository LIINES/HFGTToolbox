"""
Copyright (c) 2018-2023 Laboratory for Intelligent Integrated Networks of Engineering Systems
@author: Dakota J. Thompson, Wester C. H. Shoonenberg, Amro M. Farid
@lab: Laboratory for Intelligent Integrated Networks of Engineering Systems
@Modified: 09/29/2023
"""

from .raw2FullLFES_Functions import *

def raw2FullLFES(LFES,verboseMode):
    '''
    This function processes the output of XML2LFES function and computes HFGT mathematical models.
    :param LFES: Instantiated LFES object with HFGT meta-elements already set-up
    :return: myLFES: Complete LFES, containing HFGT mathematical models
    '''
    print("I am entering raw2FullLFES.py")

    if verboseMode <= 2:
        # Calculate Resource Count Updates: numMachines, numIndBuffers, numBuffers,
        #   numTransporters, numResources, numControllers, numServices
        calcResourceCounts(LFES)
        # Calculate Resource Indices Updates: machines, indBuffers, transporters
        calcResourceIndices(LFES)
        # Calculate Resource Set Updates: resources
        calcResourceSet(LFES)
        # Pack Set of Transformation Processes Updates: setTransformProcess, numTransformProcess
        if LFES.DOFM > 0:
            packSetTransformProcess(LFES)
        # Make Set of Transportation Processes Updates: setTransportProcess, numTransportProcess
        if LFES.DOFH > 0:
            makeSetTransportProcess(LFES)
        # Make Set of Refined Transportation Processes Updates: setTransportRefProcess,
        #   setHoldingProcess, numTransportRefProcess, numHoldingProcess
        if LFES.DOFH > 0:
            makeSetTransportRefProcess(LFES)
        else:
            LFES.numTransportRefProcess = len(LFES.abstract.methodsxPort.name)*(LFES.numBuffers**2)
            LFES.numHoldingProcess = len(np.unique(LFES.abstract.methodsxPort.ref))
        # Pack Set of Transformation Processes Updates: setControlProcess, numControlProcess
        if LFES.DOFC > 0:
            packSetControlProcess(LFES)
        # Make Abstract Method Pair Process Index Updates: abstract
        if LFES.abstract.methodPair.name1:
            calcMethodPairIdxProc(LFES)
        # Initialize Knowledge Bases and Constraint Matrices Updates: JM, JH, JHref,
        #   KM, KH, KHref, AM, AH, AHref
        initializeKnowledgeBasesConstraintsMatrices(LFES)
        # Initialize Knowledge Bases and Constraint Tensores Updates: JHT, JHrefT,
        #   KHT, KHrefT, AHT, AHrefT
        initializeKnowledgeBasesConstraintsTensors(LFES)
        # Calculate Transformation Knowledge Base updates: JM, KM, AM
        if LFES.DOFM > 0:
            calcJM_KM_AM(LFES)
        # Calc Machine Process Indices Updates: machines.methodsxForm, machines.methodsxPort
        if LFES.numMachines > 0:
            calcMachineIdxForm(LFES)
            calcMachineIdxPort(LFES)
        # Calc Independent Buffer Process Indices Updates: indBuffers.methodsxPort
        if LFES.numIndBuffers > 0:
            calcIndBufferIdxPort(LFES)
        # Calc Transporter Process Indices Updates: transporters.methodsxPort
        if LFES.numTransporters > 0:
            calcTransporterIdxPort(LFES)
        # Calculate Transportation Knowledge Base Updates: JH, KH, AH
        # Calculate Transportation Knowledge Base Tensors Updates: JHT, KHT, AHT
        if LFES.DOFH > 0:
            calcJH_KH_AH(LFES)
            calcJHT_KHT_AHT(LFES)
        # Calculate Refined Transportation Knowledge Base Updates: JHT, KHT, AHT
        # Calculate Refined Transportation Knowledge Base Tensors Updates: JHrefT, KHrefT, AHrefT
        if LFES.DOFH > 0:
            calcJHref_KHref_AHref(LFES)
            calcJHrefT_KHrefT_AHrefT(LFES)
        # Calculate Sequence Independent DOF Measures Updates: DOFM, DOFH, DOFHref
        calcStrucDOF(LFES)
        # Calculate System Knowledge base JS,  KS, AS, DOFS, numProcesses
        calcJS_KS_AS(LFES)
        # Initialize Control Structures Updates: CAM, CADM, SAMproj, CPRAM, CPPAM
        initializeControl(LFES)
        # Updates Cyber matrices
        if LFES.numControllers > 0:
            # Calculate Cyber Physical Resource Agency Matrix Updates: CPRAM, CAM
            makeCPRAM(LFES,verboseMode)
            # # Calculate Cyber Physical Process Agregation Matrix Updates: CPPAM
            # makeCPPAM(LFES)
            # # Calculate Cyber Physical JS  to Update: AS
            # calcControllerJS(LFES)
            # Calculate Controller Adjacency Matrix Updates: CADM
            makeCADM(LFES)
        # Calculate Service Nets Updates: services
        if LFES.numServices > 0:
            makeServiceNet(LFES)
        # Calculate Service Feasibility Matrix Updates: services, Lambda, xFormLambda, xPortLambda
        if LFES.numServices > 0:
            makeServiceFeasibility(LFES)
        # Calculate Incidence Tensors Updates: MLP_neg, MLP_pos, MLg_neg, MLg_pos
        calcMLP(LFES)
        # Calculate Incidence Tensors Updates: MRT_neg, MRTproj_neg, MRT_neg4,
        #   MRT_pos, MRTproj_pos, MRT_pos4, MRTproj, MRT
        calcMRT(LFES)
        # Calculate Hetero-functional Adjacency Matrix AR
        # Basic Version Updates: idxAR, idxARproj, ARproj, AR, DOFR, DOFR1, DOFR2, DOFR3, DOFR4, DOFR5
        if verboseMode == 0:
            calcARBasic(LFES)
        # Parallel Version Updates: DOFR, idxAR, idxARproj
        elif verboseMode == 1:
            calcARPar(LFES)
        # Incidence Matrix Version Updates: AR, idxAR, ARproj, idxARproj
        elif verboseMode == 2:
            calcARInc(LFES)
        # Combine DOFS & HFAM with CAM & CADM Updates: SAMproj
        if LFES.numControllers > 0:
            if verboseMode == 0:
                combineHFAMandCADM(LFES)

    else:
        # populate only the necessary indices Updates:
        #   DOFS, numTransformProcess, numTransportProcess, numHoldingProcesses,
        #   numTransportRefProcess, numProcesses, numResources, MRT_neg, MRT_pos, AS
        methodsToInc(LFES)

        # Updates Cyber matrices
        if LFES.numControllers > 0:
            initializeControl(LFES)
            # Calculate Cyber Physical Resource Agency Matrix Updates: CPRAM, CAM
            makeCPRAM(LFES, verboseMode)
            # # Calculate Cyber Physical Process Agregation Matrix Updates: CPPAM
            # makeCPPAM(LFES)
            # Calculate Controller Adjacency Matrix Updates: CADM
            makeCADM(LFES)

        # CalcARIncJulia Updates: MR_neg, MR_pos, idxAR
        print('Entering calcAR')
        calc_t = time.time()
        calcARIncJulia(LFES)
        end_t = time.time()
        print('total time taken calcAR: %f' % (end_t - calc_t))

    # Mark the LFES Data as Fully Calculated
    LFES.dataState = 'full'
    print("I am exiting raw2FullLFES.py")
    return LFES


