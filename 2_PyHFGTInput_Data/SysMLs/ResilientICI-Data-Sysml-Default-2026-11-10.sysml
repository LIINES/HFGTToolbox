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
		attribute ARhoMethod;
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
	part 'ResilientICI-Data' : LFES {
		attribute ARhoMethod :> ARhoMethod = "default";
		attribute analysisMethod :> analysisMethod = "SoSResilience";
		attribute dataState :> dataState = "raw";
		attribute inputDataFormat :> inputDataFormat = "sysml";
		attribute name :> name = "ResilientICI-Data";
		attribute outputFileType :> outputFileType = "json";
		attribute refArchitecture :> refArchitecture = "HEWRA";
		attribute scenario :> scenario = "default";
		attribute verboseMode :> verboseMode = "false";
		attribute version :> version = "4.0";
		part 'Wastewater Treatment Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "Wastewater Treatment Plant";
			action 'treat wastewater' : TransformProcess {
				attribute name :> name = "treat wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,wastewater";
				attribute outputOperand :> outputOperand = "heat loss,natural gas,treated wastewater";
			}
		}
		part 'Industrial Facility' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Industrial Facility";
			action 'produce manufactured products' : TransformProcess {
				attribute name :> name = "produce manufactured products";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "raw materials,electricity,potable water";
				attribute outputOperand :> outputOperand = "manufactured products,heat loss,wastewater";
			}
		}
		part 'Natural Gas Power Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "Natural Gas Power Plant";
			action 'generate electricity from natural gas' : TransformProcess {
				attribute name :> name = "generate electricity from natural gas";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "natural gas,freshwater,seawater";
				attribute outputOperand :> outputOperand = "heat loss,carbon dioxide,process steam,water vapor loss,wastewater,electricity";
			}
		}
		part 'Thermal Desalination Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "Thermal Desalination Plant";
			action 'thermally desalinate seawater' : TransformProcess {
				attribute name :> name = "thermally desalinate seawater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "process steam,seawater";
				attribute outputOperand :> outputOperand = "potable water,wastewater,heat loss";
			}
		}
		part 'Membrane Desalination Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "1";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "Membrane Desalination Plant";
			action 'electrically desalinate seawater' : TransformProcess {
				attribute name :> name = "electrically desalinate seawater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "seawater,electricity";
				attribute outputOperand :> outputOperand = "potable water,wastewater,heat loss";
			}
		}
		part 'Residential Building A' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Residential Building A";
			action 'consume domestically' : TransformProcess {
				attribute name :> name = "consume domestically";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,potable water";
				attribute outputOperand :> outputOperand = "heat loss,wastewater";
			}
		}
		part 'Substation 1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "Substation 1";
			action 'transform electricity' : TransformProcess {
				attribute name :> name = "transform electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity,heat loss";
			}
		}
		part 'Commercial Building A' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Commercial Building A";
			action 'produce commercial products' : TransformProcess {
				attribute name :> name = "produce commercial products";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,potable water";
				attribute outputOperand :> outputOperand = "commercial products,heat loss,wastewater";
			}
		}
		part 'Commercial Building B' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "Commercial Building B";
			action 'produce commercial products' : TransformProcess {
				attribute name :> name = "produce commercial products";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,potable water";
				attribute outputOperand :> outputOperand = "commercial products,heat loss,wastewater";
			}
		}
		part 'Surface Water Treatment Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "3";
			attribute gpsY :> gpsY = "3";
			attribute transformationResourceName :> transformationResourceName = "Surface Water Treatment Plant";
			action 'extract and treat freshwater' : TransformProcess {
				attribute name :> name = "extract and treat freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,freshwater";
				attribute outputOperand :> outputOperand = "potable water,heat loss";
			}
		}
		part 'Residential Building B' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Residential Building B";
			action 'consume domestically' : TransformProcess {
				attribute name :> name = "consume domestically";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity,potable water";
				attribute outputOperand :> outputOperand = "heat loss,wastewater";
			}
		}
		part 'Substation 3' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "Substation 3";
			action 'transform electricity' : TransformProcess {
				attribute name :> name = "transform electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity,heat loss";
			}
		}
		part 'Agricultural Facility 1' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "5";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "Agricultural Facility 1";
			action 'produce agricultural products' : TransformProcess {
				attribute name :> name = "produce agricultural products";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "raw materials,electricity,freshwater";
				attribute outputOperand :> outputOperand = "agricultural products,heat loss,wastewater";
			}
		}
		part 'Agricultural Facility 2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "5";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Agricultural Facility 2";
			action 'produce agricultural products' : TransformProcess {
				attribute name :> name = "produce agricultural products";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "raw materials,electricity,freshwater";
				attribute outputOperand :> outputOperand = "agricultural products,heat loss,wastewater";
			}
		}
		part 'Substation 2' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "5";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "Substation 2";
			action 'transform electricity' : TransformProcess {
				attribute name :> name = "transform electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity,heat loss";
			}
		}
		part 'Pumped Hydro Storage' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "5";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "Pumped Hydro Storage";
			action 'generate electricity from freshwater' : TransformProcess {
				attribute name :> name = "generate electricity from freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater,electricity,heat loss";
			}
			action 'pump freshwater from electricity' : TransformProcess {
				attribute name :> name = "pump freshwater from electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater,electricity";
				attribute outputOperand :> outputOperand = "freshwater,heat loss";
			}
			action 'store freshwater' : TransportProcess {
				attribute name :> name = "store freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Pumped Hydro Storage";
				attribute destination :> destination = "Pumped Hydro Storage";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Wind Power Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "6";
			attribute gpsY :> gpsY = "0";
			attribute transformationResourceName :> transformationResourceName = "Wind Power Plant";
			action 'generate electricity from wind' : TransformProcess {
				attribute name :> name = "generate electricity from wind";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wind energy";
				attribute outputOperand :> outputOperand = "electricity,heat loss";
			}
		}
		part 'Battery' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "6";
			attribute gpsY :> gpsY = "1";
			attribute transformationResourceName :> transformationResourceName = "Battery";
			action 'store electricity' : TransformProcess {
				attribute name :> name = "store electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity,heat loss";
			}
		}
		part 'Solar Power Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "6";
			attribute gpsY :> gpsY = "2";
			attribute transformationResourceName :> transformationResourceName = "Solar Power Plant";
			action 'photovoltaically generate electricity from solar irradiance' : TransformProcess {
				attribute name :> name = "photovoltaically generate electricity from solar irradiance";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "solar irradiance";
				attribute outputOperand :> outputOperand = "electricity,heat loss";
			}
		}
		part 'Hydro Electric Power Plant' : TransformationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "6";
			attribute gpsY :> gpsY = "4";
			attribute transformationResourceName :> transformationResourceName = "Hydro Electric Power Plant";
			action 'generate electricity from freshwater' : TransformProcess {
				attribute name :> name = "generate electricity from freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "heat loss,electricity,freshwater";
			}
		}
		part 'Potable Water Tank' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "2";
			attribute gpsY :> gpsY = "3";
			attribute independentBufferName :> independentBufferName = "Potable Water Tank";
			action 'store potable water' : TransportProcess {
				attribute name :> name = "store potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Potable Water Tank";
				attribute destination :> destination = "Potable Water Tank";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Reservoir Lake B' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "4";
			attribute gpsY :> gpsY = "3";
			attribute independentBufferName :> independentBufferName = "Reservoir Lake B";
			action 'store freshwater' : TransportProcess {
				attribute name :> name = "store freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Reservoir Lake B";
				attribute destination :> destination = "Reservoir Lake B";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Reservoir Lake A' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "6";
			attribute gpsY :> gpsY = "5";
			attribute independentBufferName :> independentBufferName = "Reservoir Lake A";
			action 'store freshwater' : TransportProcess {
				attribute name :> name = "store freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Reservoir Lake A";
				attribute destination :> destination = "Reservoir Lake A";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Ocean' : IndependentBuffer {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute gpsX :> gpsX = "0";
			attribute gpsY :> gpsY = "3";
			attribute independentBufferName :> independentBufferName = "Ocean";
			action 'store seawater' : TransportProcess {
				attribute name :> name = "store seawater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "seawater";
				attribute outputOperand :> outputOperand = "seawater";
				attribute origin :> origin = "Ocean";
				attribute destination :> destination = "Ocean";
				attribute refinement :> refinement = "hold seawater";
			}
		}
		part 'Power Line 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 1";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Industrial Facility";
				attribute destination :> destination = "Wastewater Treatment Plant";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 2";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Industrial Facility";
				attribute destination :> destination = "Residential Building A";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 3";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Natural Gas Power Plant";
				attribute destination :> destination = "Substation 1";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 4";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Thermal Desalination Plant";
				attribute destination :> destination = "Substation 1";
				attribute refinement :> refinement = "hold electricity";
			}
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 1";
				attribute destination :> destination = "Thermal Desalination Plant";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 5";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Thermal Desalination Plant";
				attribute destination :> destination = "Membrane Desalination Plant";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 6";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Residential Building A";
				attribute destination :> destination = "Commercial Building A";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 7";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 1";
				attribute destination :> destination = "Potable Water Tank";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 8";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 1";
				attribute destination :> destination = "Industrial Facility";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 9";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Commercial Building A";
				attribute destination :> destination = "Residential Building B";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 10' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 10";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Commercial Building A";
				attribute destination :> destination = "Commercial Building B";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 11' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 11";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Commercial Building B";
				attribute destination :> destination = "Substation 2";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 12' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 12";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Commercial Building B";
				attribute destination :> destination = "Surface Water Treatment Plant";
				attribute refinement :> refinement = "hold electricity";
			}
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Surface Water Treatment Plant";
				attribute destination :> destination = "Commercial Building B";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 13' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 13";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Surface Water Treatment Plant";
				attribute destination :> destination = "Substation 3";
				attribute refinement :> refinement = "hold electricity";
			}
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 3";
				attribute destination :> destination = "Surface Water Treatment Plant";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 14' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 14";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Residential Building B";
				attribute destination :> destination = "Agricultural Facility 2";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 15' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 15";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 3";
				attribute destination :> destination = "Pumped Hydro Storage";
				attribute refinement :> refinement = "hold electricity";
			}
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Pumped Hydro Storage";
				attribute destination :> destination = "Substation 3";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 16' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 16";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 3";
				attribute destination :> destination = "Potable Water Tank";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 17' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 17";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Agricultural Facility 2";
				attribute destination :> destination = "Agricultural Facility 1";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 18' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 18";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 2";
				attribute destination :> destination = "Commercial Building A";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 19' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 19";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 2";
				attribute destination :> destination = "Residential Building B";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 20' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 20";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Substation 2";
				attribute destination :> destination = "Battery";
				attribute refinement :> refinement = "hold electricity";
			}
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Battery";
				attribute destination :> destination = "Substation 2";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 21' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 21";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Wind Power Plant";
				attribute destination :> destination = "Substation 2";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 22' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 22";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Solar Power Plant";
				attribute destination :> destination = "Substation 2";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Power Line 23' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Power Line 23";
			action 'transport electricity' : TransportProcess {
				attribute name :> name = "transport electricity";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "electricity";
				attribute outputOperand :> outputOperand = "electricity";
				attribute origin :> origin = "Hydro Electric Power Plant";
				attribute destination :> destination = "Substation 3";
				attribute refinement :> refinement = "hold electricity";
			}
		}
		part 'Seawater Pipe 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Seawater Pipe 1";
			action 'transport seawater' : TransportProcess {
				attribute name :> name = "transport seawater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "seawater";
				attribute outputOperand :> outputOperand = "seawater";
				attribute origin :> origin = "Ocean";
				attribute destination :> destination = "Membrane Desalination Plant";
				attribute refinement :> refinement = "hold seawater";
			}
		}
		part 'Seawater Pipe 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Seawater Pipe 2";
			action 'transport seawater' : TransportProcess {
				attribute name :> name = "transport seawater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "seawater";
				attribute outputOperand :> outputOperand = "seawater";
				attribute origin :> origin = "Ocean";
				attribute destination :> destination = "Thermal Desalination Plant";
				attribute refinement :> refinement = "hold seawater";
			}
		}
		part 'Seawater Pipe 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Seawater Pipe 3";
			action 'transport seawater' : TransportProcess {
				attribute name :> name = "transport seawater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "seawater";
				attribute outputOperand :> outputOperand = "seawater";
				attribute origin :> origin = "Ocean";
				attribute destination :> destination = "Natural Gas Power Plant";
				attribute refinement :> refinement = "hold seawater";
			}
		}
		part 'Freshwater Pipe 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Freshwater Pipe 1";
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Reservoir Lake A";
				attribute destination :> destination = "Hydro Electric Power Plant";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Freshwater Pipe 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Freshwater Pipe 2";
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Hydro Electric Power Plant";
				attribute destination :> destination = "Reservoir Lake B";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Freshwater Pipe 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Freshwater Pipe 3";
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Pumped Hydro Storage";
				attribute destination :> destination = "Reservoir Lake B";
				attribute refinement :> refinement = "hold freshwater";
			}
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Reservoir Lake B";
				attribute destination :> destination = "Pumped Hydro Storage";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Freshwater Pipe 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Freshwater Pipe 4";
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Agricultural Facility 2";
				attribute destination :> destination = "Agricultural Facility 1";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Freshwater Pipe 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Freshwater Pipe 5";
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Reservoir Lake B";
				attribute destination :> destination = "Agricultural Facility 2";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Freshwater Pipe 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Freshwater Pipe 6";
			action 'transport freshwater' : TransportProcess {
				attribute name :> name = "transport freshwater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "freshwater";
				attribute outputOperand :> outputOperand = "freshwater";
				attribute origin :> origin = "Reservoir Lake B";
				attribute destination :> destination = "Surface Water Treatment Plant";
				attribute refinement :> refinement = "hold freshwater";
			}
		}
		part 'Potable Water Pipe 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Potable Water Pipe 1";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Potable Water Tank";
				attribute destination :> destination = "Commercial Building B";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Potable Water Pipe 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Potable Water Pipe 2";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Commercial Building B";
				attribute destination :> destination = "Commercial Building A";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Potable Water Pipe 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Potable Water Pipe 3";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Commercial Building A";
				attribute destination :> destination = "Residential Building B";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Potable Water Pipe 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Potable Water Pipe 4";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Commercial Building A";
				attribute destination :> destination = "Residential Building A";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Potable Water Pipe 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Potable Water Pipe 5";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Residential Building A";
				attribute destination :> destination = "Industrial Facility";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Potable Water Pipe 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Potable Water Pipe 6";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water";
				attribute outputOperand :> outputOperand = "potable water";
				attribute origin :> origin = "Wastewater Treatment Plant";
				attribute destination :> destination = "Industrial Facility";
				attribute refinement :> refinement = "hold potable water";
			}
		}
		part 'Pumped Water Pipe 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Pumped Water Pipe 1";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water,electricity";
				attribute outputOperand :> outputOperand = "potable water,heat loss";
				attribute origin :> origin = "Membrane Desalination Plant";
				attribute destination :> destination = "Potable Water Tank";
				attribute refinement :> refinement = "pressurize potable water";
			}
		}
		part 'Pumped Water Pipe 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Pumped Water Pipe 2";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water,electricity";
				attribute outputOperand :> outputOperand = "potable water,heat loss";
				attribute origin :> origin = "Thermal Desalination Plant";
				attribute destination :> destination = "Potable Water Tank";
				attribute refinement :> refinement = "pressurize potable water";
			}
		}
		part 'Pumped Water Pipe 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Pumped Water Pipe 3";
			action 'transport potable water' : TransportProcess {
				attribute name :> name = "transport potable water";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "potable water,electricity";
				attribute outputOperand :> outputOperand = "potable water,heat loss";
				attribute origin :> origin = "Surface Water Treatment Plant";
				attribute destination :> destination = "Potable Water Tank";
				attribute refinement :> refinement = "pressurize potable water";
			}
		}
		part 'Treated Wastewater Pipe' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Treated Wastewater Pipe";
			action 'transport treated wastewater' : TransportProcess {
				attribute name :> name = "transport treated wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "treated wastewater";
				attribute outputOperand :> outputOperand = "treated wastewater";
				attribute origin :> origin = "Wastewater Treatment Plant";
				attribute destination :> destination = "Ocean";
				attribute refinement :> refinement = "hold treated wastewater";
			}
		}
		part 'Wastewater Pipe 1' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 1";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Wastewater Treatment Plant";
				attribute destination :> destination = "Agricultural Facility 1";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 2' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 2";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Natural Gas Power Plant";
				attribute destination :> destination = "Ocean";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 3' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 3";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Thermal Desalination Plant";
				attribute destination :> destination = "Ocean";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 4' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 4";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Membrane Desalination Plant";
				attribute destination :> destination = "Ocean";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 5' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 5";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Residential Building A";
				attribute destination :> destination = "Wastewater Treatment Plant";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 6' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 6";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Commercial Building A";
				attribute destination :> destination = "Residential Building A";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 7' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 7";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Commercial Building B";
				attribute destination :> destination = "Commercial Building A";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 8' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 8";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Surface Water Treatment Plant";
				attribute destination :> destination = "Commercial Building B";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 9' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 9";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Surface Water Treatment Plant";
				attribute destination :> destination = "Commercial Building B";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 10' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 10";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Residential Building B";
				attribute destination :> destination = "Wastewater Treatment Plant";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 11' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 11";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Agricultural Facility 1";
				attribute destination :> destination = "Residential Building B";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Wastewater Pipe 12' : TransportationResource {
			attribute decisionMaker :> decisionMaker = "Multi-Utility";
			attribute autonomous :> autonomous = "true";
			attribute transportationResourceName :> transportationResourceName = "Wastewater Pipe 12";
			action 'transport wastewater' : TransportProcess {
				attribute name :> name = "transport wastewater";
				attribute status :> status = "true";
				attribute inputOperand :> inputOperand = "wastewater";
				attribute outputOperand :> outputOperand = "wastewater";
				attribute origin :> origin = "Agricultural Facility 2";
				attribute destination :> destination = "Residential Building B";
				attribute refinement :> refinement = "hold wastewater";
			}
		}
		part 'Multi-Utility' : DecisionMaker {
			attribute name :> name = "Multi-Utility";
			attribute status :> status = "true";
			attribute peerRecipient :> peerRecipient = "";
		}
		item 'seawater' : Operand {
			attribute operandName :> operandName = "seawater";
			attribute operandNetName :> operandNetName = "regulate seawater";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'seawater' : OperandPlace {
				attribute name :> name = "seawater";
				attribute placeType :> placeType = "source";
			}
			part 'consume seawater by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "consume seawater by electricity generation from natural gas";
				attribute preset :> preset = "seawater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume seawater by thermal desalination' : OperandTransition {
				attribute name :> name = "consume seawater by thermal desalination";
				attribute preset :> preset = "seawater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "thermally desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume seawater by electrical desalination' : OperandTransition {
				attribute name :> name = "consume seawater by electrical desalination";
				attribute preset :> preset = "seawater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "electrically desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain seawater' : OperandTransition {
				attribute name :> name = "maintain seawater";
				attribute preset :> preset = "seawater";
				attribute postset :> postset = "seawater";
				attribute processLinkName :> processLinkName = "transport seawater";
				attribute processLinkRef :> processLinkRef = "hold seawater";
			}
		}
		item 'freshwater' : Operand {
			attribute operandName :> operandName = "freshwater";
			attribute operandNetName :> operandNetName = "regulate freshwater";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'freshwater' : OperandPlace {
				attribute name :> name = "freshwater";
				attribute placeType :> placeType = "source";
			}
			part 'consume freshwater by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "consume freshwater by electricity generation from natural gas";
				attribute preset :> preset = "freshwater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume freshwater by freshwater treatment' : OperandTransition {
				attribute name :> name = "consume freshwater by freshwater treatment";
				attribute preset :> preset = "freshwater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "extract and treat freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume freshwater by agricultural production' : OperandTransition {
				attribute name :> name = "consume freshwater by agricultural production";
				attribute preset :> preset = "freshwater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce agricultural products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain freshwater by electricity generation from freshwater' : OperandTransition {
				attribute name :> name = "maintain freshwater by electricity generation from freshwater";
				attribute preset :> preset = "freshwater";
				attribute postset :> postset = "freshwater";
				attribute processLinkName :> processLinkName = "generate electricity from freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain freshwater by freshwater pumping' : OperandTransition {
				attribute name :> name = "maintain freshwater by freshwater pumping";
				attribute preset :> preset = "freshwater";
				attribute postset :> postset = "freshwater";
				attribute processLinkName :> processLinkName = "pump freshwater from electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain freshwater by transportation' : OperandTransition {
				attribute name :> name = "maintain freshwater by transportation";
				attribute preset :> preset = "freshwater";
				attribute postset :> postset = "freshwater";
				attribute processLinkName :> processLinkName = "transport freshwater";
				attribute processLinkRef :> processLinkRef = "hold freshwater";
			}
		}
		item 'potable water' : Operand {
			attribute operandName :> operandName = "potable water";
			attribute operandNetName :> operandNetName = "regulate potable water";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'potable water' : OperandPlace {
				attribute name :> name = "potable water";
				attribute placeType :> placeType = "internal";
			}
			part 'produce potable water by wastewater treatment' : OperandTransition {
				attribute name :> name = "produce potable water by wastewater treatment";
				attribute preset :> preset = "";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "treat wastewater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume potable water by industrial production' : OperandTransition {
				attribute name :> name = "consume potable water by industrial production";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce manufactured products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce potable water by thermal desalination' : OperandTransition {
				attribute name :> name = "produce potable water by thermal desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "thermally desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce potable water by electrical desalination' : OperandTransition {
				attribute name :> name = "produce potable water by electrical desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "electrically desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume potable water by domestic consumption' : OperandTransition {
				attribute name :> name = "consume potable water by domestic consumption";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "consume domestically";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume potable water by commercial production' : OperandTransition {
				attribute name :> name = "consume potable water by commercial production";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce commercial products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce potable water by freshwater treatment' : OperandTransition {
				attribute name :> name = "produce potable water by freshwater treatment";
				attribute preset :> preset = "";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "extract and treat freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain potable water' : OperandTransition {
				attribute name :> name = "maintain potable water";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "transport potable water";
				attribute processLinkRef :> processLinkRef = "hold potable water";
			}
			part 'pressurize potable water' : OperandTransition {
				attribute name :> name = "pressurize potable water";
				attribute preset :> preset = "potable water";
				attribute postset :> postset = "potable water";
				attribute processLinkName :> processLinkName = "transport potable water";
				attribute processLinkRef :> processLinkRef = "pressurize potable water";
			}
		}
		item 'wastewater' : Operand {
			attribute operandName :> operandName = "wastewater";
			attribute operandNetName :> operandNetName = "regulate wastewater";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'wastewater' : OperandPlace {
				attribute name :> name = "wastewater";
				attribute placeType :> placeType = "internal";
			}
			part 'treat wastewater' : OperandTransition {
				attribute name :> name = "treat wastewater";
				attribute preset :> preset = "wastewater";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "treat wastewater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by industrial production' : OperandTransition {
				attribute name :> name = "produce wastewater by industrial production";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "produce manufactured products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "produce wastewater by electricity generation from natural gas";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by thermal desalination' : OperandTransition {
				attribute name :> name = "produce wastewater by thermal desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "thermally desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by electrical desalination' : OperandTransition {
				attribute name :> name = "produce wastewater by electrical desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "electrically desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by domestic consumption' : OperandTransition {
				attribute name :> name = "produce wastewater by domestic consumption";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "consume domestically";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by commercial production' : OperandTransition {
				attribute name :> name = "produce wastewater by commercial production";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "produce commercial products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce wastewater by agricultural production' : OperandTransition {
				attribute name :> name = "produce wastewater by agricultural production";
				attribute preset :> preset = "";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "produce agricultural products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain wastewater' : OperandTransition {
				attribute name :> name = "maintain wastewater";
				attribute preset :> preset = "wastewater";
				attribute postset :> postset = "wastewater";
				attribute processLinkName :> processLinkName = "transport wastewater";
				attribute processLinkRef :> processLinkRef = "hold wastewater";
			}
		}
		item 'treated wastewater' : Operand {
			attribute operandName :> operandName = "treated wastewater";
			attribute operandNetName :> operandNetName = "regulate treated wastewater";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'treated wastewater' : OperandPlace {
				attribute name :> name = "treated wastewater";
				attribute placeType :> placeType = "must produce";
			}
			part 'produce treated wastewater by wastewater treatment' : OperandTransition {
				attribute name :> name = "produce treated wastewater by wastewater treatment";
				attribute preset :> preset = "";
				attribute postset :> postset = "treated wastewater";
				attribute processLinkName :> processLinkName = "treat wastewater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain treated wastewater' : OperandTransition {
				attribute name :> name = "maintain treated wastewater";
				attribute preset :> preset = "treated wastewater";
				attribute postset :> postset = "treated wastewater";
				attribute processLinkName :> processLinkName = "transport treated wastewater";
				attribute processLinkRef :> processLinkRef = "hold treated wastewater";
			}
		}
		item 'solar irradiance' : Operand {
			attribute operandName :> operandName = "solar irradiance";
			attribute operandNetName :> operandNetName = "provide solar irradiance";
			attribute operandType :> operandType = "energy";
			attribute status :> status = "true";
			part 'solar irradiance' : OperandPlace {
				attribute name :> name = "solar irradiance";
				attribute placeType :> placeType = "source";
			}
			part 'consume solar irradiance' : OperandTransition {
				attribute name :> name = "consume solar irradiance";
				attribute preset :> preset = "solar irradiance";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "photovoltaically generate electricity from solar irradiance";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'wind energy' : Operand {
			attribute operandName :> operandName = "wind energy";
			attribute operandNetName :> operandNetName = "provide wind energy";
			attribute operandType :> operandType = "energy";
			attribute status :> status = "true";
			part 'wind energy' : OperandPlace {
				attribute name :> name = "wind energy";
				attribute placeType :> placeType = "source";
			}
			part 'consume wind energy' : OperandTransition {
				attribute name :> name = "consume wind energy";
				attribute preset :> preset = "wind energy";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "generate electricity from wind";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'natural gas' : Operand {
			attribute operandName :> operandName = "natural gas";
			attribute operandNetName :> operandNetName = "deliver natural gas";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'natural gas' : OperandPlace {
				attribute name :> name = "natural gas";
				attribute placeType :> placeType = "internal";
			}
			part 'produce natural gas by wastewater treatment' : OperandTransition {
				attribute name :> name = "produce natural gas by wastewater treatment";
				attribute preset :> preset = "";
				attribute postset :> postset = "natural gas";
				attribute processLinkName :> processLinkName = "treat wastewater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume natural gas by electricity generation' : OperandTransition {
				attribute name :> name = "consume natural gas by electricity generation";
				attribute preset :> preset = "natural gas";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'electricity' : Operand {
			attribute operandName :> operandName = "electricity";
			attribute operandNetName :> operandNetName = "deliver electricity";
			attribute operandType :> operandType = "energy";
			attribute status :> status = "true";
			part 'electricity' : OperandPlace {
				attribute name :> name = "electricity";
				attribute placeType :> placeType = "internal";
			}
			part 'consume electricity by wastewater treatment' : OperandTransition {
				attribute name :> name = "consume electricity by wastewater treatment";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "treat wastewater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by industrial production ' : OperandTransition {
				attribute name :> name = "consume electricity by industrial production ";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce manufactured products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce electricity by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "produce electricity by electricity generation from natural gas";
				attribute preset :> preset = "";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by electrical desalination' : OperandTransition {
				attribute name :> name = "consume electricity by electrical desalination";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "electrically desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by domestic consumption' : OperandTransition {
				attribute name :> name = "consume electricity by domestic consumption";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "consume domestically";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain electricity by transformation' : OperandTransition {
				attribute name :> name = "maintain electricity by transformation";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "transform electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by commercial production' : OperandTransition {
				attribute name :> name = "consume electricity by commercial production";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce commercial products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by freshwater treatment' : OperandTransition {
				attribute name :> name = "consume electricity by freshwater treatment";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "extract and treat freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by agricultural production' : OperandTransition {
				attribute name :> name = "consume electricity by agricultural production";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce agricultural products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce electricity by electricity generation from freshwater' : OperandTransition {
				attribute name :> name = "produce electricity by electricity generation from freshwater";
				attribute preset :> preset = "";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "generate electricity from freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume electricity by freshwater pumping' : OperandTransition {
				attribute name :> name = "consume electricity by freshwater pumping";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "pump freshwater from electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce electricity by electricity generation from wind' : OperandTransition {
				attribute name :> name = "produce electricity by electricity generation from wind";
				attribute preset :> preset = "";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "generate electricity from wind";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain electricity by storage' : OperandTransition {
				attribute name :> name = "maintain electricity by storage";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "store electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce electricity by electricity generation from solar' : OperandTransition {
				attribute name :> name = "produce electricity by electricity generation from solar";
				attribute preset :> preset = "";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "photovoltaically generate electricity from solar irradiance";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'maintain electricity by transportation' : OperandTransition {
				attribute name :> name = "maintain electricity by transportation";
				attribute preset :> preset = "electricity";
				attribute postset :> postset = "electricity";
				attribute processLinkName :> processLinkName = "transport electricity";
				attribute processLinkRef :> processLinkRef = "hold electricity";
			}
		}
		item 'raw materials' : Operand {
			attribute operandName :> operandName = "raw materials";
			attribute operandNetName :> operandNetName = "provide raw materials";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'raw materials' : OperandPlace {
				attribute name :> name = "raw materials";
				attribute placeType :> placeType = "source";
			}
			part 'consume raw materials by industrial production' : OperandTransition {
				attribute name :> name = "consume raw materials by industrial production";
				attribute preset :> preset = "raw materials";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce manufactured products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume raw materials by agricultural production' : OperandTransition {
				attribute name :> name = "consume raw materials by agricultural production";
				attribute preset :> preset = "raw materials";
				attribute postset :> postset = "";
				attribute processLinkName :> processLinkName = "produce agricultural products";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'agricultural products' : Operand {
			attribute operandName :> operandName = "agricultural products";
			attribute operandNetName :> operandNetName = "deliver agricultural products";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'agricultural products' : OperandPlace {
				attribute name :> name = "agricultural products";
				attribute placeType :> placeType = "must produce";
			}
			part 'produce agricultural products' : OperandTransition {
				attribute name :> name = "produce agricultural products";
				attribute preset :> preset = "";
				attribute postset :> postset = "agricultural products";
				attribute processLinkName :> processLinkName = "produce agricultural products";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'commercial products' : Operand {
			attribute operandName :> operandName = "commercial products";
			attribute operandNetName :> operandNetName = "deliver commercial products";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'commercial products' : OperandPlace {
				attribute name :> name = "commercial products";
				attribute placeType :> placeType = "must produce";
			}
			part 'produce commercial products' : OperandTransition {
				attribute name :> name = "produce commercial products";
				attribute preset :> preset = "";
				attribute postset :> postset = "commercial products";
				attribute processLinkName :> processLinkName = "produce commercial products";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'manufactured products' : Operand {
			attribute operandName :> operandName = "manufactured products";
			attribute operandNetName :> operandNetName = "deliver manufactured products";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'manufactured products' : OperandPlace {
				attribute name :> name = "manufactured products";
				attribute placeType :> placeType = "must produce";
			}
			part 'produce manufactured products' : OperandTransition {
				attribute name :> name = "produce manufactured products";
				attribute preset :> preset = "";
				attribute postset :> postset = "manufactured products";
				attribute processLinkName :> processLinkName = "produce manufactured products";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'water vapor loss' : Operand {
			attribute operandName :> operandName = "water vapor loss";
			attribute operandNetName :> operandNetName = "accept water vapor loss";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'water vapor loss' : OperandPlace {
				attribute name :> name = "water vapor loss";
				attribute placeType :> placeType = "sink";
			}
			part 'produce water vapor loss by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "produce water vapor loss by electricity generation from natural gas";
				attribute preset :> preset = "";
				attribute postset :> postset = "water vapor loss";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'process steam' : Operand {
			attribute operandName :> operandName = "process steam";
			attribute operandNetName :> operandNetName = "deliver process steam";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'process steam' : OperandPlace {
				attribute name :> name = "process steam";
				attribute placeType :> placeType = "internal";
			}
			part 'produce process steam from electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "produce process steam from electricity generation from natural gas";
				attribute preset :> preset = "";
				attribute postset :> postset = "process steam";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'consume process steam by thermal desalination' : OperandTransition {
				attribute name :> name = "consume process steam by thermal desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "process steam";
				attribute processLinkName :> processLinkName = "thermally desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'heat loss' : Operand {
			attribute operandName :> operandName = "heat loss";
			attribute operandNetName :> operandNetName = "accept heat loss";
			attribute operandType :> operandType = "energy";
			attribute status :> status = "true";
			part 'heat loss' : OperandPlace {
				attribute name :> name = "heat loss";
				attribute placeType :> placeType = "sink";
			}
			part 'produce heat loss by wastewater treatment' : OperandTransition {
				attribute name :> name = "produce heat loss by wastewater treatment";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "treat wastewater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by industrial production' : OperandTransition {
				attribute name :> name = "produce heat loss by industrial production";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "produce manufactured products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "produce heat loss by electricity generation from natural gas";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by thermal desalination' : OperandTransition {
				attribute name :> name = "produce heat loss by thermal desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "thermally desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electrical desalination' : OperandTransition {
				attribute name :> name = "produce heat loss by electrical desalination";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "electrically desalinate seawater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by domestic consumption' : OperandTransition {
				attribute name :> name = "produce heat loss by domestic consumption";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "consume domestically";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electrical transformation' : OperandTransition {
				attribute name :> name = "produce heat loss by electrical transformation";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "transform electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by commercial production' : OperandTransition {
				attribute name :> name = "produce heat loss by commercial production";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "produce commercial products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by freshwater treatment' : OperandTransition {
				attribute name :> name = "produce heat loss by freshwater treatment";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "extract and treat freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by agricultural production' : OperandTransition {
				attribute name :> name = "produce heat loss by agricultural production";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "produce agricultural products";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electrical generation from freshwater' : OperandTransition {
				attribute name :> name = "produce heat loss by electrical generation from freshwater";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "generate electricity from freshwater";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by freshwater pumping' : OperandTransition {
				attribute name :> name = "produce heat loss by freshwater pumping";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "pump freshwater from electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electricity generation from wind' : OperandTransition {
				attribute name :> name = "produce heat loss by electricity generation from wind";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "generate electricity from wind";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electricity storage' : OperandTransition {
				attribute name :> name = "produce heat loss by electricity storage";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "store electricity";
				attribute processLinkRef :> processLinkRef = "";
			}
			part 'produce heat loss by electricity generation from solar' : OperandTransition {
				attribute name :> name = "produce heat loss by electricity generation from solar";
				attribute preset :> preset = "";
				attribute postset :> postset = "heat loss";
				attribute processLinkName :> processLinkName = "photovoltaically generate electricity from solar irradiance";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
		item 'carbon dioxide' : Operand {
			attribute operandName :> operandName = "carbon dioxide";
			attribute operandNetName :> operandNetName = "accumuluate carbon dioxide";
			attribute operandType :> operandType = "matter";
			attribute status :> status = "true";
			part 'carbon dioxide' : OperandPlace {
				attribute name :> name = "carbon dioxide";
				attribute placeType :> placeType = "sink";
			}
			part 'produce carbon dioxide by electricity generation from natural gas' : OperandTransition {
				attribute name :> name = "produce carbon dioxide by electricity generation from natural gas";
				attribute preset :> preset = "";
				attribute postset :> postset = "carbon dioxide";
				attribute processLinkName :> processLinkName = "generate electricity from natural gas";
				attribute processLinkRef :> processLinkRef = "";
			}
		}
	}
}