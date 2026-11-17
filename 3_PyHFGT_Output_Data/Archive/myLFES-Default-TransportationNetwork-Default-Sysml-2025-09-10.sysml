package Model {
	view Model : 'SysML Standard Diagrams'::gv;
	part def LFES {
		attribute name;
		attribute scenario;
		attribute refArchitecture;
		attribute dataState;
		attribute inputDataFormat;
		attribute version;
		attribute verboseMode;
		attribute analysisMethod;
		attribute outputDataFormat;
		attribute outputFileType;
		attribute simHorizon;
		attribute deltaT;
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
		attribute bufferCost;
		attribute bufferCapacity;
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
	}
	action def TransportProcess {
		attribute name;
		attribute status;
		attribute origin;
		attribute destination;
		attribute refinment;
		attribute inputOperand;
		attribute inputOperandWeight;
		attribute outputOperand;
		attribute outputOperandWeight;
		attribute processCost;
		attribute processCapacity;
	}
	part 'Transportation Network' : LFES {
		attribute name :> name = "TransportationNetwork";
		attribute scenario :> scenario = "base";
		attribute refArchitecture :> refArchitecture = "Transportation System";
		attribute dataState :> dataState = "raw";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute version :> version = "4.0";
		attribute verboseMode :> verboseMode = "false";
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute outputDataFormat :> outputDataFormat = "default";
		attribute outputFileType :> outputFileType = "sysml";
		attribute simHorizon :> simHorizon = "2";
		attribute deltaT :> deltaT = "1";
		item 'widget' : Operand {
			attribute operandName :> operandName = "widget";
			attribute operandType :> operandType = "matter";
		}
		part 'A-Factory' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "A-Factory";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute bufferCost :> bufferCost = "0";
			attribute bufferCapacity :> bufferCapacity = "1000";
			attribute initCond :> initCond = "50";
			attribute finalCond :> finalCond = "0";
		}
		part 'B-Factory' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "B-Factory";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute bufferCost :> bufferCost = "0";
			attribute bufferCapacity :> bufferCapacity = "1000";
			attribute initCond :> initCond = "40";
			attribute finalCond :> finalCond = "0";
		}
		part 'C-Distribution' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "C-Distribution";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute bufferCost :> bufferCost = "0";
			attribute bufferCapacity :> bufferCapacity = "1000";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "0";
		}
		part 'D-Warehouse' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "D-Warehouse";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute bufferCost :> bufferCost = "0";
			attribute bufferCapacity :> bufferCapacity = "1000";
			attribute initCond :> initCond = "0";
			attribute finalCond :> finalCond = "30";
		}
		part 'E-Warehouse' : IndependentBuffer {
			attribute independentBufferName :> independentBufferName = "E-Warehouse";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "2";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute bufferCost :> bufferCost = "0";
			attribute bufferCapacity :> bufferCapacity = "1000";
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
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "B-Factory";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "2";
				attribute processCapacity :> processCapacity = "10";
			}
		}
		part 'AC-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "AC-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportWidget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "4";
				attribute processCapacity :> processCapacity = "1000";
			}
		}
		part 'AD-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "AD-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportWidget' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute origin :> origin = "A-Factory";
				attribute destination :> destination = "D-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "9";
				attribute processCapacity :> processCapacity = "1000";
			}
		}
		part 'BC-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "BC-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute origin :> origin = "B-Factory";
				attribute destination :> destination = "C-Distribution";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "3";
				attribute processCapacity :> processCapacity = "1000";
			}
		}
		part 'CE-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "CE-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute origin :> origin = "C-Distribution";
				attribute destination :> destination = "E-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "1";
				attribute processCapacity :> processCapacity = "80";
			}
		}
		part 'DE-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "DE-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute origin :> origin = "D-Warehouse";
				attribute destination :> destination = "E-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "3";
				attribute processCapacity :> processCapacity = "1000";
			}
		}
		part 'ED-Route' : TransportationResource {
			attribute transportationResourceName :> transportationResourceName = "ED-Route";
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			action 'transportationProcess' : TransportProcess {
				attribute name :> name = "transport widget";
				attribute status :> status = "true";
				attribute origin :> origin = "E-Warehouse";
				attribute destination :> destination = "D-Warehouse";
				attribute refinement :> refinement = "hold widget";
				attribute inputOperand :> inputOperand = "widget";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperand :> outputOperand = "widget";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute processCost :> processCost = "2";
				attribute processCapacity :> processCapacity = "1000";
			}
		}
	}
}