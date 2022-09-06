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


class Transporters():
    def __init__(self):
        self.controller = []
        self.names = []
        self.methodsxPort = []
        self.idxTransporters = []
        self.idxResource = []
        self.autonomous = []


class Controllers():
    def __init__(self):
        self.status = []
        self.name = []
        self.peerRecipients = []
        self.methodsxCtrl = []


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

        
class servicePlace():
    def __init__(self):
        self.name = []


class serviceTransition():
    def __init__(self):
        self.name = []
        self.preset = []
        self.postset = []
        self.methodLinkName = []
        self.methodLinkRef = []
        self.methodLinkIdx = []


class serviceNet():
    def __init__(self):
        self.name = []


class Abstractions():
    def __init__(self):
        self.methodsxPort = methodxPort()
        self.methodsxForm = methodxForm()
        self.methodPair = methodPair()


class Resources():
    def __init__(self):
        self.names = []
        self.idx = []


class methodxForm():
    def __init__(self):
        self.name = []
        self.operand = []
        self.output = []
        self.status = []
        self.idxForm = []


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


class methodxCtrl():
    def __init__(self):
        self.name = []
        self.operand = []
        self.output = []
        self.status = []
        self.ref = []


class methodPair():
    def __init__(self):
        self.name1 = []
        self.name2 = []
        self.ref1 = []
        self.ref2 = []
        self.idxProc1 = []
        self.idxProc2 = []


class peerRecipient():
    def __init__(self):
        self.name = []


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


class LFES:
    '''Represents all of the components in the HFGT toolbox LFES structure'''

    def __init__(self):
        self.dataState = ''
        self.name = ''
        self.type = ''
        self.diameter = ''
        
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
        
        self.machines = Machines()
        self.indBuffers = IndBuffers()
        self.transporters = Transporters()
        self.services = Services()
        self.abstract = Abstractions()
        self.resources = Resources()
        self.controllers = Controllers()

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
        self.AR = 0
        self.ARproj = 0
        self.AHT = 0
        self.AHrefT = 0

        self.CAM = 0
        self.CADM = 0
        self.partialSAMproj = 0
        self.SAMproj = 0
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

        self.CPRAM = 0
        self.CPPAM = 0
        self.idxAR = 0
        self.idxARproj = 0
        self.DOFR1=0
        self.DOFR2=0
        self.DOFR3=0
        self.DOFR4=0
        self.DOFR5=0
        self.Lambda = 0
        self.xFormLambda = 0

