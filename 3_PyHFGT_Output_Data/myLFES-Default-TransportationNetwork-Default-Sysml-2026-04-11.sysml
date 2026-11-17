package Model {
	view Model : 'SysML Standard Diagrams'::gv;
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
		attribute hasESNEnablingConstraint;
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
		attribute myClass;
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
	part 'TransportationNetwork' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "true";
		attribute hasBufferInitCond :> hasBufferInitCond = "true";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "true";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "true";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "false";
		attribute hasESNEnablingConstraint :> hasESNEnablingConstraint = "false";
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
		attribute hasProcessQuadCostFlowNeg :> hasProcessQuadCostFlowNeg = "false";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "2";
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "B-Factory";
				attribute varDomain :> varDomain = "real+";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "4";
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute varDomain :> varDomain = "real+";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "9";
				attribute duration :> duration = "0";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "D-Warehouse";
				attribute varDomain :> varDomain = "real+";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "3";
				attribute duration :> duration = "0";
				attribute origin :> origin = "B-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute varDomain :> varDomain = "real+";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "80";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1";
				attribute duration :> duration = "0";
				attribute origin :> origin = "C-Distribution";
				attribute destination :> destination = "E-Warehouse";
				attribute varDomain :> varDomain = "real+";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "3";
				attribute duration :> duration = "0";
				attribute origin :> origin = "D-Warehouse";
				attribute destination :> destination = "E-Warehouse";
				attribute varDomain :> varDomain = "real+";
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
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "2";
				attribute duration :> duration = "0";
				attribute origin :> origin = "E-Warehouse";
				attribute destination :> destination = "D-Warehouse";
				attribute varDomain :> varDomain = "real+";
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
			attribute operandType :> operandType = "matter";
		}
	}
}