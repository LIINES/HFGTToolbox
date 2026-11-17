package Model {
	part def LFES {
		attribute requiredKeys;
		attribute analysisMethod;
		attribute dataState;
		attribute inputDataFormat;
		attribute name;
		attribute outputFileType;
		attribute refArchitecture;
		attribute scenario;
		attribute verboseMode;
		attribute optimizer;
		attribute deltaT;
		attribute simHorizon;
		attribute hasESN_STF1;
		attribute hasESN_STF2;
		attribute hasESNEnablingConstraint;
		attribute hasESN_Duration;
		attribute hasBufferLinearCost;
		attribute hasBufferQuadCost;
		attribute hasBufferUpperBound;
		attribute hasBufferLowerBound;
		attribute hasBufferInitCond;
		attribute hasBufferFinalCond;
		attribute hasProcessLinearCostFlowNeg;
		attribute hasProcessLinearCostFlowPos;
		attribute hasProcessLinearCostStock;
		attribute hasProcessQuadCostFlowNeg;
		attribute hasProcessQuadCostFlowPos;
		attribute hasProcessQuadCostStock;
		attribute hasProcessUpperBoundFlowNeg;
		attribute hasProcessUpperBoundFlowPos;
		attribute hasProcessUpperBoundStock;
		attribute hasProcessLowerBoundFlowNeg;
		attribute hasProcessLowerBoundFlowPos;
		attribute hasProcessLowerBoundStock;
		attribute hasProcessInitCond;
		attribute hasProcessFinalCond;
		attribute hasProcessUpperBoundRamp;
		attribute hasProcessLowerBoundRamp;
		attribute hasProcessDuration;
		attribute hasProcessValues;
		attribute subAnalysisMethod;
		attribute number;
		attribute runCode;
		attribute view;
		attribute analytics;
		attribute buffer;
		attribute decisionMaker;
		attribute engSysNet;
		attribute holdingProcess;
		attribute independentBuffer;
		attribute inputFilePath;
		attribute operand;
		attribute outputDirectory;
		attribute juliaOutputFilePath;
		attribute outputFilePath;
		attribute physicalResource;
		attribute sosService;
		attribute systemConcept;
		attribute systemProcess;
		attribute timeKeeper;
		attribute transformProcess;
		attribute transformationResource;
		attribute transportProcess;
		attribute transportationResource;
		attribute validator;
	}
	part def TransformationResource {
		attribute requiredKeys;
		attribute idx;
		attribute name;
		attribute number;
		attribute status;
		attribute validator;
		attribute decisionMaker;
		attribute autonomous;
		attribute idxResource;
		attribute gpsX;
		attribute gpsY;
		attribute varDomain;
		attribute varDomainEnabled;
		attribute initCond;
		attribute finalCond;
		attribute upperBound;
		attribute lowerBound;
		attribute linearCostCoeff;
		attribute quadCostCoeff;
		attribute idxBuffer;
		attribute transformationResourceName;
		attribute transformProcess;
		attribute transportProcess;
	}
	part def IndependentBuffer {
		attribute requiredKeys;
		attribute idx;
		attribute name;
		attribute number;
		attribute status;
		attribute validator;
		attribute decisionMaker;
		attribute autonomous;
		attribute idxResource;
		attribute gpsX;
		attribute gpsY;
		attribute varDomain;
		attribute varDomainEnabled;
		attribute initCond;
		attribute finalCond;
		attribute upperBound;
		attribute lowerBound;
		attribute linearCostCoeff;
		attribute quadCostCoeff;
		attribute idxBuffer;
		attribute independentBufferName;
		attribute transportProcess;
	}
	part def TransportationResource {
		attribute requiredKeys;
		attribute idx;
		attribute name;
		attribute number;
		attribute status;
		attribute validator;
		attribute decisionMaker;
		attribute autonomous;
		attribute idxResource;
		attribute transportationResourceName;
		attribute transportProcess;
	}
	item def Operand {
		attribute requiredKeys;
		attribute operandName;
		attribute operandNetName;
		attribute operandType;
		attribute status;
		attribute hasOperandNet_STF1;
		attribute hasOperandNet_STF2;
		attribute hasOperandNet_Duration;
		attribute hasOperandNetEnablingConstraint;
		attribute hasSyncMatNeg;
		attribute hasSyncMatPos;
		attribute hasPlaceLinearCost;
		attribute hasPlaceQuadCost;
		attribute hasPlaceUpperBound;
		attribute hasPlaceLowerBound;
		attribute hasPlaceInitConds;
		attribute hasPlaceFinalConds;
		attribute hasTransitionLinearCostFlowNeg;
		attribute hasTransitionLinearCostFlowPos;
		attribute hasTransitionLinearCostStock;
		attribute hasTransitionQuadCostFlowNeg;
		attribute hasTransitionQuadCostFlowPos;
		attribute hasTransitionQuadCostStock;
		attribute hasTransitionUpperBoundFlowNeg;
		attribute hasTransitionUpperBoundFlowPos;
		attribute hasTransitionUpperBoundStock;
		attribute hasTransitionLowerBoundFlowNeg;
		attribute hasTransitionLowerBoundFlowPos;
		attribute hasTransitionLowerBoundStock;
		attribute hasTransitionDurationConds;
		attribute hasTransitionFinalConds;
		attribute hasTransitionInitConds;
		attribute sosType;
		attribute MFull;
		attribute Mneg;
		attribute Mpos;
		attribute UFull;
		attribute Uneg;
		attribute Upos;
		attribute XS;
		attribute XE;
		attribute XF;
		attribute pnPlaces;
		attribute pnTransitions;
		attribute idx;
		attribute number;
		attribute AL;
		attribute ALrho;
		attribute Adual;
		attribute Aprime;
		attribute Lambda;
		attribute LambdaHolding;
		attribute LambdaTransform;
		attribute LambdaTransport;
		attribute syncMat;
		attribute validator;
	}
	action def TransformProcess {
		attribute requiredKeys;
		attribute name;
		attribute status;
		attribute inputOperand;
		attribute outputOperand;
		attribute varDomain;
		attribute inputOperandWeight;
		attribute outputOperandWeight;
		attribute upperBoundFlowNeg;
		attribute upperBoundFlowPos;
		attribute upperBoundStock;
		attribute lowerBoundFlowNeg;
		attribute lowerBoundFlowPos;
		attribute lowerBoundStock;
		attribute upperBoundRamp;
		attribute lowerBoundRamp;
		attribute linearCostCoeffFlowNeg;
		attribute linearCostCoeffFlowPos;
		attribute linearCostCoeffStock;
		attribute quadCostCoeffFlowNeg;
		attribute quadCostCoeffFlowPos;
		attribute quadCostCoeffStock;
		attribute duration;
		attribute initCond;
		attribute finalCond;
		attribute value;
		attribute idx;
		attribute idxProcess;
		attribute idxInputOperand;
		attribute idxOutputOperand;
		attribute number;
		attribute numberMax;
		attribute validator;
	}
	action def TransportProcess {
		attribute requiredKeys;
		attribute name;
		attribute status;
		attribute inputOperand;
		attribute outputOperand;
		attribute varDomain;
		attribute inputOperandWeight;
		attribute outputOperandWeight;
		attribute upperBoundFlowNeg;
		attribute upperBoundFlowPos;
		attribute upperBoundStock;
		attribute lowerBoundFlowNeg;
		attribute lowerBoundFlowPos;
		attribute lowerBoundStock;
		attribute upperBoundRamp;
		attribute lowerBoundRamp;
		attribute linearCostCoeffFlowNeg;
		attribute linearCostCoeffFlowPos;
		attribute linearCostCoeffStock;
		attribute quadCostCoeffFlowNeg;
		attribute quadCostCoeffFlowPos;
		attribute quadCostCoeffStock;
		attribute duration;
		attribute initCond;
		attribute finalCond;
		attribute value;
		attribute idx;
		attribute idxProcess;
		attribute idxInputOperand;
		attribute idxOutputOperand;
		attribute number;
		attribute numberMax;
		attribute validator;
		attribute origin;
		attribute destination;
		attribute ref;
		attribute nameRef;
		attribute idxOrigin;
		attribute idxDestination;
		attribute idxHolding;
		attribute idxTransport;
		attribute numberRefMax;
	}
	part 'RCPSP1' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "false";
		attribute hasBufferInitCond :> hasBufferInitCond = "false";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "false";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "false";
		attribute hasESNEnablingConstraint :> hasESNEnablingConstraint = "false";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasESN_STF1 :> hasESN_STF1 = "false";
		attribute hasESN_STF2 :> hasESN_STF2 = "false";
		attribute hasProcessDuration :> hasProcessDuration = "false";
		attribute hasProcessFinalCond :> hasProcessFinalCond = "false";
		attribute hasProcessInitCond :> hasProcessInitCond = "false";
		attribute hasProcessLinearCostFlowNeg :> hasProcessLinearCostFlowNeg = "false";
		attribute hasProcessLinearCostFlowPos :> hasProcessLinearCostFlowPos = "false";
		attribute hasProcessLinearCostStock :> hasProcessLinearCostStock = "false";
		attribute hasProcessLowerBoundFlowNeg :> hasProcessLowerBoundFlowNeg = "false";
		attribute hasProcessLowerBoundFlowPos :> hasProcessLowerBoundFlowPos = "false";
		attribute hasProcessLowerBoundRamp :> hasProcessLowerBoundRamp = "false";
		attribute hasProcessLowerBoundStock :> hasProcessLowerBoundStock = "false";
		attribute hasProcessQuadCostFlowNeg :> hasProcessQuadCostFlowNeg = "false";
		attribute hasProcessQuadCostFlowPos :> hasProcessQuadCostFlowPos = "false";
		attribute hasProcessQuadCostStock :> hasProcessQuadCostStock = "false";
		attribute hasProcessUpperBoundFlowNeg :> hasProcessUpperBoundFlowNeg = "false";
		attribute hasProcessUpperBoundFlowPos :> hasProcessUpperBoundFlowPos = "false";
		attribute hasProcessUpperBoundRamp :> hasProcessUpperBoundRamp = "false";
		attribute hasProcessUpperBoundStock :> hasProcessUpperBoundStock = "false";
		attribute hasProcessValues :> hasProcessValues = "false";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "RCPSP1";
		attribute optimizer :> optimizer = "gurobi";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Smart City";
		attribute scenario :> scenario = "renewable-resources-esn";
		attribute simHorizon :> simHorizon = "23";
		attribute verboseMode :> verboseMode = "false";
		part 'Jack' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "End User";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "integer+";
			attribute linearCostCoeff :> linearCostCoeff = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Jack";
			action 'Perform Activity A' : TransformProcess {
				attribute name :> name = "Perform Activity A";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity B' : TransformProcess {
				attribute name :> name = "Perform Activity B";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity C' : TransformProcess {
				attribute name :> name = "Perform Activity C";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity D' : TransformProcess {
				attribute name :> name = "Perform Activity D";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity E' : TransformProcess {
				attribute name :> name = "Perform Activity E";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity F' : TransformProcess {
				attribute name :> name = "Perform Activity F";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity G' : TransformProcess {
				attribute name :> name = "Perform Activity G";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Perform Activity H' : TransformProcess {
				attribute name :> name = "Perform Activity H";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
			action 'Finish Project' : TransformProcess {
				attribute name :> name = "Finish Project";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "project";
				attribute outputOperand :> outputOperand = "project";
				attribute varDomain :> varDomain = "binary";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute initCond :> initCond = "";
				attribute finalCond :> finalCond = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
			}
		}
		item 'project' : Operand {
			attribute operandName :> operandName = "project";
			attribute operandNetName :> operandNetName = "deliver project";
			attribute operandType :> operandType = "information";
			attribute status :> status = "true";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "true";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "true";
			attribute hasOperandNetEnablingConstraint :> hasOperandNetEnablingConstraint = "false";
			attribute hasSyncMatNeg :> hasSyncMatNeg = "false";
			attribute hasSyncMatPos :> hasSyncMatPos = "false";
			attribute hasPlaceLinearCost :> hasPlaceLinearCost = "false";
			attribute hasPlaceQuadCost :> hasPlaceQuadCost = "false";
			attribute hasPlaceUpperBound :> hasPlaceUpperBound = "true";
			attribute hasPlaceLowerBound :> hasPlaceLowerBound = "false";
			attribute hasPlaceInitConds :> hasPlaceInitConds = "true";
			attribute hasPlaceFinalConds :> hasPlaceFinalConds = "true";
			attribute hasTransitionLinearCostFlowNeg :> hasTransitionLinearCostFlowNeg = "true";
			attribute hasTransitionLinearCostFlowPos :> hasTransitionLinearCostFlowPos = "false";
			attribute hasTransitionLinearCostStock :> hasTransitionLinearCostStock = "false";
			attribute hasTransitionQuadCostFlowNeg :> hasTransitionQuadCostFlowNeg = "false";
			attribute hasTransitionQuadCostFlowPos :> hasTransitionQuadCostFlowPos = "false";
			attribute hasTransitionQuadCostStock :> hasTransitionQuadCostStock = "false";
			attribute hasTransitionUpperBoundFlowNeg :> hasTransitionUpperBoundFlowNeg = "false";
			attribute hasTransitionUpperBoundFlowPos :> hasTransitionUpperBoundFlowPos = "false";
			attribute hasTransitionUpperBoundStock :> hasTransitionUpperBoundStock = "false";
			attribute hasTransitionLowerBoundFlowNeg :> hasTransitionLowerBoundFlowNeg = "false";
			attribute hasTransitionLowerBoundFlowPos :> hasTransitionLowerBoundFlowPos = "false";
			attribute hasTransitionLowerBoundStock :> hasTransitionLowerBoundStock = "false";
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "true";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "false";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "false";
			part 'Project Start' : OperandPlace {
				attribute name :> name = "Project Start";
				attribute initCond :> initCond = "3";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Required Operands Stock' : OperandPlace {
				attribute name :> name = "Required Operands Stock";
				attribute initCond :> initCond = "8";
				attribute finalCond :> finalCond = "8";
				attribute upperBound :> upperBound = "8";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity A Finished' : OperandPlace {
				attribute name :> name = "Activity A Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity D Finished' : OperandPlace {
				attribute name :> name = "Activity D Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity B Finished' : OperandPlace {
				attribute name :> name = "Activity B Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity C Finished' : OperandPlace {
				attribute name :> name = "Activity C Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity G Finished' : OperandPlace {
				attribute name :> name = "Activity G Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity E Finished' : OperandPlace {
				attribute name :> name = "Activity E Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity F Finished' : OperandPlace {
				attribute name :> name = "Activity F Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Activity H Finished' : OperandPlace {
				attribute name :> name = "Activity H Finished";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute varDomain :> varDomain = "integer+";
				attribute placeType :> placeType = "internal";
			}
			part 'Perform Activity A' : OperandTransition {
				attribute duration :> duration = "2";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity A";
				attribute preset :> preset = "Project Start,Required Operands Stock";
				attribute postset :> postset = "Required Operands Stock,Activity A Finished";
				attribute presetWeight :> presetWeight = "1,2";
				attribute postsetWeight :> postsetWeight = "2,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity B' : OperandTransition {
				attribute duration :> duration = "7";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity B";
				attribute preset :> preset = "Project Start,Required Operands Stock";
				attribute postset :> postset = "Required Operands Stock,Activity B Finished";
				attribute presetWeight :> presetWeight = "1,3";
				attribute postsetWeight :> postsetWeight = "3,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity C' : OperandTransition {
				attribute duration :> duration = "3";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity C";
				attribute preset :> preset = "Required Operands Stock,Activity A Finished";
				attribute postset :> postset = "Required Operands Stock,Activity C Finished";
				attribute presetWeight :> presetWeight = "4,1";
				attribute postsetWeight :> postsetWeight = "4,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity D' : OperandTransition {
				attribute duration :> duration = "4";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity D";
				attribute preset :> preset = "Project Start,Required Operands Stock";
				attribute postset :> postset = "Required Operands Stock,Activity D Finished";
				attribute presetWeight :> presetWeight = "1,4";
				attribute postsetWeight :> postsetWeight = "4,2";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity E' : OperandTransition {
				attribute duration :> duration = "8";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity E";
				attribute preset :> preset = "Required Operands Stock,Activity C Finished";
				attribute postset :> postset = "Required Operands Stock,Activity E Finished";
				attribute presetWeight :> presetWeight = "3,1";
				attribute postsetWeight :> postsetWeight = "3,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity F' : OperandTransition {
				attribute duration :> duration = "6";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity F";
				attribute preset :> preset = "Required Operands Stock,Activity D Finished";
				attribute postset :> postset = "Required Operands Stock,Activity F Finished";
				attribute presetWeight :> presetWeight = "2,1";
				attribute postsetWeight :> postsetWeight = "2,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity G' : OperandTransition {
				attribute duration :> duration = "4";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity G";
				attribute preset :> preset = "Required Operands Stock,Activity D Finished,Activity B Finished";
				attribute postset :> postset = "Required Operands Stock,Activity G Finished";
				attribute presetWeight :> presetWeight = "3,1,1";
				attribute postsetWeight :> postsetWeight = "3,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Perform Activity H' : OperandTransition {
				attribute duration :> duration = "2";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Perform Activity H";
				attribute preset :> preset = "Required Operands Stock,Activity G Finished";
				attribute postset :> postset = "Required Operands Stock,Activity H Finished";
				attribute presetWeight :> presetWeight = "4,1";
				attribute postsetWeight :> postsetWeight = "4,1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'Finish Project' : OperandTransition {
				attribute duration :> duration = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22";
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "Finish Project";
				attribute preset :> preset = "Activity E Finished,Activity F Finished,Activity H Finished";
				attribute postset :> postset = "";
				attribute presetWeight :> presetWeight = "1,1,1";
				attribute postsetWeight :> postsetWeight = "";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
	}
}