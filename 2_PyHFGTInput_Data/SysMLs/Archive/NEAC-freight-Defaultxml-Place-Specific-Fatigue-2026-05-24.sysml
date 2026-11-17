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
		attribute hasPlaceCost;
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
	part 'NEAC-freight' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "true";
		attribute hasBufferInitCond :> hasBufferInitCond = "true";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "true";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "false";
		attribute hasESNEnablingConstraint :> hasESNEnablingConstraint = "true";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
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
		attribute name :> name = "NEAC-freight";
		attribute optimizer :> optimizer = "Gurobi";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "NEAC Freight";
		attribute scenario :> scenario = "Place-Specific-Fatigue";
		attribute simHorizon :> simHorizon = "41";
		attribute subAnalysisMethod :> subAnalysisMethod = "FreightFatigue";
		attribute verboseMode :> verboseMode = "true";
		part 'Charging Station 1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "1";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 1";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 2";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 3' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 3";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 4' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 4";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 5' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 5";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 6' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 6";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 7' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 7";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 8' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 8";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 9' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 9";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Charging Station 10' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 10";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
				attribute varDomainEnabled :> varDomainEnabled = "real+";
			}
		}
		part 'Charging Station 11' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "binary";
			attribute varDomainEnabled :> varDomainEnabled = "real+";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "1";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute transformationResourceName :> transformationResourceName = "Charging Station 11";
			action 'charge ev-driver' : TransformProcess {
				attribute name :> name = "charge ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "binary";
				attribute duration :> duration = "";
			}
		}
		part 'Road Segment 1-2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 1-2";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 1";
				attribute destination :> destination = "Charging Station 2";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 2-3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 2-3";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 2";
				attribute destination :> destination = "Charging Station 3";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 3-4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 3-4";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 3";
				attribute destination :> destination = "Charging Station 4";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 4-5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 4-5";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 4";
				attribute destination :> destination = "Charging Station 5";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 5-6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 5-6";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 5";
				attribute destination :> destination = "Charging Station 6";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 6-7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 6-7";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 6";
				attribute destination :> destination = "Charging Station 7";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 7-8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 7-8";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 7";
				attribute destination :> destination = "Charging Station 8";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 8-9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 8-9";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 8";
				attribute destination :> destination = "Charging Station 9";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 9-10' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 9-10";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 9";
				attribute destination :> destination = "Charging Station 10";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		part 'Road Segment 10-11' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Road Segment 10-11";
			action 'transport ev-driver' : TransportProcess {
				attribute name :> name = "transport ev-driver";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "ev-driver";
				attribute outputOperand :> outputOperand = "ev-driver";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute duration :> duration = "";
				attribute origin :> origin = "Charging Station 10";
				attribute destination :> destination = "Charging Station 11";
				attribute refinement :> refinement = "hold ev-driver";
			}
		}
		item 'ev-driver' : Operand {
			attribute operandName :> operandName = "ev-driver";
			attribute operandNetName :> operandNetName = "ev-driver";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "true";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "false";
			attribute hasOperandNetEnablingConstraint :> hasOperandNetEnablingConstraint = "true";
			attribute hasSyncMatNeg :> hasSyncMatNeg = "true";
			attribute hasSyncMatPos :> hasSyncMatPos = "false";
			attribute hasPlaceLinearCost :> hasPlaceLinearCost = "true";
			attribute hasPlaceQuadCost :> hasPlaceQuadCost = "false";
			attribute hasPlaceUpperBound :> hasPlaceUpperBound = "true";
			attribute hasPlaceLowerBound :> hasPlaceLowerBound = "false";
			attribute hasPlaceInitConds :> hasPlaceInitConds = "true";
			attribute hasPlaceFinalConds :> hasPlaceFinalConds = "true";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
			part 'state-of-charge' : OperandPlace {
				attribute name :> name = "state-of-charge";
				attribute initCond :> initCond = "10";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
				attribute varDomain :> varDomain = "real+";
				attribute placeType :> placeType = "internal";
			}
			part 'allowed-to-drive' : OperandPlace {
				attribute name :> name = "allowed-to-drive";
				attribute initCond :> initCond = "1";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
				attribute varDomain :> varDomain = "binary";
				attribute placeType :> placeType = "internal";
			}
			part 'driver-energy-level' : OperandPlace {
				attribute name :> name = "driver-energy-level";
				attribute initCond :> initCond = "11";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "11";
				attribute linearCostCoeff :> linearCostCoeff = "0";
				attribute varDomain :> varDomain = "real+";
				attribute placeType :> placeType = "internal";
			}
			part 'allowed-to-rest' : OperandPlace {
				attribute name :> name = "allowed-to-rest";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "";
				attribute linearCostCoeff :> linearCostCoeff = "0";
				attribute varDomain :> varDomain = "binary";
				attribute placeType :> placeType = "internal";
			}
			part 'driver-breaktime-level' : OperandPlace {
				attribute name :> name = "driver-breaktime-level";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "0";
				attribute upperBound :> upperBound = "11";
				attribute linearCostCoeff :> linearCostCoeff = "0";
				attribute varDomain :> varDomain = "real+";
				attribute placeType :> placeType = "internal";
			}
			part 'signed-out' : OperandPlace {
				attribute name :> name = "signed-out";
				attribute initCond :> initCond = "0";
				attribute finalCond :> finalCond = "1";
				attribute upperBound :> upperBound = "";
				attribute linearCostCoeff :> linearCostCoeff = "-1";
				attribute varDomain :> varDomain = "real+";
				attribute placeType :> placeType = "internal";
			}
			part 'charge state-of-charge' : OperandTransition {
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "charge state-of-charge";
				attribute preset :> preset = "allowed-to-rest,driver-breaktime-level";
				attribute postset :> postset = "state-of-charge,allowed-to-rest";
				attribute presetWeight :> presetWeight = "1,1";
				attribute postsetWeight :> postsetWeight = "1,1";
				attribute processLinkName :> processLinkName = "charge ev-driver";
				attribute processLinkRef :> processLinkRef = "";
				attribute processLinkWeight :> processLinkWeight = "1";
			}
			part 'park' : OperandTransition {
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "park";
				attribute preset :> preset = "allowed-to-rest,driver-breaktime-level";
				attribute postset :> postset = "allowed-to-rest";
				attribute presetWeight :> presetWeight = "1,1";
				attribute postsetWeight :> postsetWeight = "1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'discharge state-of-charge' : OperandTransition {
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "discharge state-of-charge";
				attribute preset :> preset = "state-of-charge,allowed-to-drive,driver-energy-lev...";
				attribute postset :> postset = "allowed-to-drive";
				attribute presetWeight :> presetWeight = "1,1,1";
				attribute postsetWeight :> postsetWeight = "1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "hold ev-driver";
				attribute processLinkRefWeight :> processLinkRefWeight = "1";
			}
			part 'begin rest period' : OperandTransition {
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "begin rest period";
				attribute preset :> preset = "allowed-to-drive,driver-energy-level";
				attribute postset :> postset = "allowed-to-rest,driver-breaktime-level";
				attribute presetWeight :> presetWeight = "1,1";
				attribute postsetWeight :> postsetWeight = "1,11";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'begin driving shift' : OperandTransition {
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "begin driving shift";
				attribute preset :> preset = "allowed-to-rest,driver-breaktime-level";
				attribute postset :> postset = "allowed-to-drive,driver-energy-level";
				attribute presetWeight :> presetWeight = "1,1";
				attribute postsetWeight :> postsetWeight = "1,11";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'check out ev-driver' : OperandTransition {
				attribute varDomain :> varDomain = "binary";
				attribute name :> name = "check out ev-driver";
				attribute preset :> preset = "state-of-charge,allowed-to-drive,driver-energy-lev...";
				attribute postset :> postset = "signed-out";
				attribute presetWeight :> presetWeight = "10,1,11";
				attribute postsetWeight :> postsetWeight = "1";
				attribute processLinkName :> processLinkName = "";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
	}
}