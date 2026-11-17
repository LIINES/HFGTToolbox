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
		attribute hasBufferFinalCond;
		attribute hasBufferInitCond;
		attribute hasBufferLinearCost;
		attribute hasBufferLowerBound;
		attribute hasBufferQuadCost;
		attribute hasBufferUpperBound;
		attribute hasESN_Duration;
		attribute hasESN_STF1;
		attribute hasESN_STF2;
		attribute hasProcessDuration;
		attribute hasProcessFinalCond;
		attribute hasProcessInitCond;
		attribute hasProcessLinearCostFlowNeg;
		attribute hasProcessLinearCostFlowPos;
		attribute hasProcessLinearCostStock;
		attribute hasProcessLowerBoundFlowNeg;
		attribute hasProcessLowerBoundFlowPos;
		attribute hasProcessLowerBoundRamp;
		attribute hasProcessLowerBoundStock;
		attribute hasProcessQuadCostFlowNeg;
		attribute hasProcessQuadCostFlowPos;
		attribute hasProcessQuadCostStock;
		attribute hasProcessUpperBoundFlowNeg;
		attribute hasProcessUpperBoundFlowPos;
		attribute hasProcessUpperBoundRamp;
		attribute hasProcessUpperBoundStock;
		attribute hasProcessValues;
		attribute holdingProcess;
		attribute independentBuffer;
		attribute inputDataFormat;
		attribute inputFilePath;
		attribute juliaOutputFilePath;
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
		attribute quadCostCoeff;
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
		attribute quadCostCoeff;
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
		attribute hasPlaceFinalConds;
		attribute hasPlaceInitConds;
		attribute hasPlaceLinearCost;
		attribute hasPlaceLowerBound;
		attribute hasPlaceQuadCost;
		attribute hasPlaceUpperBound;
		attribute hasSyncMatNeg;
		attribute hasSyncMatPos;
		attribute hasTransitionDurationConds;
		attribute hasTransitionFinalConds;
		attribute hasTransitionInitConds;
		attribute hasTransitionLinearCostFlowNeg;
		attribute hasTransitionLinearCostFlowPos;
		attribute hasTransitionLinearCostStock;
		attribute hasTransitionLowerBoundFlowNeg;
		attribute hasTransitionLowerBoundFlowPos;
		attribute hasTransitionLowerBoundStock;
		attribute hasTransitionQuadCostFlowNeg;
		attribute hasTransitionQuadCostFlowPos;
		attribute hasTransitionQuadCostStock;
		attribute hasTransitionUpperBoundFlowNeg;
		attribute hasTransitionUpperBoundFlowPos;
		attribute hasTransitionUpperBoundStock;
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
		attribute linearCostCoeffFlowNeg;
		attribute linearCostCoeffFlowPos;
		attribute linearCostCoeffStock;
		attribute lowerBoundFlowNeg;
		attribute lowerBoundFlowPos;
		attribute lowerBoundRamp;
		attribute lowerBoundStock;
		attribute name;
		attribute number;
		attribute numberMax;
		attribute outputOperand;
		attribute outputOperandWeight;
		attribute quadCostCoeffFlowNeg;
		attribute quadCostCoeffFlowPos;
		attribute quadCostCoeffStock;
		attribute requiredKeys;
		attribute status;
		attribute upperBoundFlowNeg;
		attribute upperBoundFlowPos;
		attribute upperBoundRamp;
		attribute upperBoundStock;
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
		attribute linearCostCoeffFlowNeg;
		attribute linearCostCoeffFlowPos;
		attribute linearCostCoeffStock;
		attribute lowerBoundFlowNeg;
		attribute lowerBoundFlowPos;
		attribute lowerBoundRamp;
		attribute lowerBoundStock;
		attribute name;
		attribute nameRef;
		attribute number;
		attribute numberMax;
		attribute numberRefMax;
		attribute origin;
		attribute outputOperand;
		attribute outputOperandWeight;
		attribute quadCostCoeffFlowNeg;
		attribute quadCostCoeffFlowPos;
		attribute quadCostCoeffStock;
		attribute ref;
		attribute requiredKeys;
		attribute status;
		attribute upperBoundFlowNeg;
		attribute upperBoundFlowPos;
		attribute upperBoundRamp;
		attribute upperBoundStock;
		attribute validator;
		attribute value;
		attribute varDomain;
	}
	part 'TransportationNetwork' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "true";
		attribute hasBufferInitCond :> hasBufferInitCond = "true";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "true";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "true";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "true";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "false";
		attribute hasProcessDuration :> hasProcessDuration = "true";
		attribute hasProcessFinalCond :> hasProcessFinalCond = "false";
		attribute hasProcessInitCond :> hasProcessInitCond = "false";
		attribute hasProcessLinearCostFlowNeg :> hasProcessLinearCostFlowNeg = "true";
		attribute hasProcessLinearCostFlowPos :> hasProcessLinearCostFlowPos = "false";
		attribute hasProcessLinearCostStock :> hasProcessLinearCostStock = "false";
		attribute hasProcessLowerBoundFlowNeg :> hasProcessLowerBoundFlowNeg = "false";
		attribute hasProcessLowerBoundFlowPos :> hasProcessLowerBoundFlowPos = "false";
		attribute hasProcessLowerBoundRamp :> hasProcessLowerBoundRamp = "false";
		attribute hasProcessLowerBoundStock :> hasProcessLowerBoundStock = "false";
		attribute hasProcessQuadCostFlowNeg :> hasProcessQuadCostFlowNeg = "true";
		attribute hasProcessQuadCostFlowPos :> hasProcessQuadCostFlowPos = "false";
		attribute hasProcessQuadCostStock :> hasProcessQuadCostStock = "false";
		attribute hasProcessUpperBoundFlowNeg :> hasProcessUpperBoundFlowNeg = "true";
		attribute hasProcessUpperBoundFlowPos :> hasProcessUpperBoundFlowPos = "false";
		attribute hasProcessUpperBoundRamp :> hasProcessUpperBoundRamp = "false";
		attribute hasProcessUpperBoundStock :> hasProcessUpperBoundStock = "false";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "B-Factory";
				attribute linearCostCoeff :> linearCostCoeff = "2";
				attribute upperBound :> upperBound = "10";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute linearCostCoeff :> linearCostCoeff = "4";
				attribute upperBound :> upperBound = "1000";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "D-Warehouse";
				attribute linearCostCoeff :> linearCostCoeff = "9";
				attribute upperBound :> upperBound = "1000";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "B-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute linearCostCoeff :> linearCostCoeff = "3";
				attribute upperBound :> upperBound = "1000";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "C-Distribution";
				attribute destination :> destination = "E-Warehouse";
				attribute linearCostCoeff :> linearCostCoeff = "1";
				attribute upperBound :> upperBound = "80";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "D-Warehouse";
				attribute destination :> destination = "E-Warehouse";
				attribute linearCostCoeff :> linearCostCoeff = "3";
				attribute upperBound :> upperBound = "1000";
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
				attribute duration :> duration = "0";
				attribute origin :> origin = "E-Warehouse";
				attribute destination :> destination = "D-Warehouse";
				attribute linearCostCoeff :> linearCostCoeff = "2";
				attribute upperBound :> upperBound = "1000";
				attribute varDomain :> varDomain = "real";
				attribute refinement :> refinement = "hold widget";
			}
		}
		item 'widget' : Operand {
			attribute operandName :> operandName = "widget";
			attribute operandNetName :> operandNetName = "deliver widget";
			attribute status :> status = "true";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "false";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "false";
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
			attribute operandType :> operandType = "matter";
		}
	}
}