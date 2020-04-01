function myLFES = raw2FullLFES(myLFES)
%%  Copyright 2018 Engineering Systems Analytics LLC
%
% This function converts an "raw" data LFES into a "full" LFES.
% Proposed Usage:  myLFES=raw2FullLFES(myLFES)
disp(['I am entering ' 'raw2FullLFES.m'])
%% Calculate Resource Indices
myLFES=calcResourceIndices(myLFES);

%% Calc Resource Counts
myLFES=calcResourceCounts(myLFES);

%% Calc Resource set 
myLFES=calcResourceSet(myLFES);

%% Pack Set of Transformation Processes
if myLFES.DOFM>0
    myLFES=packSetTransformProcess(myLFES);
end

%% Make Set of Transportation Processes
if myLFES.DOFH>0
   myLFES=makeSetTransportProcess(myLFES);
end

%% Make Set of Refined Transportation Processes
if myLFES.DOFH>0
   myLFES=makeSetTransportRefProcess(myLFES);
end
%% Initialize Knowledge Bases and Constraint Matrices
myLFES = initializeKnowledgeBasesConstraintsMatrices(myLFES);

%% Calculate Transformation Knowledge Base JM, Constraints Matrix KM, and Transformation Concept AM
if myLFES.DOFM>0
    myLFES = calcJM_KM_AM(myLFES);
end

%% Calc Indices 
if myLFES.numMachines > 0
    myLFES = calcMachineIdxPort(myLFES);
end
if myLFES.numIndBuffers > 0
    myLFES = calcIndBufferIdxPort(myLFES);
end
if myLFES.numTransporters > 0
    myLFES = calcTransporterIdxPort(myLFES);
end

%% Calculate Transportation Knowledge Base JH, Constraints Matrix KH, and Transformation Concept AH
if myLFES.DOFH>0
    myLFES = calcJH_KH_AH(myLFES);
end

%% Calculate RefinedTransportation Knowledge Base JH, Constraints Matrix KH, and Transformation Concept AH
if myLFES.DOFH>0
    myLFES = calcJHref_KHref_AHref(myLFES);
end

% Calculate Sequence Independent DOF Measures -- Already Calculated!
myLFES = calcStrucDOF(myLFES);

% Calculate System Knowledge base JS, System Constraints Matrix KS, and System Concept AS
myLFES = calcJS_KS_AS(myLFES);

%% Calculate Heterofunctional Adjacency Matrix AR
myLFES = calcAR(myLFES);


%% Initialize Control Structure within myLFES
myLFES = initializeControl(myLFES);

%% Calculate Controller Agency Matrix
if myLFES.numControllers > 0
    myLFES=makeCAM(myLFES);
end


%% Calculate Controller Adjacency Matrix
if myLFES.numControllers > 0
    myLFES=makeCADM(myLFES);
end

%% Combine DOFS & HFAM with CAM & CADM
if myLFES.numControllers > 0
   myLFES=combineHFAMandCADM(myLFES);
end

%% Calculate Service Graph
if myLFES.numServices > 0
    myLFES=makeServiceGraph(myLFES);
end

%% Calculate Service Feasibility Matrix
if myLFES.numServices > 0
   myLFES=makeServiceFeasibility(myLFES);
end

%% Combine SAM with Services
if myLFES.numServices > 0 && myLFES.numControllers > 0
   myLFES=combineHFAMCADMService(myLFES);
end

%% Mark the LFES Data as Fully Calculated
myLFES.dataState='full';
disp(['I am leaving  ' 'raw2FullLFES.m']);