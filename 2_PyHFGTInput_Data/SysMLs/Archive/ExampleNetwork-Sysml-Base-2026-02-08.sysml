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
		attribute hasESN_Duration;
		attribute hasESN_STF1;
		attribute hasESN_STF2;
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
		attribute MLPNeg;
		attribute MLPPos;
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
		attribute MLPNeg;
		attribute MLPPos;
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
	part 'ExampleNetwork' : LFES {
		attribute analysisMethod :> analysisMethod = "default";
		attribute dataState :> dataState = "raw";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "ExampleNetwork";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Smart City";
		attribute scenario :> scenario = "base";
		attribute verboseMode :> verboseMode = "true";
		part 'Water Treatment Facility' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Water Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Water Treatment Facility";
			action 'treat water' : TransformProcess {
				attribute name :> name = "treat water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "potable water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
		}
		part 'Solar PV' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Electric Power Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "Solar PV";
			action 'generate electric power' : TransformProcess {
				attribute name :> name = "generate electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electricity";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
		}
		part 'House' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "End User";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "House";
			action 'consume water' : TransformProcess {
				attribute name :> name = "consume water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,potable water";
				attribute outputOperand :> outputOperand = "";
				attribute inputOperandWeight :> inputOperandWeight = "1,1";
				attribute outputOperandWeight :> outputOperandWeight = "";
			}
			action 'store EV' : TransportProcess {
				attribute name :> name = "store EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "House";
				attribute destination :> destination = "House";
				attribute refinement :> refinement = "park EV";
			}
			action 'store EV' : TransportProcess {
				attribute name :> name = "store EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV, electricity";
				attribute outputOperand :> outputOperand = "EV";
				attribute inputOperandWeight :> inputOperandWeight = "1,1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "House";
				attribute destination :> destination = "House";
				attribute refinement :> refinement = "charge EV";
			}
		}
		part 'Work Location' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "End User";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute independentBufferName :> independentBufferName = "Work Location";
			action 'store EV' : TransportProcess {
				attribute name :> name = "store EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Work Location";
				attribute destination :> destination = "Work Location";
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
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Water Treatment Facility";
				attribute destination :> destination = "House";
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
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Solar PV";
				attribute destination :> destination = "Water Treatment Facility";
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
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Solar PV";
				attribute destination :> destination = "House";
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
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Work Location";
				attribute destination :> destination = "House";
				attribute refinement :> refinement = "discharge EV";
			}
			action 'transport EV' : TransportProcess {
				attribute name :> name = "transport EV";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "EV";
				attribute outputOperand :> outputOperand = "EV";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "House";
				attribute destination :> destination = "Work Location";
				attribute refinement :> refinement = "discharge EV";
			}
		}
		part 'Water Utility' : DecisionMaker {
			attribute name :> name = "Water Utility";
			attribute peerRecipient :> peerRecipient = "Water Utility, Electric Power Utility,End User";
		}
		part 'Electric Power Utility' : DecisionMaker {
			attribute name :> name = "Electric Power Utility";
			attribute peerRecipient :> peerRecipient = "Electric Power Utility, Water Utility, End User";
		}
		part 'End User' : DecisionMaker {
			attribute name :> name = "End User";
			attribute peerRecipient :> peerRecipient = "End User, Water Utility,Electric Power Utility";
		}
		item 'electricity' : Operand {
			attribute operandName :> operandName = "electricity";
			attribute operandNetName :> operandNetName = "deliver electricity";
			attribute operandType :> operandType = "energy";
			attribute status :> status = "true";
			part 'electric power' : OperandPlace {
				attribute name :> name = "electric power";
				attribute placeType :> placeType = "internal";
			}
			part 'generate electric power' : OperandTransition {
				attribute name :> name = "generate electric power";
				attribute preset :> preset = "";
				attribute postset :> postset = "electric power";
				attribute processLinkName :> processLinkName = "generate electric power";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'continuing electric power' : OperandTransition {
				attribute name :> name = "continuing electric power";
				attribute preset :> preset = "electric power";
				attribute postset :> postset = "electric power";
				attribute processLinkName :> processLinkName = "transport electricity";
				attribute processLinkRef :> processLinkRef = "hold 132kV";
			}
			part 'treat water' : OperandTransition {
				attribute name :> name = "treat water";
				attribute preset :> preset = "electric power";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "treat water";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume water' : OperandTransition {
				attribute name :> name = "consume water";
				attribute preset :> preset = "electric power";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "consume water";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'charge EV' : OperandTransition {
				attribute name :> name = "charge EV";
				attribute preset :> preset = "electric power";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "store EV";
				attribute processLinkRef :> processLinkRef = "charge EV";
			}
		}
		item 'potable water' : Operand {
			attribute operandName :> operandName = "potable water";
			attribute operandNetName :> operandNetName = "deliver potable Water";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'potable water' : OperandPlace {
				attribute name :> name = "potable water";
				attribute placeType :> placeType = "internal";
			}
			part 'treat water' : OperandTransition {
				attribute name :> name = "treat water";
				attribute preset :> preset = "";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "treat water";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'continuing water' : OperandTransition {
				attribute name :> name = "continuing water";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "transport potable water";
				attribute processLinkRef :> processLinkRef = "hold potable water";
			}
			part 'consume water' : OperandTransition {
				attribute name :> name = "consume water";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "consume water";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'EV' : Operand {
			attribute operandName :> operandName = "EV";
			attribute operandNetName :> operandNetName = "deliver EV";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'state of charge' : OperandPlace {
				attribute name :> name = "state of charge";
				attribute placeType :> placeType = "internal";
			}
			part 'charge battery' : OperandTransition {
				attribute name :> name = "charge battery";
				attribute preset :> preset = "";
				attribute postset :> postset = "state of charge";
				attribute processLinkName :> processLinkName = "store EV";
				attribute processLinkRef :> processLinkRef = "charge EV";
			}
			part 'continuing battery' : OperandTransition {
				attribute name :> name = "continuing battery";
				attribute preset :> preset = "state of charge";
				attribute postset :> postset = "state of charge";
				attribute processLinkName :> processLinkName = "store EV";
				attribute processLinkRef :> processLinkRef = "park EV";
			}
			part 'discharge battery' : OperandTransition {
				attribute name :> name = "discharge battery";
				attribute preset :> preset = "state of charge";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "transport EV";
				attribute processLinkRef :> processLinkRef = "discharge EV";
			}
		}
	}
}