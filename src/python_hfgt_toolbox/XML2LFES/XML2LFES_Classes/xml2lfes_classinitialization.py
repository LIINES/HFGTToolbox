"""
Copyright 2020 LIINES
@company: Thayer School of Engineering at Dartmouth
@lab: LIINES Lab
@Modified: 01/28/2022

"""

class Machines():
    def __init__(self):
        self.controller = []
        self.gpsX = []
        self.gpsY = []
        self.name = []
        self.methodsxForm = []
        self.methodsxPort = []
        self.idxMachine = []
        self.idxResource = []
        self.autonomous = []
    def __repr__(self):
        output = self.__dict__
        for k1 in range(len(self.methodsxForm)):
            output['methodsxForm'][k1] = self.methodsxForm[k1].__repr__()
        for k2 in range(len(self.methodsxPort)):
            output['methodsxPort'][k2] = self.methodsxPort[k2].__repr__()
        return output


class IndBuffers():
    def __init__(self):
        self.controller = []
        self.gpsX = []
        self.gpsY = []
        self.name = []
        self.methodsxPort = []
        self.idxBuffers = []
        self.idxResource = []
        self.autonomous = []
    def __repr__(self):
        output = self.__dict__
        for k2 in range(len(self.methodsxPort)):
            output['methodsxPort'][k2] = self.methodsxPort[k2].__repr__()
        return output


class Transporters():
    def __init__(self):
        self.controller = []
        self.names = []
        self.methodsxPort = []
        self.idxTransporters = []
        self.idxResource = []
        self.autonomous = []
    def __repr__(self):
        output = self.__dict__
        for k2 in range(len(self.methodsxPort)):
            output['methodsxPort'][k2] = self.methodsxPort[k2].__repr__()
        return output


class Controllers():
    def __init__(self):
        self.status = []
        self.name = []
        self.peerRecipients = []
        self.methodsxCtrl = []
    def __repr__(self):
        output = self.__dict__
        for k1 in range(len(self.peerRecipients)):
            output['peerRecipients'][k1] = self.peerRecipients[k1].__repr__()
        for k2 in range(len(self.methodsxCtrl)):
            output['methodsxCtrl'][k2] = self.methodsxCtrl[k2].__repr__()
        return output


class Services():
    def __init__(self):
        self.status = []
        self.names = []
        self.servicePlaces = []
        self.serviceTransitions = []
        self.serviceNets = []
        self.MLpos = []
        self.MLneg = []
        self.dualAdjacency = []
        self.RawLambda = []
        self.RawLambda_neg = []
        self.RawLambda_pos = []
        self.Lambda = []
        self.RawxFormLambda = []
        self.RawxFormLambda_pos = []
        self.RawxFormLambda_neg = []
        self.xFormLambda = []
        self.xPortLambda = []
        self.xPortLambda_neg = []
        self.xPortLambda_pos = []
        self.Mneg = []
        self.Mpos = []
    def __repr__(self):
        output = self.__dict__
        for k1 in range(len(self.servicePlaces)):
            output['servicePlaces'][k1] = self.servicePlaces[k1].__repr__()
        for k2 in range(len(self.serviceTransitions)):
            output['serviceTransitions'][k2] = self.serviceTransitions[k2].__repr__()
        for k3 in range(len(self.serviceNets)):
            output['serviceNets'][k3] = self.serviceNets[k3].__repr__()
        for k4 in range(len(self.dualAdjacency)):
            output['dualAdjacency'][k4] = self.dualAdjacency[k4].__dict__
            output['dualAdjacency'][k4]['indices'] = output['dualAdjacency'][k4]['indices'].tolist()
            output['dualAdjacency'][k4]['indptr'] = output['dualAdjacency'][k4]['indptr'].tolist()
            output['dualAdjacency'][k4]['data'] = output['dualAdjacency'][k4]['data'].tolist()
        for k5 in range(len(self.Mneg)):
            output['Mneg'][k5] = self.Mneg[k5].__dict__
            output['Mneg'][k5]['indices'] = output['Mneg'][k5]['indices'].tolist()
            output['Mneg'][k5]['indptr'] = output['Mneg'][k5]['indptr'].tolist()
            output['Mneg'][k5]['data'] = output['Mneg'][k5]['data'].tolist()
        for k6 in range(len(self.Mpos)):
            output['Mpos'][k6] = self.Mpos[k6].__dict__
            output['Mpos'][k6]['indices'] = output['Mpos'][k6]['indices'].tolist()
            output['Mpos'][k6]['indptr'] = output['Mpos'][k6]['indptr'].tolist()
            output['Mpos'][k6]['data'] = output['Mpos'][k6]['data'].tolist()
        for k7 in range(len(self.RawLambda)):
            output['RawLambda'][k7] = self.RawLambda[k7].tolist()
            output['RawLambda_neg'][k7] = self.RawLambda_neg[k7].tolist()
            output['RawLambda_pos'][k7] = self.RawLambda_pos[k7].tolist()
            output['Lambda'][k7] = self.Lambda[k7].tolist()
            output['RawxFormLambda'][k7] = self.RawxFormLambda[k7].tolist()
            output['RawxFormLambda_pos'][k7] = self.RawxFormLambda_pos[k7].tolist()
            output['RawxFormLambda_neg'][k7] = self.RawxFormLambda_neg[k7].tolist()
            output['xFormLambda'][k7] = self.xFormLambda[k7].tolist()
            output['xPortLambda'][k7] = self.xPortLambda[k7].tolist()
            output['xPortLambda_neg'][k7] = self.xPortLambda_neg[k7].tolist()
            output['xPortLambda_pos'][k7] = self.xPortLambda_pos[k7].tolist()


        return output

        
