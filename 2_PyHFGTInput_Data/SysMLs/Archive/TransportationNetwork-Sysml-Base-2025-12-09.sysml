package Model {
	view Model : 'SysML Standard Diagrams'::gv;
	part def LFES {
		attribute name;
		attribute scenario;
		attribute refArchitecture;
		attribute dataState;
		attribute inputDataFormat;
		attribute verboseMode;
		attribute analysisMethod;
		attribute outputFileType;
		attribute optimizer;
		attribute simHorizon;
		attribute deltaT;
		attribute hasBufferUpperBound;
		attribute hasBufferLowerBound;
		attribute hasBufferInitCond;
		attribute hasBufferFinalCond;
		attribute hasBufferCost;
		attribute hasProcessUpperBound;
		attribute hasProcessLowerBound;
		attribute hasProcessInitCond;
		attribute hasProcessFinalCond;
		attribute hasProcessCost;
		attribute hasProcessDuration;
		attribute hasProcessRamp;
		attribute hasProcessValues;
	}
	part def TransformationResource {
		attribute transformationResourceName;
	}
	part def IndependentBuffer {
		attribute independentBufferName;
		attribute gpsX;
		attribute gpsY;
		attribute decisionMaker;
		attribute autonomous;
		attribute varDomain;
		attribute linearCostCoeff;
		attribute upperBound;
		attribute initCond;
		attribute finalCond;
	}
	part def TransportationResource {
		attribute transportationResourceName;
		attribute decisionMaker;
		attribute autonomous;
	}
	item def Operand {
		attribute operandName;
		attribute operandType;
		attribute operandNetName;
		attribute hasOperandNet_Duration;
		attribute hasOperandNet_STF1;
		attribute hasOperandNet_STF2;
		attribute hasSyncMatNeg;
		attribute hasSyncMatPos;
		attribute hasPlaceUpperBound;
		attribute hasPlaceLowerBound;
		attribute hasPlaceCost;
		attribute hasPlaceFinalConds;
		attribute hasPlaceInitConds;
		attribute hasTransitionCapacityConds;
		attribute hasTransitionCost;
		attribute hasTransitionDurationConds;
		attribute hasTransitionFinalConds;
		attribute hasTransitionInitConds;
	}
	action def TransportProcess {
		attribute name;
		attribute status;
		attribute varDomain;
		attribute origin;
		attribute destination;
		attribute refinment;
		attribute inputOperand;
		attribute inputOperandWeight;
		attribute outputOperand;
		attribute outputOperandWeight;
		attribute linearCostCoeff;
		attribute upperBound;
		attribute duration;
	}
	part 'Transportation Network' : LFES {
		attribute name :> name = "TransportationNetwork";
		attribute scenario :> scenario = "base";
		attribute refArchitecture :> refArchitecture = "Transportation System";
		attribute dataState :> dataState = "raw";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute verboseMode :> verboseMode = "true";
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute outputFileType :> outputFileType = "json";
		attribute optimizer :> optimizer = "CPLEX";
		attribute simHorizon :> simHorizon = "2";
		attribute deltaT :> deltaT = "1";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "false";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "true";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferInitCond :> hasBufferInitCond = "true";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "true";
		attribute hasBufferCost :> hasBufferCost = "true";
		attribute hasProcessUpperBound :> hasProcessUpperBound = "true";
		attribute hasProcessLowerBound :> hasProcessLowerBound = "false";
		attribute hasProcessInitCond :> hasProcessInitCond = "false";
		attribute hasProcessFinalCond :> hasProcessFinalCond = "false";
		attribute hasProcessCost :> hasProcessCost = "true";
		attribute hasProcessDuration :> hasProcessDuration = "true";
		attribute hasProcessRamp :> hasProcessRamp = "false";
		attribute hasProcessValues :> hasProcessValues = "false";
		item 'widget' : Operand {
			attribute operandName :> operandName = "widget";
			attribute operandType :> operandType = "matter";
			attribute operandNetName :> operandNetName = "deliver widget";
			attribute status :> status = "true";
			attribute hasOperandNet_Duration :> hasOperandNet_Duration = "false";
			attribute hasOperandNet_STF1 :> hasOperandNet_STF1 = "false";
			attribute hasOperandNet_STF2 :> hasOperandNet_STF2 = "false";
			attribute hasSyncMatNeg :> hasSyncMatNeg = "false";
			attribute hasSyncMatPos :> hasSyncMatPos = "false";
			attribute hasPlaceUpperBound :> hasPlaceUpperBound = "false";
			attribute hasPlaceLowerBound :> hasPlaceLowerBound = "false";
			attribute hasPlaceCost :> hasPlaceCost = "false";
			attribute hasPlaceFinalConds :> hasPlaceFinalConds = "false";
			attribute hasPlaceInitConds :> hasPlaceInitConds = "false";
			attribute hasTransitionCapacityConds :> hasTransitionCapacityConds = "false";
			attribute hasTransitionCost :> hasTransitionCost = "false";
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "false";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "false";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "false";
		}
		part 'A-Factory' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "A-Factory";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute varDomain :> varDomain = "real";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute upperBound :> upperBound = "1000";
			attribute initCond :> initCond = "50";
			attribute finalCond :> finalCond = "0";
		}
		part 'B-Factory' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "B-Factory";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute varDomain :> varDomain = "real";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute upperBound :> upperBound = "1000";
			attribute initCond :> initCond = "40";
			attribute finalCond :> finalCond = "0";
		}
		part 'C-Distribution' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "C-Distribution";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute varDomain :> varDomain = "real";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute upperBound :> upperBound = "1000";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
		}
		part 'D-Warehouse' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "D-Warehouse";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute varDomain :> varDomain = "real";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute upperBound :> upperBound = "1000";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "30";
		}
		part 'E-Warehouse' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "E-Warehouse";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute varDomain :> varDomain = "real";
			attribute linearCostCoeff :> linearCostCoeff = "0";
			attribute upperBound :> upperBound = "1000";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "60";
		}
		part 'AB-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "AB-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportWidget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "B-Factory";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "2";
				attribute upperBound :> upperBound = "10";
				attribute duration :> duration = "0";
			}
		}
		part 'AC-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "AC-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportWidget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "4";
				attribute upperBound :> upperBound = "1000";
				attribute duration :> duration = "0";
			}
		}
		part 'AD-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "AD-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportWidget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "D-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "9";
				attribute upperBound :> upperBound = "1000";
				attribute duration :> duration = "0";
			}
		}
		part 'BC-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "BC-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "B-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "3";
				attribute upperBound :> upperBound = "1000";
				attribute duration :> duration = "0";
			}
		}
		part 'CE-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "CE-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "C-Distribution";
				attribute destination :> destination = "E-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "1";
				attribute upperBound :> upperBound = "80";
				attribute duration :> duration = "0";
			}
		}
		part 'DE-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "DE-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "D-Warehouse";
				attribute destination :> destination = "E-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "3";
				attribute upperBound :> upperBound = "1000";
				attribute duration :> duration = "0";
			}
		}
		part 'ED-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "ED-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute varDomain :> varDomain = "real";
				attribute origin :> origin = "E-Warehouse";
				attribute destination :> destination = "D-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute linearCostCoeff :> linearCostCoeff = "2";
				attribute upperBound :> upperBound = "1000";
				attribute duration :> duration = "0";
			}
		}
	}
}