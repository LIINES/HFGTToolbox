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
		attribute simHorizon;
		attribute deltaT;
		attribute hasESN_Duration;
		attribute hasESN_STF1;
		attribute hasESN_STF2;
		attribute hasBufferUpperBound;
		attribute hasBufferLowerBound;
		attribute hasBufferCost;
		attribute hasBufferInitCond;
		attribute hasBufferFinalCond;
		attribute hasProcessUpperBound;
		attribute hasProcessLowerBound;
		attribute hasProcessInitCond;
		attribute hasProcessFinalCond;
		attribute hasProcessRamp;
		attribute hasProcessCost;
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
		attribute hasOperandNet_Duration;
		attribute hasOperandNet_STF1;
		attribute hasOperandNet_STF2;
		attribute hasPlaceUpperBound;
		attribute hasPlaceLowerBound;
		attribute hasPlaceFinalConds;
		attribute hasPlaceInitConds;
		attribute hasPlaceCost;
		attribute hasTransitionCapacityConds;
		attribute hasTransitionDurationConds;
		attribute hasTransitionFinalConds;
		attribute hasTransitionInitConds;
		attribute hasTransitionCost;
		attribute hasSyncMatNeg;
		attribute hasSyncMatPos;
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
		attribute upperBound;
		attribute lowerBound;
		attribute upperBoundRamp;
		attribute lowerBoundRamp;
		attribute linearCostCoeff;
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
		attribute upperBound;
		attribute lowerBound;
		attribute upperBoundRamp;
		attribute lowerBoundRamp;
		attribute linearCostCoeff;
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
		attribute inputDataFormat :> inputDataFormat = "defaultXML";
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
		item 'electricity' : Operand {
			attribute operandName :> operandName = "electricity";
			attribute operandNetName :> operandNetName = "deliver electricity";
			attribute status :> status = "true";
			attribute operandType :> operandType = "energy";
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
			attribute status :> status = "true";
			attribute operandType :> operandType = "matter";
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
			attribute status :> status = "true";
			attribute operandType :> operandType = "matter";
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