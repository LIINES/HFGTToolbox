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
		attribute hasTransitionCost;
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
	part 'ExampleNetworkNoOperandNetsHFNMCF' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "true";
		attribute hasBufferInitCond :> hasBufferInitCond = "true";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "true";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "true";
		attribute hasESNEnablingConstraint :> hasESNEnablingConstraint = "false";
		attribute hasESN_Duration :> hasESN_Duration = "true";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "true";
		attribute hasProcessDuration :> hasProcessDuration = "true";
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
		attribute name :> name = "ExampleNetworkNoOperandNetsHFNMCF";
		attribute optimizer :> optimizer = "Gurobi";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Smart City";
		attribute scenario :> scenario = "base";
		attribute simHorizon :> simHorizon = "2";
		attribute verboseMode :> verboseMode = "true";
		part 'Water Treatment Facility' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Water Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "real,real,real";
			attribute initCond :> initCond = "0,0,0";
			attribute finalCond :> finalCond = "0,0,0";
			attribute upperBound :> upperBound = "1,1,1";
			attribute linearCostCoeff :> linearCostCoeff = "0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Water Treatment Facility";
			action 'treat water' : TransformProcess {
				attribute name :> name = "treat water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "potable water";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
			}
		}
		part 'Solar PV' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Electric Power Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real,real,real";
			attribute initCond :> initCond = "0,0,0";
			attribute finalCond :> finalCond = "0,0,0";
			attribute upperBound :> upperBound = "1,1,1";
			attribute linearCostCoeff :> linearCostCoeff = "0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Solar PV";
			action 'generate electric power' : TransformProcess {
				attribute name :> name = "generate electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
			}
		}
		part 'House' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "End User";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "real,real,real";
			attribute initCond :> initCond = "0,0,0";
			attribute finalCond :> finalCond = "0,0,0";
			attribute upperBound :> upperBound = "1,1,1";
			attribute linearCostCoeff :> linearCostCoeff = "0,0,0";
			attribute transformationResourceName :> transformationResourceName = "House";
			action 'consume water' : TransformProcess {
				attribute name :> name = "consume water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,potable water";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1,1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute duration :> duration = "0";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
			}
			action 'store EV' : TransportProcess {
				attribute name :> name = "store EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "House";
				attribute destination :> destination = "House";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "park EV";
			}
			action 'store EV' : TransportProcess {
				attribute name :> name = "store EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV,electricity";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1,1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "House";
				attribute destination :> destination = "House";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "charge EV";
			}
		}
		part 'Work Location' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "End User";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real,real,real";
			attribute initCond :> initCond = "0,0,0";
			attribute finalCond :> finalCond = "0,0,0";
			attribute upperBound :> upperBound = "1,1,1";
			attribute linearCostCoeff :> linearCostCoeff = "0,0,0";
			attribute independentBufferName :> independentBufferName = "Work Location";
			action 'store EV' : TransportProcess {
				attribute name :> name = "store EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "Work Location";
				attribute destination :> destination = "Work Location";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "park EV";
			}
		}
		part 'Water Pipeline' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Water Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Water Pipeline";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "Water Treatment Facility";
				attribute destination :> destination = "House";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Power Line 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Electric Power Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 1";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "Solar PV";
				attribute destination :> destination = "Water Treatment Facility";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "hold 132kV";
			}
		}
		part 'Power Line 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Electric Power Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 2";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "Solar PV";
				attribute destination :> destination = "House";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "hold 132kV";
			}
		}
		part 'Road' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "End User";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road";
			action 'transport EV' : TransportProcess {
				attribute name :> name = "transport EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "Work Location";
				attribute destination :> destination = "House";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport EV' : TransportProcess {
				attribute name :> name = "transport EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute varDomain :> varDomain = "real";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "House";
				attribute destination :> destination = "Work Location";
				attribute processCapacity :> processCapacity = "1";
				attribute processCost :> processCost = "1";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part 'Water Utility' : DecisionMaker {
			attribute name :> name = "Water Utility";
			attribute status :> status = "true";
			attribute peerRecipient :> peerRecipient = "Water Utility,Electric Power Utility,End User";
		}
		part 'Electric Power Utility' : DecisionMaker {
			attribute name :> name = "Electric Power Utility";
			attribute status :> status = "true";
			attribute peerRecipient :> peerRecipient = "Electric Power Utility,Water Utility,End User";
		}
		part 'End User' : DecisionMaker {
			attribute name :> name = "End User";
			attribute status :> status = "true";
			attribute peerRecipient :> peerRecipient = "End User,Water Utility,Electric Power Utility";
		}
		item 'electricity' : Operand {
			attribute operandName :> operandName = "electricity";
			attribute operandNetName :> operandNetName = "deliver electricity";
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
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "true";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "true";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "true";
			attribute hasTransitionCost :> hasTransitionCost = "true";
		}
		item 'potable water' : Operand {
			attribute operandName :> operandName = "potable water";
			attribute operandNetName :> operandNetName = "deliver potable water";
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
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "true";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "true";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "true";
			attribute hasTransitionCost :> hasTransitionCost = "true";
		}
		item 'EV' : Operand {
			attribute operandName :> operandName = "EV";
			attribute operandNetName :> operandNetName = "deliver EV";
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
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "true";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "true";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "true";
			attribute hasTransitionCost :> hasTransitionCost = "true";
		}
	}
}