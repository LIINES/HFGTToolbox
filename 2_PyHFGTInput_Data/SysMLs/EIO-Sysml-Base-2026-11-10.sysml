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
		attribute version;
		attribute outputDataFormat;
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
	part 'EIO' : LFES {
		attribute analysisMethod :> analysisMethod = "default";
		attribute dataState :> dataState = "raw";
		attribute deltaT :> deltaT = "1";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "EIO";
		attribute outputDataFormat :> outputDataFormat = "Mini";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "Economic System";
		attribute scenario :> scenario = "base";
		attribute simHorizon :> simHorizon = "2";
		attribute verboseMode :> verboseMode = "false";
		attribute version :> version = "4.0";
		part 'The economy' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "The economy";
			action 'produces manufactured products' : TransformProcess {
				attribute name :> name = "produces manufactured products";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "Manufactured product,Construction product,Agricultural product,Capital,Water";
				attribute outputOperand :> outputOperand = "Manufactured product";
				attribute inputOperandWeight :> inputOperandWeight = "0.35,0.25,0.2,2.1,1.2";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'produces construction products with conventional technology' : TransformProcess {
				attribute name :> name = "produces construction products with conventional technology";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "Manufactured product,Construction product,Agricultural product,Capital,Water";
				attribute outputOperand :> outputOperand = "Construction product";
				attribute inputOperandWeight :> inputOperandWeight = "0.15,0.22,0.26,3.2,2.2";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'produces construction products with modern technology' : TransformProcess {
				attribute name :> name = "produces construction products with modern technology";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "Manufactured product,Construction product,Agricultural product,Capital,Water";
				attribute outputOperand :> outputOperand = "Construction product";
				attribute inputOperandWeight :> inputOperandWeight = "0.23,0.16,0.3,1.9,1.3";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'produces agricultural products with labor-based technology' : TransformProcess {
				attribute name :> name = "produces agricultural products with labor-based technology";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "Manufactured product,Construction product,Agricultural product,Capital,Water";
				attribute outputOperand :> outputOperand = "Agricultural product";
				attribute inputOperandWeight :> inputOperandWeight = "0.26,0.22,0.31,1.2,1.3";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'produces agricultural products with hybrid technology' : TransformProcess {
				attribute name :> name = "produces agricultural products with hybrid technology";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "Manufactured product,Construction product,Agricultural product,Capital,Water";
				attribute outputOperand :> outputOperand = "Agricultural product";
				attribute inputOperandWeight :> inputOperandWeight = "0.28,0.21,0.33,0.8,1.1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
			action 'produces agricultural products with automated technology' : TransformProcess {
				attribute name :> name = "produces agricultural products with automated technology";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "Manufactured product,Construction product,Agricultural product,Capital,Water";
				attribute outputOperand :> outputOperand = "Agricultural product";
				attribute inputOperandWeight :> inputOperandWeight = "0.24,0.25,0.3,1.4,1.1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
			}
		}
		item 'Water' : Operand {
			attribute operandName :> operandName = "Water";
			attribute operandNetName :> operandNetName = "deliver water";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
		}
		item 'Capital' : Operand {
			attribute operandName :> operandName = "Capital";
			attribute operandNetName :> operandNetName = "deliver capital";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
		}
		item 'Agricultural product' : Operand {
			attribute operandName :> operandName = "Agricultural product";
			attribute operandNetName :> operandNetName = "deliver ag product";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
		}
		item 'Manufactured product' : Operand {
			attribute operandName :> operandName = "Manufactured product";
			attribute operandNetName :> operandNetName = "deliver man product";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
		}
		item 'Construction product' : Operand {
			attribute operandName :> operandName = "Construction product";
			attribute operandNetName :> operandNetName = "deliver cons product";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
		}
	}
}