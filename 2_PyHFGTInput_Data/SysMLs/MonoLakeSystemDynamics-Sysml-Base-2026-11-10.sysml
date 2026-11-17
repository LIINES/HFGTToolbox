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
	part 'MonoLakeSystemDynamics' : LFES {
		attribute analysisMethod :> analysisMethod = "default";
		attribute dataState :> dataState = "raw";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "MonoLakeSystemDynamics";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Mono Lake";
		attribute scenario :> scenario = "base";
		attribute verboseMode :> verboseMode = "true";
		part 'Mono Lake' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "Mono Lake";
			action 'accept precipitated water' : TransformProcess {
				attribute name :> name = "accept precipitated water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'accept water from Flow Past Diversion Point' : TransformProcess {
				attribute name :> name = "accept water from Flow Past Diversion Point";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'evaporate water' : TransformProcess {
				attribute name :> name = "evaporate water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
		}
		part 'Mono Aquifer' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "Mono Aquifer";
			action 'withdraw water' : TransformProcess {
				attribute name :> name = "withdraw water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
		}
		part 'Percolator' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Percolator";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Mono Lake";
				attribute destination :> destination = "Mono Aquifer";
				attribute refinement :> refinement = "water";
			}
		}
		part 'Groundwater Discharger' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Groundwater Discharger";
			action 'transport' : TransportProcess {
				attribute name :> name = "transport";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "water";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute origin :> origin = "Mono Aquifer";
				attribute destination :> destination = "Mono Lake";
				attribute refinement :> refinement = "water";
			}
		}
		item 'water' : Operand {
			attribute operandName :> operandName = "water";
			attribute operandNetName :> operandNetName = "deliver water";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
		}
	}
}