class servicePlace():
    def __init__(self):
        self.name = []
    def __repr__(self):
        output = self.__dict__
        return output


class serviceTransition():
    def __init__(self):
        self.name = []
        self.preset = []
        self.postset = []
        self.methodLinkName = []
        self.methodLinkRef = []
        self.methodLinkIdx = []
    def __repr__(self):
        output = self.__dict__
        return output


class serviceNet():
    def __init__(self):
        self.name = []
    def __repr__(self):
        output = self.__dict__
        return output


class Abstractions():
    def __init__(self):
        self.methodsxPort = methodxPort()
        self.methodsxForm = methodxForm()
        self.methodPair = methodPair()
    def __repr__(self):
        output = self.__dict__
        output['methodsxForm'] = self.methodsxForm.__repr__()
        output['methodsxPort'] = self.methodsxPort.__repr__()
        output['methodPair'] = self.methodPair.__repr__()
        return output


class Resources():
    def __init__(self):
        self.names = []
        self.idx = []
    def __repr__(self):
        output = self.__dict__
        return output


class methodxForm():
    def __init__(self):
        self.name = []
        self.operand = []
        self.output = []
        self.status = []
        self.idxForm = []
    def __repr__(self):
        output = self.__dict__
        return output


class methodxPort():
    def __init__(self):
        self.dest = []
        self.name = []
        self.operand = []
        self.origin = []
        self.output = []
        self.ref = []
        self.status = []
        self.nameref = []
        self.statusref = []
        self.idxOrigin = []
        self.idxDest = []
        self.idxHold = []
        self.idxPort = []
        self.idxPortRef = []
    def __repr__(self):
        output = self.__dict__
        return output


class methodxCtrl():
    def __init__(self):
        self.name = []
        self.operand = []
        self.output = []
        self.status = []
        self.ref = []
    def __repr__(self):
        output = self.__dict__
        return output


class methodPair():
    def __init__(self):
        self.name1 = []
        self.name2 = []
        self.ref1 = []
        self.ref2 = []
        self.idxProc1 = []
        self.idxProc2 = []
    def __repr__(self):
        output = self.__dict__
        output['idxProc1'] = list(map(str,self.idxProc1))
        output['idxProc2'] = list(map(str,self.idxProc2))
        return output


class peerRecipient():
    def __init__(self):
        self.name = []
    def __repr__(self):
        output = self.__dict__
        return output


class PetriNetwork():
    def __init__(self, *args):
        print('I am entering PetriNetwork.py')
        if args and len(args) == 1:
            self.importPetriNetwork(args[0])
        else:
            print('Creating empty PetriNetwork')
            self.name = 'myPetriNetwork'
            self.place = Place()
            self.transition = Transition()
            self.arc = Arc()
            self.token = 0
            self.state = 0
        print('I am exiting PetriNetwork.py')
    def importPetriNetwork(self, myLFES):
        self.name = myLFES.name
        self.place = Place(myLFES)
        self.transition = Transition(myLFES)
        self.arc = Arc(myLFES)
        self.state = 0
    def __repr__(self):
        output = self.__dict__
        output['place'] = self.place.__repr__()
        output['transition'] = self.transition.__repr__()
        output['arc'] = self.arc.__repr__()
        return output


class Place():
    def __init__(self, *args):
        print('I am entering Place.py')
        self.name = []
        self.index = []
        self.gpsX = []
        self.gpsY = []
        self.Q_b_calc = []
        self.Q_b_draw = []
        self.diameter = 1
        if args and len(args) == 1:
            self.importPlace(args[0])
        print('I am exiting Place.py')
    def importPlace(self, myLFES):
        pass
    def __repr__(self):
        output = self.__dict__
        return output


