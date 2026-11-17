package Model {
	view Model : 'SysML Standard Diagrams'::gv;
	part def LFES {
		attribute analysisMethod;
		attribute analytics;
		attribute buffer;
		attribute dataState;
		attribute decisionMaker;
		attribute deltaT;
		attribute engSysNet;
		attribute hasBufferCost;
		attribute hasBufferFinalCond;
		attribute hasBufferInitCond;
		attribute hasBufferLowerBound;
		attribute hasBufferUpperBound;
		attribute hasESN_Duration;
		attribute hasESN_STF1;
		attribute hasESN_STF2;
		attribute hasProcessCost;
		attribute hasProcessDuration;
		attribute hasProcessFinalCond;
		attribute hasProcessInitCond;
		attribute hasProcessLowerBound;
		attribute hasProcessRamp;
		attribute hasProcessUpperBound;
		attribute hasProcessValues;
		attribute holdingProcess;
		attribute independentBuffer;
		attribute inputDataFormat;
		attribute inputFilePath;
		attribute myClass;
		attribute name;
		attribute number;
		attribute operand;
		attribute optimizer;
		attribute outputDirectory;
		attribute outputFilePath;
		attribute outputFileType;
		attribute physicalResource;
		attribute refArchitecture;
		attribute requiredKeys;
		attribute runCode;
		attribute scenario;
		attribute simHorizon;
		attribute sosService;
		attribute systemConcept;
		attribute systemProcess;
		attribute timeKeeper;
		attribute transformProcess;
		attribute transformationResource;
		attribute transportProcess;
		attribute transportationResource;
		attribute validator;
		attribute verboseMode;
		attribute view;
	}
	part def TransformationResource {
		attribute autonomous;
		attribute decisionMaker;
		attribute finalCond;
		attribute gpsX;
		attribute gpsY;
		attribute idx;
		attribute idxBuffer;
		attribute idxResource;
		attribute initCond;
		attribute linearCostCoeff;
		attribute lowerBound;
		attribute name;
		attribute number;
		attribute requiredKeys;
		attribute status;
		attribute transformProcess;
		attribute transformationResourceName;
		attribute transportProcess;
		attribute upperBound;
		attribute validator;
		attribute varDomain;
	}
	part def IndependentBuffer {
		attribute autonomous;
		attribute decisionMaker;
		attribute finalCond;
		attribute gpsX;
		attribute gpsY;
		attribute idx;
		attribute idxBuffer;
		attribute idxResource;
		attribute independentBufferName;
		attribute initCond;
		attribute linearCostCoeff;
		attribute lowerBound;
		attribute name;
		attribute number;
		attribute requiredKeys;
		attribute status;
		attribute transportProcess;
		attribute upperBound;
		attribute validator;
		attribute varDomain;
	}
	part def TransportationResource {
		attribute autonomous;
		attribute decisionMaker;
		attribute idx;
		attribute idxResource;
		attribute name;
		attribute number;
		attribute requiredKeys;
		attribute status;
		attribute transportProcess;
		attribute transportationResourceName;
		attribute validator;
	}
	item def Operand {
		attribute AL;
		attribute ALrho;
		attribute Adual;
		attribute Aprime;
		attribute Lambda;
		attribute LambdaHolding;
		attribute LambdaTransform;
		attribute LambdaTransport;
		attribute MFull;
		attribute Mneg;
		attribute Mpos;
		attribute UFull;
		attribute Uneg;
		attribute Upos;
		attribute XE;
		attribute XS;
		attribute hasOperandNet_Duration;
		attribute hasOperandNet_STF1;
		attribute hasOperandNet_STF2;
		attribute hasPlaceCost;
		attribute hasPlaceFinalConds;
		attribute hasPlaceInitConds;
		attribute hasPlaceLowerBound;
		attribute hasPlaceUpperBound;
		attribute hasSyncMatNeg;
		attribute hasSyncMatPos;
		attribute hasTransitionCapacityConds;
		attribute hasTransitionCost;
		attribute hasTransitionDurationConds;
		attribute hasTransitionFinalConds;
		attribute hasTransitionInitConds;
		attribute idx;
		attribute number;
		attribute operandName;
		attribute operandNetName;
		attribute operandType;
		attribute pnPlaces;
		attribute pnTransitions;
		attribute requiredKeys;
		attribute sosType;
		attribute status;
		attribute syncMat;
		attribute validator;
	}
	action def TransformProcess {
		attribute MLPNeg;
		attribute MLPPos;
		attribute duration;
		attribute finalCond;
		attribute idx;
		attribute idxProcess;
		attribute initCond;
		attribute inputOperand;
		attribute inputOperandWeight;
		attribute linearCostCoeff;
		attribute lowerBound;
		attribute lowerBoundRamp;
		attribute name;
		attribute number;
		attribute numberMax;
		attribute outputOperand;
		attribute outputOperandWeight;
		attribute requiredKeys;
		attribute status;
		attribute upperBound;
		attribute upperBoundRamp;
		attribute validator;
		attribute value;
		attribute varDomain;
	}
	action def TransportProcess {
		attribute MLPNeg;
		attribute MLPPos;
		attribute destination;
		attribute duration;
		attribute finalCond;
		attribute idx;
		attribute idxDestination;
		attribute idxHolding;
		attribute idxOrigin;
		attribute idxProcess;
		attribute idxTransport;
		attribute initCond;
		attribute inputOperand;
		attribute inputOperandWeight;
		attribute linearCostCoeff;
		attribute lowerBound;
		attribute lowerBoundRamp;
		attribute name;
		attribute nameRef;
		attribute number;
		attribute numberMax;
		attribute numberRefMax;
		attribute origin;
		attribute outputOperand;
		attribute outputOperandWeight;
		attribute ref;
		attribute requiredKeys;
		attribute status;
		attribute upperBound;
		attribute upperBoundRamp;
		attribute validator;
		attribute value;
		attribute varDomain;
	}
	part 'TransportationNetwork' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferCost :> hasBufferCost = "true";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "true";
		attribute hasBufferInitCond :> hasBufferInitCond = "true";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "true";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "false";
		attribute hasProcessCost :> hasProcessCost = "true";
		attribute hasProcessDuration :> hasProcessDuration = "true";
		attribute hasProcessFinalCond :> hasProcessFinalCond = "false";
		attribute hasProcessInitCond :> hasProcessInitCond = "false";
		attribute hasProcessLowerBound :> hasProcessLowerBound = "false";
		attribute hasProcessRamp :> hasProcessRamp = "false";
		attribute hasProcessUpperBound :> hasProcessUpperBound = "true";
		attribute hasProcessValues :> hasProcessValues = "false";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "TransportationNetwork";
		attribute optimizer :> optimizer = "CPLEX";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Transportation System";
		attribute scenario :> scenario = "base";
		attribute simHorizon :> simHorizon = "2";
		attribute verboseMode :> verboseMode = "true";
		part 'A-Factory' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute initCond :> initCond = "50";
			attribute finalCond :> finalCond = "0";
			attribute upperBound :> upperBound = "1000";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute independentBufferName :> independentBufferName = "A-Factory";
			attribute varDomain :> varDomain = "real";
		}
		part 'B-Factory' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute initCond :> initCond = "40";
			attribute finalCond :> finalCond = "0";
			attribute upperBound :> upperBound = "1000";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute independentBufferName :> independentBufferName = "B-Factory";
			attribute varDomain :> varDomain = "real";
		}
		part 'C-Distribution' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
			attribute upperBound :> upperBound = "1000";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute independentBufferName :> independentBufferName = "C-Distribution";
			attribute varDomain :> varDomain = "real";
		}
		part 'D-Warehouse' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "30";
			attribute upperBound :> upperBound = "1000";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute independentBufferName :> independentBufferName = "D-Warehouse";
			attribute varDomain :> varDomain = "real";
		}
		part 'E-Warehouse' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "60";
			attribute upperBound :> upperBound = "1000";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute independentBufferName :> independentBufferName = "E-Warehouse";
			attribute varDomain :> varDomain = "real";
		}
		part 'AB-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "AB-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "10";
				attribute linearCostCoeff :> linearCostCoeff = "2";
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "B-Factory";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		part 'AC-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "AC-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "1000";
				attribute linearCostCoeff :> linearCostCoeff = "4";
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		part 'AD-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "AD-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "1000";
				attribute linearCostCoeff :> linearCostCoeff = "9";
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "D-Warehouse";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		part 'BC-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "BC-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "1000";
				attribute linearCostCoeff :> linearCostCoeff = "3";
				attribute duration :> duration = "0";
				attribute origin :> origin = "B-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		part 'CE-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "CE-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "80";
				attribute linearCostCoeff :> linearCostCoeff = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "C-Distribution";
				attribute destination :> destination = "E-Warehouse";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		part 'DE-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "DE-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "1000";
				attribute linearCostCoeff :> linearCostCoeff = "3";
				attribute duration :> duration = "0";
				attribute origin :> origin = "D-Warehouse";
				attribute destination :> destination = "E-Warehouse";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		part 'ED-Route' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "ED-Route";
			action 'transport widget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "widget";
				attribute outputOperand :> outputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBound :> upperBound = "1000";
				attribute linearCostCoeff :> linearCostCoeff = "2";
				attribute duration :> duration = "0";
				attribute origin :> origin = "E-Warehouse";
				attribute destination :> destination = "D-Warehouse";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		item 'widget' : Operand {
			attribute operandName :> operandName = "widget";
			attribute operandNetName :> operandNetName = "deliver widget";
			attribute status :> status = "true";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "false";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "false";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasPlaceUpperBound :> hasPlaceUpperBound = "false";
			attribute hasPlaceLowerBound :> hasPlaceLowerBound = "false";
			attribute hasPlaceFinalConds :> hasPlaceFinalConds = "false";
			attribute hasPlaceInitConds :> hasPlaceInitConds = "false";
			attribute hasPlaceCost :> hasPlaceCost = "false";
			attribute hasTransitionCapacityConds :> hasTransitionCapacityConds = "false";
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "false";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "false";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "false";
			attribute hasTransitionCost :> hasTransitionCost = "false";
			attribute hasSyncMatNeg :> hasSyncMatNeg = "false";
			attribute hasSyncMatPos :> hasSyncMatPos = "false";
			attribute operandType :> operandType = "matter";
		}
	}
}