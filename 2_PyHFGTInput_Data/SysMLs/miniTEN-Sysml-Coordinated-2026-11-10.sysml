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
		attribute FinalCondition;
		attribute InitialCondition;
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
	part 'miniTEN' : LFES {
		attribute analysisMethod :> analysisMethod = "default";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "false";
		attribute hasBufferInitCond :> hasBufferInitCond = "false";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "false";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "false";
		attribute hasESNEnablingConstraint :> hasESNEnablingConstraint = "false";
		attribute hasESN_Duration :> hasESN_Duration = "true";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "true";
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
		attribute name :> name = "miniTEN";
		attribute optimizer :> optimizer = "Gurobi";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Transportation-Electricity-Nexus";
		attribute scenario :> scenario = "coordinated";
		attribute simHorizon :> simHorizon = "100";
		attribute verboseMode :> verboseMode = "true";
		part '1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "1";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "1";
				attribute destination :> destination = "1";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "1";
				attribute destination :> destination = "1";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "2";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "2";
				attribute destination :> destination = "2";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "2";
				attribute destination :> destination = "2";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '3' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "3";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "3";
				attribute destination :> destination = "3";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "3";
				attribute destination :> destination = "3";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '4' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "4";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "4";
				attribute destination :> destination = "4";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "4";
				attribute destination :> destination = "4";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '5' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "5";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "5";
				attribute destination :> destination = "5";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "5";
				attribute destination :> destination = "5";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '6' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "6";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "6";
				attribute destination :> destination = "6";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "6";
				attribute destination :> destination = "6";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '7' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "7";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "7";
				attribute destination :> destination = "7";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "7";
				attribute destination :> destination = "7";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '8' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "8";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "8";
				attribute destination :> destination = "8";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "8";
				attribute destination :> destination = "8";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '9' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "9";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "9";
				attribute destination :> destination = "9";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "9";
				attribute destination :> destination = "9";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '10' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "10";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "10";
				attribute destination :> destination = "10";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "10";
				attribute destination :> destination = "10";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '11' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "11";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "11";
				attribute destination :> destination = "11";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "11";
				attribute destination :> destination = "11";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '12' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "12";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "12";
				attribute destination :> destination = "12";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "12";
				attribute destination :> destination = "12";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '13' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "13";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "13";
				attribute destination :> destination = "13";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "13";
				attribute destination :> destination = "13";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '14' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "14";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "14";
				attribute destination :> destination = "14";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "14";
				attribute destination :> destination = "14";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '15' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "15";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "15";
				attribute destination :> destination = "15";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "15";
				attribute destination :> destination = "15";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '16' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "16";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "16";
				attribute destination :> destination = "16";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "50";
				attribute duration :> duration = "0";
				attribute origin :> origin = "16";
				attribute destination :> destination = "16";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV home";
			}
		}
		part '21' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "21";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "21";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "park EV";
			}
			action 'store' : TransportProcess {
				attribute name :> name = "store";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10";
				attribute duration :> duration = "0";
				attribute origin :> origin = "21";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wire charge EV work";
			}
		}
		part '17' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "17";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '18' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "18";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '19' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "19";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '20' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "20";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '22' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "22";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '23' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "23";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '24' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "24";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '25' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "25";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'G' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "-1";
			attribute transformationResourceName :> transformationResourceName = "G";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'cheap generate electricity' : TransformProcess {
				attribute name :> name = "cheap generate electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "160";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "6";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
			action 'exp generate electricity' : TransformProcess {
				attribute name :> name = "exp generate electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "160";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "S1";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "S2";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S3' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "S3";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S4' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "S4";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S5' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "S5";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S6' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "S6";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S7' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "S7";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S8' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "S8";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S9' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "S9";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S10' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "S10";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S11' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "S11";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S12' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "S12";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S13' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "S13";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S14' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "S14";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S15' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "S15";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S16' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "S16";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'S21' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "S21";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'solar generator' : TransformProcess {
				attribute name :> name = "solar generator";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "10";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "L1";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "L2";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L3' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "L3";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L4' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "L4";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L5' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "L5";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L6' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "L6";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L7' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "L7";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L8' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "L8";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L9' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "L9";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L10' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "L10";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L11' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "L11";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L12' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "L12";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L13' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "L13";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L14' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "L14";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L15' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "L15";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L16' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "L16";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L21' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "L21";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L17' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "L17";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L18' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "L18";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L19' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "L19";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L20' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "L20";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L22' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "L22";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L23' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "L23";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L24' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "L24";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part 'L25' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "L25";
			attribute FinalCondition :> FinalCondition = "0,0";
			attribute InitialCondition :> InitialCondition = "0,0";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute duration :> duration = "0";
				attribute processingCost :> processingCost = "20";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
			}
		}
		part '1-2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "1-2";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "1";
				attribute destination :> destination = "2";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "2";
				attribute destination :> destination = "1";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '2-3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "2-3";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "2";
				attribute destination :> destination = "3";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "3";
				attribute destination :> destination = "2";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '3-4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "3-4";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "3";
				attribute destination :> destination = "4";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "4";
				attribute destination :> destination = "3";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '4-5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "4-5";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "4";
				attribute destination :> destination = "5";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "5";
				attribute destination :> destination = "4";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '6-17' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "6-17";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "6";
				attribute destination :> destination = "17";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "17";
				attribute destination :> destination = "6";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '17-18' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "17-18";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "17";
				attribute destination :> destination = "18";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "18";
				attribute destination :> destination = "17";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '18-19' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "18-19";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "18";
				attribute destination :> destination = "19";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "19";
				attribute destination :> destination = "18";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '19-7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "19-7";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "19";
				attribute destination :> destination = "7";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "7";
				attribute destination :> destination = "19";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '8-20' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "8-20";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "8";
				attribute destination :> destination = "20";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "20";
				attribute destination :> destination = "8";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part 'Wireless20-21' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wireless20-21";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "20";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "20";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "20";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "20";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
		}
		part 'Wireless21-22' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wireless21-22";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "22";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "22";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "22";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "22";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
		}
		part '22-9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "22-9";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "22";
				attribute destination :> destination = "9";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "9";
				attribute destination :> destination = "22";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '10-23' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "10-23";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "10";
				attribute destination :> destination = "23";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "23";
				attribute destination :> destination = "10";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '23-24' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "23-24";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "23";
				attribute destination :> destination = "24";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "24";
				attribute destination :> destination = "23";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '24-25' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "24-25";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "24";
				attribute destination :> destination = "25";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "25";
				attribute destination :> destination = "24";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '25-11' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "25-11";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "25";
				attribute destination :> destination = "11";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "11";
				attribute destination :> destination = "25";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '12-13' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "12-13";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "12";
				attribute destination :> destination = "13";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "13";
				attribute destination :> destination = "12";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '13-14' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "13-14";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "13";
				attribute destination :> destination = "14";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "14";
				attribute destination :> destination = "13";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '14-15' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "14-15";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "14";
				attribute destination :> destination = "15";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "15";
				attribute destination :> destination = "14";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '15-16' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "15-16";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "15";
				attribute destination :> destination = "16";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "16";
				attribute destination :> destination = "15";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '1-6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "1-6";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "1";
				attribute destination :> destination = "6";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "6";
				attribute destination :> destination = "1";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '6-8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "6-8";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "6";
				attribute destination :> destination = "8";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "8";
				attribute destination :> destination = "6";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '8-10' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "8-10";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "8";
				attribute destination :> destination = "10";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "10";
				attribute destination :> destination = "8";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '10-12' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "10-12";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "10";
				attribute destination :> destination = "12";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "12";
				attribute destination :> destination = "10";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '2-17' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "2-17";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "2";
				attribute destination :> destination = "17";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "17";
				attribute destination :> destination = "2";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '17-20' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "17-20";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "17";
				attribute destination :> destination = "20";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "20";
				attribute destination :> destination = "17";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '20-23' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "20-23";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "20";
				attribute destination :> destination = "23";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "23";
				attribute destination :> destination = "20";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '23-13' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "23-13";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "23";
				attribute destination :> destination = "13";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "13";
				attribute destination :> destination = "23";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '3-18' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "3-18";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "3";
				attribute destination :> destination = "18";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "18";
				attribute destination :> destination = "3";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part 'Wireless18-21' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wireless18-21";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "18";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "18";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "18";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "18";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
		}
		part 'Wireless21-24' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wireless21-24";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "24";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "24";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "21";
				attribute destination :> destination = "24";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electric current";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "4";
				attribute duration :> duration = "1";
				attribute origin :> origin = "24";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "wireless charge EV";
			}
		}
		part '24-14' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "24-14";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "24";
				attribute destination :> destination = "14";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "14";
				attribute destination :> destination = "24";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '4-19' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "4-19";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "4";
				attribute destination :> destination = "19";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "19";
				attribute destination :> destination = "4";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '19-22' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "19-22";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "19";
				attribute destination :> destination = "22";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "22";
				attribute destination :> destination = "19";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '22-25' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "22-25";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "22";
				attribute destination :> destination = "25";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "25";
				attribute destination :> destination = "22";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '25-15' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "25-15";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "25";
				attribute destination :> destination = "15";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "15";
				attribute destination :> destination = "25";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '5-7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "5-7";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "5";
				attribute destination :> destination = "7";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "7";
				attribute destination :> destination = "5";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '7-9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "7-9";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "7";
				attribute destination :> destination = "9";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "9";
				attribute destination :> destination = "7";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '9-11' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "9-11";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "9";
				attribute destination :> destination = "11";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "11";
				attribute destination :> destination = "9";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part '11-16' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "11-16";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "11";
				attribute destination :> destination = "16";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3";
				attribute duration :> duration = "1";
				attribute origin :> origin = "16";
				attribute destination :> destination = "11";
				attribute processingCost :> processingCost = "1";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part 'G-3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "G-3";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "G";
				attribute destination :> destination = "3";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W3-2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W3-2";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "3";
				attribute destination :> destination = "2";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W3-4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W3-4";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "3";
				attribute destination :> destination = "4";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W3-17' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W3-17";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "3";
				attribute destination :> destination = "17";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W3-18' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W3-18";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "3";
				attribute destination :> destination = "18";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W2-1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W2-1";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "2";
				attribute destination :> destination = "1";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W4-5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W4-5";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "4";
				attribute destination :> destination = "5";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W4-19' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W4-19";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "4";
				attribute destination :> destination = "19";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W17-20' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W17-20";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "17";
				attribute destination :> destination = "20";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W18-21' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W18-21";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "18";
				attribute destination :> destination = "21";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W1-6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W1-6";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "1";
				attribute destination :> destination = "6";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W5-7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W5-7";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "5";
				attribute destination :> destination = "7";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W19-22' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W19-22";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "19";
				attribute destination :> destination = "22";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W20-23' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W20-23";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "20";
				attribute destination :> destination = "23";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W6-8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W6-8";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "6";
				attribute destination :> destination = "8";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W7-9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W7-9";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "7";
				attribute destination :> destination = "9";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W22-25' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W22-25";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "22";
				attribute destination :> destination = "25";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W23-13' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W23-13";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "23";
				attribute destination :> destination = "13";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W23-24' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W23-24";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "23";
				attribute destination :> destination = "24";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W8-10' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W8-10";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "8";
				attribute destination :> destination = "10";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W9-11' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W9-11";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "9";
				attribute destination :> destination = "11";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W24-14' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W24-14";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "24";
				attribute destination :> destination = "14";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W25-15' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W25-15";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "25";
				attribute destination :> destination = "15";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W10-12' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W10-12";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "10";
				attribute destination :> destination = "12";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		part 'W15-16' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "miniTEN";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "W15-16";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric current";
				attribute outputOperand :> outputOperand = "electric current";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "20000";
				attribute duration :> duration = "0";
				attribute origin :> origin = "15";
				attribute destination :> destination = "16";
				attribute processingCost :> processingCost = "0";
				attribute fixCost :> fixCost = "0";
				attribute lowerCapacity :> lowerCapacity = "0";
				attribute processingCostQ :> processingCostQ = "0";
				attribute refinement :> refinement = "electricity";
			}
		}
		item 'electric current' : Operand {
			attribute operandName :> operandName = "electric current";
			attribute operandNetName :> operandNetName = "deliver electric current";
			attribute operandType :> operandType = "energy";
			attribute status :> status = "true";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "false";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "false";
			attribute hasOperandNetEnablingConstraint :> hasOperandNetEnablingConstraint = "false";
			attribute hasSyncMatNeg :> hasSyncMatNeg = "false";
			attribute hasSyncMatPos :> hasSyncMatPos = "false";
			attribute hasPlaceLinearCost :> hasPlaceLinearCost = "false";
			attribute hasPlaceQuadCost :> hasPlaceQuadCost = "false";
			attribute hasPlaceUpperBound :> hasPlaceUpperBound = "false";
			attribute hasPlaceLowerBound :> hasPlaceLowerBound = "false";
			attribute hasPlaceInitConds :> hasPlaceInitConds = "false";
			attribute hasPlaceFinalConds :> hasPlaceFinalConds = "false";
			attribute hasTransitionLinearCostFlowNeg :> hasTransitionLinearCostFlowNeg = "false";
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
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "false";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "false";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "false";
		}
		item 'EV' : Operand {
			attribute operandName :> operandName = "EV";
			attribute operandNetName :> operandNetName = "manage EV state";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "false";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "false";
			attribute hasOperandNetEnablingConstraint :> hasOperandNetEnablingConstraint = "false";
			attribute hasSyncMatNeg :> hasSyncMatNeg = "false";
			attribute hasSyncMatPos :> hasSyncMatPos = "false";
			attribute hasPlaceLinearCost :> hasPlaceLinearCost = "false";
			attribute hasPlaceQuadCost :> hasPlaceQuadCost = "false";
			attribute hasPlaceUpperBound :> hasPlaceUpperBound = "false";
			attribute hasPlaceLowerBound :> hasPlaceLowerBound = "false";
			attribute hasPlaceInitConds :> hasPlaceInitConds = "false";
			attribute hasPlaceFinalConds :> hasPlaceFinalConds = "false";
			attribute hasTransitionLinearCostFlowNeg :> hasTransitionLinearCostFlowNeg = "false";
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
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "false";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "false";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "false";
		}
	}
}