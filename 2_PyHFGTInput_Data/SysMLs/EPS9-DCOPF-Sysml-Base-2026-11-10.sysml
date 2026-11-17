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
		attribute hasProcessRamp;
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
	part 'EPS9-DCOPF' : LFES {
		attribute analysisMethod :> analysisMethod = "HFNMCF";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute hasBufferFinalCond :> hasBufferFinalCond = "false";
		attribute hasBufferInitCond :> hasBufferInitCond = "false";
		attribute hasBufferLinearCost :> hasBufferLinearCost = "false";
		attribute hasBufferLowerBound :> hasBufferLowerBound = "false";
		attribute hasBufferQuadCost :> hasBufferQuadCost = "false";
		attribute hasBufferUpperBound :> hasBufferUpperBound = "true";
		attribute hasESNEnablingConstraint :> hasESNEnablingConstraint = "false";
		attribute hasESN_Duration :> hasESN_Duration = "false";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "false";
		attribute hasProcessDuration :> hasProcessDuration = "false";
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
		attribute hasProcessRamp :> hasProcessRamp = "false";
		attribute hasProcessUpperBoundFlowNeg :> hasProcessUpperBoundFlowNeg = "true";
		attribute hasProcessUpperBoundFlowPos :> hasProcessUpperBoundFlowPos = "false";
		attribute hasProcessUpperBoundRamp :> hasProcessUpperBoundRamp = "false";
		attribute hasProcessUpperBoundStock :> hasProcessUpperBoundStock = "false";
		attribute hasProcessValues :> hasProcessValues = "true";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "EPS9-DCOPF";
		attribute optimizer :> optimizer = "Gurobi";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "ElectricPowerSystem";
		attribute scenario :> scenario = "base";
		attribute simHorizon :> simHorizon = "2";
		attribute verboseMode :> verboseMode = "true";
		part 'Generator 1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Generator 1";
			action 'generate electricity' : TransformProcess {
				attribute name :> name = "generate electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "250";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "10";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "5.0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0.11";
			}
		}
		part 'Generator 2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Generator 2";
			action 'generate electricity' : TransformProcess {
				attribute name :> name = "generate electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "300";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "10";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1.2";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0.085";
			}
		}
		part 'Generator 3' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Generator 3";
			action 'generate electricity' : TransformProcess {
				attribute name :> name = "generate electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "270";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "10";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1.0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0.1225";
			}
		}
		part 'Demand 4' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Demand 4";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "200";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute value :> value = "0";
			}
		}
		part 'Demand 5' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Demand 5";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "200";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute value :> value = "90";
			}
		}
		part 'Demand 6' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Demand 6";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "200";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute value :> value = "0";
			}
		}
		part 'Demand 7' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Demand 7";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "200";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute value :> value = "100";
			}
		}
		part 'Demand 8' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Demand 8";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "200";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute value :> value = "0";
			}
		}
		part 'Demand 9' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute varDomain :> varDomain = "real+";
			attribute upperBound :> upperBound = "0";
			attribute transformationResourceName :> transformationResourceName = "Demand 9";
			action 'consume electricity' : TransformProcess {
				attribute name :> name = "consume electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "200";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "0";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute value :> value = "125";
			}
		}
		part 'Branch 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 1";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Generator 1";
				attribute destination :> destination = "Demand 4";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 2";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 4";
				attribute destination :> destination = "Demand 5";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 3";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 5";
				attribute destination :> destination = "Demand 6";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 4";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Generator 3";
				attribute destination :> destination = "Demand 6";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 5";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 6";
				attribute destination :> destination = "Demand 7";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 6";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 7";
				attribute destination :> destination = "Demand 8";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 7";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 8";
				attribute destination :> destination = "Generator 2";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 8";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 8";
				attribute destination :> destination = "Demand 9";
				attribute refinement :> refinement = "";
			}
		}
		part 'Branch 9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Scheduler";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Branch 9";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute varDomain :> varDomain = "real";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute lowerBoundFlowNeg :> lowerBoundFlowNeg = "-10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute origin :> origin = "Demand 9";
				attribute destination :> destination = "Demand 4";
				attribute refinement :> refinement = "";
			}
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
			attribute hasTransitionDurationConds :> hasTransitionDurationConds = "false";
			attribute hasTransitionFinalConds :> hasTransitionFinalConds = "false";
			attribute hasTransitionInitConds :> hasTransitionInitConds = "false";
		}
	}
}