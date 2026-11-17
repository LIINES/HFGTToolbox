package Model {
	doc /* Matpower to SoS Reference Architecture Translator  */
	part def GenCase {
		attribute GenCase :> GenCase = "Electric-Generator";
		attribute bus :> bus = "idxBuffer";
		attribute Pg :> Pg = "powerReal";
		attribute Qg :> Qg = "powerImag";
		attribute Qmax :> Qmax = "powerImagMax";
		attribute Qmin :> Qmin = "powerImagMin";
		attribute Vg :> Vg = "voltageMagnitude";
		attribute mBase :> mBase = "basePower";
		attribute status :> status = "status";
		attribute Pmax :> Pmax = "powerRealMax";
		attribute Pmin :> Pmin = "powerRealMin";
		attribute Pc1 :> Pc1 = "powerRealCapability1";
		attribute Pc2 :> Pc2 = "powerRealCapability2";
		attribute Qc1min :> Qc1min = "powerImagMinCapability1";
		attribute Qc1max :> Qc1max = "powerImagMaxCapability1";
		attribute Qc2min :> Qc2min = "powerImagMinCapability2";
		attribute Qc2max :> Qc2max = "powerImagMaxCapability2";
		attribute ramp_agc :> ramp_agc = "rampRateRealAGC";
		attribute ramp_10 :> ramp_10 = "rampRateReal10Min";
		attribute ramp_30 :> ramp_30 = "rampRateReal30Min";
		attribute ramp_q :> ramp_q = "rampRateImag";
		attribute apf :> apf = "agcParticipationFraction";
		attribute cost_function :> cost_function = "costModel";
		attribute cost_startup_cost :> cost_startup_cost = "costStartup";
		attribute cost_shutdown_cost :> cost_shutdown_cost = "costShutdown";
		attribute cost_order :> cost_order = "numCostCoeffs";
		attribute cost_Coefficient1 :> cost_Coefficient1 = "costCoeff0";
		attribute cost_Coefficient2 :> cost_Coefficient2 = "costCoeff1";
		attribute cost_Coefficient3 :> cost_Coefficient3 = "costCoeff2";
	}
	part def BusCase {
		attribute BusCase :> BusCase = "Electric-Consumer";
		attribute bus_i :> bus_i = "idxBuffer";
		attribute type :> type = "nodeType";
		attribute Pd :> Pd = "powerReal";
		attribute Qd :> Qd = "powerImag";
		attribute Gs :> Gs = "gLoad";
		attribute Bs :> Bs = "bLoad";
		attribute area :> area = "nodeArea";
		attribute Vm :> Vm = "voltageMagnitude";
		attribute Va :> Va = "voltagePhase";
		attribute baseKV :> baseKV = "baseVoltage";
		attribute zone :> zone = "lossArea";
		attribute Vmax :> Vmax = "voltageMagnitudeMax";
		attribute Vmin :> Vmin = "voltageMagnitudeMin";
	}
	part def BranchCase {
		attribute BranchCase :> BranchCase = "Electric-Line";
		attribute fbus :> fbus = "origin";
		attribute tbus :> tbus = "destination";
		attribute r :> r = "rValue";
		attribute x :> x = "xValue";
		attribute b :> b = "bShunt";
		attribute rateA :> rateA = "powerRealMax";
		attribute rateB :> rateB = "powerRealMaxShort";
		attribute rateC :> rateC = "powerRealMaxEmergency";
		attribute ratio :> ratio = "tapRatio";
		attribute angle :> angle = "tapAngle";
		attribute status :> status = "status";
		attribute angmin :> angmin = "angMin";
		attribute angmax :> angmax = "angMax";
	}
}