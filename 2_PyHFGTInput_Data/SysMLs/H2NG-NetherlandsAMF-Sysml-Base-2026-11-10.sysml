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
	part 'H2NG-NetherlandsAMF' : LFES {
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
		attribute hasESN_Duration :> hasESN_Duration = "true";
		attribute hasESN_STF1 :> hasESN_STF1 = "true";
		attribute hasESN_STF2 :> hasESN_STF2 = "true";
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
		attribute hasProcessValues :> hasProcessValues = "true";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "H2NG-NetherlandsAMF";
		attribute optimizer :> optimizer = "Gurobi";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "H2NG System";
		attribute scenario :> scenario = "base";
		attribute simHorizon :> simHorizon = "21";
		attribute verboseMode :> verboseMode = "true";
		part 'Hydrogen Electrolysis Facility' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Hydrogen Electrolysis Facility";
			action 'electrolyze water to hydrogen and oxygen' : TransformProcess {
				attribute name :> name = "electrolyze water to hydrogen and oxygen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water,electric power";
				attribute outputOperand :> outputOperand = "hydrogen,oxygen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "8.936,40";
				attribute outputOperandWeight :> outputOperandWeight = "1,7.936";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1000";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "2";
			}
			action 'burn natural gas to generate electric power' : TransformProcess {
				attribute name :> name = "burn natural gas to generate electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas,oxygen";
				attribute outputOperand :> outputOperand = "electric power,CO2,heat loss,water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1,3.989";
				attribute outputOperandWeight :> outputOperandWeight = "6.897,2.743,29.1,2.246";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "145";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0.01";
				attribute duration :> duration = "1";
			}
			action 'import electric power' : TransformProcess {
				attribute name :> name = "import electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "electric power";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "10";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
				attribute value :> value = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			}
			action 'import water' : TransformProcess {
				attribute name :> name = "import water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export water' : TransformProcess {
				attribute name :> name = "export water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'import oxygen' : TransformProcess {
				attribute name :> name = "import oxygen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "oxygen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export oxygen' : TransformProcess {
				attribute name :> name = "export oxygen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "oxygen";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export CO2' : TransformProcess {
				attribute name :> name = "export CO2";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "CO2";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export heat loss' : TransformProcess {
				attribute name :> name = "export heat loss";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "heat loss";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'store hydrogen' : TransportProcess {
				attribute name :> name = "store hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "21000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Electrolysis Facility";
				attribute destination :> destination = "Hydrogen Electrolysis Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
			action 'store natural gas' : TransportProcess {
				attribute name :> name = "store natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Electrolysis Facility";
				attribute destination :> destination = "Hydrogen Electrolysis Facility";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Steam Methane Reformation Facility' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Steam Methane Reformation Facility";
			action 'reform steam and methane to hydrogen and CO2' : TransformProcess {
				attribute name :> name = "reform steam and methane to hydrogen and CO2";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water,natural gas,industrial heat";
				attribute outputOperand :> outputOperand = "hydrogen,CO2";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "4.468,1.989,19.4";
				attribute outputOperandWeight :> outputOperandWeight = "1,5.457";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1000";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "2";
			}
			action 'burn natural gas to generate industrial heat' : TransformProcess {
				attribute name :> name = "burn natural gas to generate industrial heat";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas,oxygen";
				attribute outputOperand :> outputOperand = "industrial heat,CO2,water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1,3.989";
				attribute outputOperandWeight :> outputOperandWeight = "52.6,2.743,2.246";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "100";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
			}
			action 'import water' : TransformProcess {
				attribute name :> name = "import water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export water' : TransformProcess {
				attribute name :> name = "export water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'import oxygen' : TransformProcess {
				attribute name :> name = "import oxygen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "oxygen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export CO2' : TransformProcess {
				attribute name :> name = "export CO2";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "CO2";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'store hydrogen' : TransportProcess {
				attribute name :> name = "store hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "21000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Steam Methane Reformation Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
			action 'store natural gas' : TransportProcess {
				attribute name :> name = "store natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Steam Methane Reformation Facility";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Ammonia Production Facility' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Ammonia Production Facility";
			action 'manufacture ammonia' : TransformProcess {
				attribute name :> name = "manufacture ammonia";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "2000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "100";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
				attribute value :> value = "0,0,0,0,126,126,126,126,126,126,126,126,126,126,126,126,126,126,126,0";
			}
			action 'store hydrogen' : TransportProcess {
				attribute name :> name = "store hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "21000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Ammonia Production Facility";
				attribute destination :> destination = "Ammonia Production Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen- and Natural Gas-fired Power Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "1";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Hydrogen- and Natural Gas-fired Power Plant";
			action 'burn hydrogen to generate electric power' : TransformProcess {
				attribute name :> name = "burn hydrogen to generate electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen,oxygen";
				attribute outputOperand :> outputOperand = "electric power,heat loss,water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1,7.936";
				attribute outputOperandWeight :> outputOperandWeight = "17.616,74.3,8.936";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "1000";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0.01";
				attribute duration :> duration = "1";
			}
			action 'burn natural gas to generate electric power' : TransformProcess {
				attribute name :> name = "burn natural gas to generate electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas,oxygen";
				attribute outputOperand :> outputOperand = "electric power,CO2,heat loss,water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1,3.989";
				attribute outputOperandWeight :> outputOperandWeight = "6.897,2.743,29.1,2.246";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "3000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "145";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0.01";
				attribute duration :> duration = "1";
			}
			action 'consume electric power' : TransformProcess {
				attribute name :> name = "consume electric power";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electric power";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
				attribute value :> value = "0,0,0,0,1435,1459,1312,1189,1402,1404,1363,1416,1479,1288,1281,1455,1480,1476,1275,0";
			}
			action 'import oxygen' : TransformProcess {
				attribute name :> name = "import oxygen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "oxygen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export water' : TransformProcess {
				attribute name :> name = "export water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export heat loss' : TransformProcess {
				attribute name :> name = "export heat loss";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "heat loss";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export CO2' : TransformProcess {
				attribute name :> name = "export CO2";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "CO2";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'store hydrogen' : TransportProcess {
				attribute name :> name = "store hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "21000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute refinement :> refinement = "hold hydrogen";
			}
			action 'store natural gas' : TransportProcess {
				attribute name :> name = "store natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Hydrogen- and Natural Gas-fired Steel Mill' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "3";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Hydrogen- and Natural Gas-fired Steel Mill";
			action 'burn hydrogen to generate industrial heat' : TransformProcess {
				attribute name :> name = "burn hydrogen to generate industrial heat";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen,oxygen";
				attribute outputOperand :> outputOperand = "industrial heat,water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1,7.936";
				attribute outputOperandWeight :> outputOperandWeight = "134.5,8.936";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "1000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "300";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
			}
			action 'burn natural gas to generate industrial heat' : TransformProcess {
				attribute name :> name = "burn natural gas to generate industrial heat";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas,oxygen";
				attribute outputOperand :> outputOperand = "industrial heat,CO2,water";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1,3.989";
				attribute outputOperandWeight :> outputOperandWeight = "52.6,2.743,2.246";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "15000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "100";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
			}
			action 'consume industrial heat' : TransformProcess {
				attribute name :> name = "consume industrial heat";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "industrial heat";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "35000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
				attribute value :> value = "0,0,0,0,35000,35000,35000,35000,35000,35000,35000,35000,35000,35000,35000,35000,35000,35000,35000,0";
			}
			action 'export water' : TransformProcess {
				attribute name :> name = "export water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "water";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "700000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'export CO2' : TransformProcess {
				attribute name :> name = "export CO2";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "CO2";
				attribute outputOperand :> outputOperand = "";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "30000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'import oxygen' : TransformProcess {
				attribute name :> name = "import oxygen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "oxygen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "55000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'store hydrogen' : TransportProcess {
				attribute name :> name = "store hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "21000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute refinement :> refinement = "hold hydrogen";
			}
			action 'store natural gas' : TransportProcess {
				attribute name :> name = "store natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Import Station' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "5";
			attribute gpsY :> gpsY = "5";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Natural Gas Import Station";
			action 'import natural Gas' : TransformProcess {
				attribute name :> name = "import natural Gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "130";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
		}
		part 'LNG Terminal' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "2";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "LNG Terminal";
			action 'regasify Natural Gas' : TransformProcess {
				attribute name :> name = "regasify Natural Gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "210";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
			action 'store natural gas' : TransportProcess {
				attribute name :> name = "store natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "LNG Terminal";
				attribute destination :> destination = "LNG Terminal";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Hydrogen Import Station' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "5";
			attribute gpsY :> gpsY = "4";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute transformationResourceName :> transformationResourceName = "Hydrogen Import Station";
			action 'import hydrogen' : TransformProcess {
				attribute name :> name = "import hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "3000";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "0";
			}
		}
		part 'Hydrogen Pipe Line Intersection' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "2";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute independentBufferName :> independentBufferName = "Hydrogen Pipe Line Intersection";
			action 'store hydrogen' : TransportProcess {
				attribute name :> name = "store hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "21000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Pipe Line Intersection";
				attribute destination :> destination = "Hydrogen Pipe Line Intersection";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Natural Gas Pipe Line Intersection' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "3";
			attribute varDomain :> varDomain = "real+,real+,real+,real+,real+,real+,real+,real+";
			attribute upperBound :> upperBound = "0,0,0,0,0,0,0,0";
			attribute independentBufferName :> independentBufferName = "Natural Gas Pipe Line Intersection";
			action 'store natural gas' : TransportProcess {
				attribute name :> name = "store natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "100000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.1";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Natural Gas Pipe Line Intersection";
				attribute destination :> destination = "Natural Gas Pipe Line Intersection";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Hydrogen Pipe Line 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 1";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Electrolysis Facility";
				attribute destination :> destination = "Steam Methane Reformation Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 2";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Electrolysis Facility";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 3";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 4";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "260";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 5";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute destination :> destination = "Ammonia Production Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 6";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "260";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Import Station";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 7";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Import Station";
				attribute destination :> destination = "Hydrogen Pipe Line Intersection";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 8";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Pipe Line Intersection";
				attribute destination :> destination = "Steam Methane Reformation Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Hydrogen Pipe Line 9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Hydrogen Pipe Line 9";
			action 'transport hydrogen' : TransportProcess {
				attribute name :> name = "transport hydrogen";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "hydrogen";
				attribute outputOperand :> outputOperand = "hydrogen";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen Pipe Line Intersection";
				attribute destination :> destination = "Ammonia Production Facility";
				attribute refinement :> refinement = "hold hydrogen";
			}
		}
		part 'Natural Gas Pipe Line 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 1";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute destination :> destination = "Hydrogen Electrolysis Facility";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 2";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Hydrogen Electrolysis Facility";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 3";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Power Plant";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 4";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Steam Methane Reformation Facility";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 5";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "15000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Natural Gas Import Station";
				attribute destination :> destination = "Hydrogen- and Natural Gas-fired Steel Mill";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 6";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Natural Gas Import Station";
				attribute destination :> destination = "Natural Gas Pipe Line Intersection";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 7";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "LNG Terminal";
				attribute destination :> destination = "Steam Methane Reformation Facility";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		part 'Natural Gas Pipe Line 8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Natural Gas Pipe Line 8";
			action 'transport natural gas' : TransportProcess {
				attribute name :> name = "transport natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas";
				attribute outputOperand :> outputOperand = "natural gas";
				attribute varDomain :> varDomain = "real+";
				attribute inputOperandWeight :> inputOperandWeight = "1";
				attribute outputOperandWeight :> outputOperandWeight = "1";
				attribute upperBoundFlowNeg :> upperBoundFlowNeg = "10000";
				attribute linearCostCoeffFlowNeg :> linearCostCoeffFlowNeg = "0.01";
				attribute quadCostCoeffFlowNeg :> quadCostCoeffFlowNeg = "0";
				attribute duration :> duration = "1";
				attribute origin :> origin = "Natural Gas Pipe Line Intersection";
				attribute destination :> destination = "Steam Methane Reformation Facility";
				attribute refinement :> refinement = "hold natural gas";
			}
		}
		item 'natural gas' : Operand {
			attribute operandName :> operandName = "natural gas";
			attribute operandNetName :> operandNetName = "natural gas";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'hydrogen' : Operand {
			attribute operandName :> operandName = "hydrogen";
			attribute operandNetName :> operandNetName = "deliver hydrogen";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'water' : Operand {
			attribute operandName :> operandName = "water";
			attribute operandNetName :> operandNetName = "deliver water";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'oxygen' : Operand {
			attribute operandName :> operandName = "oxygen";
			attribute operandNetName :> operandNetName = "oxygen";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'electric power' : Operand {
			attribute operandName :> operandName = "electric power";
			attribute operandNetName :> operandNetName = "deliver electric power";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'industrial heat' : Operand {
			attribute operandName :> operandName = "industrial heat";
			attribute operandNetName :> operandNetName = "industrial heat";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'CO2' : Operand {
			attribute operandName :> operandName = "CO2";
			attribute operandNetName :> operandNetName = "CO2";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
		item 'heat loss' : Operand {
			attribute operandName :> operandName = "heat loss";
			attribute operandNetName :> operandNetName = "deliver heat loss";
			attribute operandType :> operandType = "matter";
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
			attribute hasPlaceCost :> hasPlaceCost = "false";
		}
	}
}