class Transition():
    def __init__(self, *args):
        print('I am entering Transition.py')
        self.name = []
        self.index = [];
        self.gpsX = [];
        self.gpsY = [];
        self.origin = []
        self.dest = []
        self.idxDOFS = []
        self.Q_t_calc = []
        self.Q_t_draw = []
        self.width = 1
        self.height = 1;
        if args and len(args) == 1:
            self.importTransition(args[0])
        print('I am exiting Transition.py')
    def importTransition(self, myLFES):
        pass
    def __repr__(self):
        output = self.__dict__
        return output


class Arc():
    def __init__(self, *args):
        print('I am entering Arc.py')
        self.arcPTFrom = []
        self.arcPTTo = []
        self.arcPTidx = []
        self.arcTPFrom = []
        self.arcTPTo = []
        self.arcTPidx = []
        if args and len(args) == 1:
            self.importArc(args[0])
        print('I am exiting Arc.py')
    def importArc(self, myPetriNetwork):
        if myPetriNetwork.transition.origin:
            for t1 in range(len(myPetriNetwork.transition.index)):
                for o1 in range(len(myPetriNetwork.transition.origin[t1])):
                    if not myPetriNetwork.transition.origin[t1][o1] == None:
                        self.arcPTidx.append(
                            [myPetriNetwork.transition.origin[t1][o1], myPetriNetwork.transition.index[t1]])
                        if myPetriNetwork.place.gpsX:
                            self.arcPTFrom.append([myPetriNetwork.place.gpsX[self.arcPTidx[-1][0]],
                                                   myPetriNetwork.place.gpsY[self.arcPTidx[-1][1]]])
                            self.arcPTTo.append(
                                [myPetriNetwork.transition.gpsX[t1], myPetriNetwork.transition.gpsY[t1]])
                for d1 in range(len(myPetriNetwork.transition.dest[t1])):
                    if not myPetriNetwork.transition.dest[t1][d1] == None:
                        self.arcTPidx.append(
                            [myPetriNetwork.transition.index[t1], myPetriNetwork.transition.dest[t1][d1]])
                        if myPetriNetwork.place.gpsX:
                            self.arcTPFrom.append(
                                [myPetriNetwork.transition.gpsX[t1], myPetriNetwork.transition.gpsY[t1]])
                            self.arcTPTo.append([myPetriNetwork.place.gpsX[self.arcTPidx[-1][0]],
                                                 myPetriNetwork.place.gpsY[self.arcTPidx[-1][1]]])
    def __repr__(self):
        output = self.__dict__
        return output


class LFES:
    '''Represents all of the components in the HFGT toolbox LFES structure'''

    def __init__(self):
        self.dataState = ''
        self.name = ''
        self.type = ''
        self.diameter = ''
        self.machines = Machines()
        self.indBuffers = IndBuffers()
        self.transporters = Transporters()
        self.services = Services()
        self.abstract = Abstractions()
        self.resources = Resources()
        self.controllers = Controllers()
        self.setTransformProcess = []
        self.setTransportProcess = []
        self.setHoldingProcess = []
        self.setTransportRefProcess = []
        self.setControlProcess = []
        self.setOperands = []
        self.numTransformProcess = 0
        self.numTransportProcess = 0
        self.numHoldingProcess = 0
        self.numTransportRefProcess = 0
        self.numProcesses = 0
        self.numControlProcess = 0
        self.numOperands = 0
        self.numMachines = 0
        self.numIndBuffers = 0
        self.numTransporters = 0
        self.numBuffers = 0
        self.numResources = 0
        self.numControllers = 0
        self.numServices = 0

        self.JM = 0
        self.JH = 0
        self.JHref = 0
        self.JS = 0
        self.JHT = 0
        self.JHrefT = 0
        self.KM = 0
        self.KH = 0
        self.KHref = 0
        self.KS = 0
        self.KHT = 0
        self.KHrefT = 0
        self.AM = 0
        self.AH = 0
        self.AHref = 0
        self.AS = 0
        self.AHT = 0
        self.AHrefT = 0
        self.CAM = 0
        self.CADM = 0
        self.CPRAM = 0
        self.CPPAM = 0
        self.SAMproj = 0
        self.Lambda = 0
        self.xFormLambda = 0
        self.xPortLambda = 0

        self.DOFM = 0
        self.DOFH = 0
        self.DOFHref = 0
        self.DOFS = 0
        self.DOFR = 0
        self.DOFC = 0
        self.MLP_neg = 0
        self.MLP_pos = 0
        self.MLg_neg = 0
        self.MLg_pos = 0
        self.MRT_neg = 0
        self.MRT_pos = 0
        self.MRT = 0
        self.MRTproj_neg = 0
        self.MRTproj_pos = 0
        self.MRTproj = 0
        self.AR = 0
        self.ARproj = 0
        self.idxAR = 0
        self.idxARproj = 0
        self.DOFR1 = 0
        self.DOFR2 = 0
        self.DOFR3 = 0
        self.DOFR4 = 0
        self.DOFR5 = 0

    # def __repr__(self):
    def returnJSON(self):
        output = self.__dict__

        output['machines'] = output['machines'].__repr__()
        output['indBuffers'] = output['indBuffers'].__repr__()
        output['transporters'] = output['transporters'].__repr__()
        output['services'] = output['services'].__repr__()
        output['abstract'] = output['abstract'].__repr__()
        output['resources'] = output['resources'].__repr__()
        output['controllers'] = output['controllers'].__repr__()

        outputValues = list(output.values())
        outputKeys = list(output.keys())
        for k1 in range(len(outputValues)):
            if 'coo_matrix' in str(type(outputValues[k1])):
                output[outputKeys[k1]] = outputValues[k1].__dict__
                output[outputKeys[k1]]['row'] = output[outputKeys[k1]]['row'].tolist()
                output[outputKeys[k1]]['col'] = output[outputKeys[k1]]['col'].tolist()
                output[outputKeys[k1]]['data'] = output[outputKeys[k1]]['data'].tolist()
            elif 'ndarray' in str(type(outputValues[k1])):
                output[outputKeys[k1]] = outputValues[k1].tolist()
            elif 'csr_matrix' in str(type(outputValues[k1])):
                output[outputKeys[k1]] = outputValues[k1].__dict__
                output[outputKeys[k1]]['indices'] = output[outputKeys[k1]]['indices'].tolist()
                output[outputKeys[k1]]['indptr'] = output[outputKeys[k1]]['indptr'].tolist()
                output[outputKeys[k1]]['data'] = output[outputKeys[k1]]['data'].tolist()
            elif 'COO' in str(type(outputValues[k1])):
                output[outputKeys[k1]] = outputValues[k1].__dict__
                output[outputKeys[k1]]['coords'] = output[outputKeys[k1]]['coords'].tolist()
                output[outputKeys[k1]]['data'] = output[outputKeys[k1]]['data'].tolist()
                output[outputKeys[k1]]['shape'] = list(map(str,list(output[outputKeys[k1]]['shape'])))
                output[outputKeys[k1]]['fill_value'] = str(output[outputKeys[k1]]['fill_value'])
            elif 'lil_matrix' in str(type(outputValues[k1])):
                output[outputKeys[k1]] = outputValues[k1].tocoo().__dict__
                output[outputKeys[k1]]['row'] = output[outputKeys[k1]]['row'].tolist()
                output[outputKeys[k1]]['col'] = output[outputKeys[k1]]['col'].tolist()
                output[outputKeys[k1]]['data'] = output[outputKeys[k1]]['data'].tolist()
            elif 'DOF' in outputKeys[k1]:
                output[outputKeys[k1]] = str(output[outputKeys[k1]])
            elif 'dok_matrix' in str(type(outputValues[k1])):
                output[outputKeys[k1]] = output[outputKeys[k1]].tocoo().__dict__
                output[outputKeys[k1]]['row'] = output[outputKeys[k1]]['row'].tolist()
                output[outputKeys[k1]]['col'] = output[outputKeys[k1]]['col'].tolist()
                output[outputKeys[k1]]['data'] = output[outputKeys[k1]]['data'].tolist()
            elif 'idxAR' in outputKeys[k1]:
                if 'tuple' in str(type(output[outputKeys[k1]])):
                    output[outputKeys[k1]] = list(output[outputKeys[k1]])
                    output[outputKeys[k1]][0] = output[outputKeys[k1]][0].tolist()
                    output[outputKeys[k1]][1] = output[outputKeys[k1]][1].tolist()
                elif 'DataFrame' in str(type(output[outputKeys[k1]])):
                    output[outputKeys[k1]] = output[outputKeys[k1]].to_json()
            elif 'methodsxForm' in outputKeys[k1]:
                output['methodsxForm'] = output['methodsxForm'].__repr__()
                output['methodsxForm']['resource'] = output['methodsxForm']['resource'].tolist()
            elif 'methodsxPort' in outputKeys[k1]:
                output['methodsxPort'] = output['methodsxPort'].__repr__()
                output['methodsxPort']['resource'] = output['methodsxPort']['resource'].tolist()
                output['methodsxPort']['idxProc'] = output['methodsxPort']['idxProc'].tolist()

        return output

