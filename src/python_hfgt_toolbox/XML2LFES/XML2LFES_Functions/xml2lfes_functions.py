"""
Copyright 2020 LIINES
@author: Dakota Thompson
@company: Thayer School of Engineering at Dartmouth
@lab: LIINES Lab
@Modified: 01/25/2022

"""

import xml.etree.ElementTree as ET
import numpy as np
import pandas as pd

from python_hfgt_toolbox.XML2LFES.XML2LFES_Classes import methodxForm, methodxPort, methodxCtrl, serviceNet, servicePlace, serviceTransition, peerRecipient


def XML2Struct(xmlfile):
    '''
    This function reads in an XML file and outputs a Tuple with three elements.
    The first element is the tree, the second one is the root, the third is
    the tags.
    :param xmlfile: Input XML file
    :return: tree : LFES object details
             root : Intermediary structure to feed LFES object
             tags : LFES meta-elements
    '''
    print("I am entering XML2Struct.py")
    tree = ET.parse(xmlfile)
    root = tree.getroot()
    tags = list({child.tag for child in root})
    print("I am exiting XML2Struct.py")
    return tree, root, tags

def insertAttributes(objA, dictB):
    '''
    This function inserts values from a dictionary to an object
    if the object has a variable with the same name as that of a key in the dictionary
    :param objectA: object being filled in
    :param dictB: dictionary with desired value
    :return:
    '''
    print("I am entering insertAttributes.py")
    for key, value in dictB.items():
        if hasattr(objA, key):
            setattr(objA, key, value)
    print("I am exiting insertAttributes.py")
    
def appendAttributes(objA, dictB):
    '''
    This function appends values from a dictionary to an object
    if the object has a LIST variable with the same name as that of a key in the dictionary
    :param objectA: object being filled in
    :param dictB: dictionary with desired value
    :return:
    '''
    # print("I am entering appendAttributes.py")
    for key, value in dictB.items():
        if hasattr(objA, key):
            oldVal = getattr(objA, key, [])
            newVal = oldVal + [value]
            setattr(objA, key, newVal)
        else:
            setattr(objA, key, [value])
    # print("I am exiting appendAttributes.py")

def getResourceAttributes(objA, root, resourceType):
    '''
    This function inserts information from the intermediary LFES tree structure 
    to a resource object for specified resource type
    :param objA: resource object
    :param root: root of intermediary LFES tree structure
    :param resourcetype: resource tag (i.e. "Machine", "IndBuffer", etc.)
    :return: objA: the updated object
    '''
    # print("I am entering getResourceAttributes.py")
    attlist = []
    for child in root:
        if child.tag == resourceType:
            attlist.append(child.attrib)
    objattrib = attlist[0].keys()
    attdict = {x: [i.get(x, '') for i in attlist] for x in objattrib}
    for key in attdict:
        if key == 'controller':
            for k1 in range(len(attdict[key])):
                attdict[key][k1] = attdict[key][k1].split(", ")
            setattr(objA, 'controller', attdict[key])
        else:
            setattr(objA, key, attdict[key])
    # print("I am exiting getResourceAttributes.py")
    return objA

def getResourceMethods(LFES, resource, objA, opt):
    '''
    This function copies the attributes of methods associated with a resource from the intermediary
    tree structure to the corresponding method attribute within the “myLFES” object.
    :param LFES: LFES object to be filled in
    :param resource: LFES meta-element containing methods
    :param objA: list of methods
    :param opt: “M”,“C”, or “H” for transformation process, control process,
        or transportation process respectively
    :return:
    '''
    # print("I am entering getResourceMethods.py")
    if opt == 'M':  # If it's a transformation process
        MXF = methodxForm()
        for method in objA:
            appendAttributes(MXF, method.attrib)
            LFES.setTransformProcess.append(method.attrib['name'])
            LFES.DOFM += 1
        resource.methodsxForm.append(MXF)
    elif opt == 'H':  # If it's a transportation process
        MXP = methodxPort()
        for method in objA:
            attdict = method.attrib
            if 'store' in attdict['name']:
                attdict['name'] = attdict['name']+' @ '+attdict['origin']
                attdict['nameref'] = attdict['name']+' '+attdict['ref']
            else:
                attdict['name'] = attdict['name']+' f. '+attdict['origin']+' t. '+attdict['dest']
                attdict['nameref'] = attdict['name']+' '+attdict['ref']
            appendAttributes(MXP, attdict)
            LFES.DOFH += 1
        n, idx = np.unique(MXP.name, return_index=True)
        MXP.name = n[0]
        setattr(MXP, 'statusref', MXP.status)
        setattr(MXP, 'status', MXP.statusref[idx[0]])
        resource.methodsxPort.append(MXP)
    elif opt == 'C':  # If it's a control process
        MXC = methodxCtrl()
        for method in objA:
            appendAttributes(MXC, method.attrib)
            LFES.setControlProcess.append(method.attrib['name']+': '+method.attrib['ref'])
            LFES.DOFC += 1
        resource.methodsxCtrl.append(MXC)
    # print("I am exiting getResourceMethods.py")

def setupMachines(LFES, root):
    '''
    This function sets up the machines.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupMachines.py")
    getResourceAttributes(LFES.machines, root, "Machine")
    for child in root:
        if child.tag == "Machine":
            if child.find('MethodxForm') != None:  # Setup Machine Transformation Process
                getResourceMethods(LFES, LFES.machines, child.iterfind('MethodxForm'), 'M')
            else:
                LFES.machines.methodsxForm.append(object())
            if child.find('MethodxPort') != None:  # Setup Machine Transportation process
                getResourceMethods(LFES, LFES.machines, child.iterfind('MethodxPort'), 'H')
            else:
                LFES.machines.methodsxPort.append(object())
    print("I am exiting setupMachines.py")

def setupIndBuffers(LFES, root):
    '''
    This function sets up the independent buffers.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupIndBuffers.py")
    getResourceAttributes(LFES.indBuffers, root, "IndBuffer")
    for child in root:
        if child.tag == "IndBuffer":
            if child.find('MethodxPort') != None:  # Setup Transportation process
                getResourceMethods(LFES, LFES.indBuffers, child.iterfind('MethodxPort'), 'H')
            else:
                LFES.indBuffers.methodsxPort.append(object())
    print("I am exiting setupIndBuffers.py")

def setupTransporters(LFES, root):
    '''
    This function sets up the transporters.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupTransporters.py")
    getResourceAttributes(LFES.transporters, root, "Transporter")
    for child in root:
        if child.tag == "Transporter":
            if child.find('MethodxPort') != None:  # Setup Transportation process
                getResourceMethods(LFES, LFES.transporters, child.iterfind('MethodxPort'), 'H')
            else:
                LFES.transporters.methodsxPort.append(object())
    print("I am exiting setupTransporters.py")

def setupMethodIndicies(LFES, root):
    '''
        This function sets up the indicies of the methods used in each DOF for the DOF indexed XML.
        :param LFES: myLFES object to be filled
        :return:
        '''

    # Setup Methods
    print('Importing Methods')
    LFES.methodsxForm = methodxForm()
    LFES.methodsxPort = methodxPort()

    xmlToMethods(LFES, LFES.methodsxForm, root.iterfind('MethodxForm'), 'M')
    xmlToMethods(LFES, LFES.methodsxPort, root.iterfind('MethodxPort'), 'H')

    # set resource and idxProc to integers
    print('Converting  indices to integers')
    LFES.numBuffers = int(LFES.numBuffers)
    for k1 in range(len(LFES.methodsxForm.resource)):
        LFES.methodsxForm.resource[k1] = int(LFES.methodsxForm.resource[k1])
        LFES.methodsxForm.idxProc[k1] = int(LFES.methodsxForm.idxProc[k1])
    LFES.methodsxPort.idxProc = np.zeros((len(LFES.methodsxPort.resource)), dtype=int)
    for k1 in range(len(LFES.methodsxPort.resource)):
        LFES.methodsxPort.resource[k1] = int(LFES.methodsxPort.resource[k1])
        LFES.methodsxPort.origin[k1] = int(LFES.methodsxPort.origin[k1])
        LFES.methodsxPort.dest[k1] = int(LFES.methodsxPort.dest[k1])
        LFES.methodsxPort.ref[k1] = int(LFES.methodsxPort.ref[k1])
        LFES.methodsxPort.idxProc[k1] = LFES.methodsxPort.origin[k1] * LFES.numBuffers + LFES.methodsxPort.dest[
            k1] + (LFES.methodsxPort.ref[k1] * (LFES.numBuffers ** 2))

    print('Setting up resources')
    uniqueM, returnIndex = np.unique(LFES.methodsxForm.resource, return_index=True)
    LFES.numMachines = len(uniqueM)

def xmlToMethods(LFES,resource, objA, opt):
    """
    This function sets process sets from XML DOFS
    :param: LFES: the LFES object that will retain the populated object
    :param: resource: the methodx____ object that will be populated
    :param: objA: the DOF string that contains the desired infromation to store
    :param: opt: the option of which resource to fill in: M=Machine, C=Controller, H=Transportation
    :return:
    """
    print('I am entering xmlToMethods')
    if opt == 'M':  # If it's a transformation process
        MXF = resource
        getResourceAttributes(MXF, objA, "MethodxForm")
        n = pd.unique(MXF.name)
        LFES.setTransformProcess = n
        LFES.numTransformProcess = len(n)
        LFES.DOFM = len(MXF.name)
        resource = MXF
    elif opt == 'C':  # If it's a control process
        MXC = resource
        getResourceAttributes(MXC, objA, "MethodxCtrl")
        for method in objA:
            appendAttributes(MXC, method.attrib)
            LFES.setControlProcess.append(method.attrib['name'] + ': ' + method.attrib['ref'])
            LFES.DOFC += 1
        resource = MXC
    elif opt == 'H':  # If it's a transportation process
        MXP = resource
        getResourceAttributes(MXP, objA, "MethodxPort")
        n = pd.unique(MXP.name)
        LFES.setTransportProcess = n
        r = pd.unique(MXP.ref)
        LFES.setRefinement = r
        setattr(MXP, 'statusref', MXP.status)
        MXP.nameref = [None]*len(MXP.name)
        for method in range(len(MXP.name)):
            if 'store' in MXP.name[method]:
                MXP.name[method] = MXP.name[method] + ' @ ' + MXP.origin[method]
            else:
                MXP.name[method] = MXP.name[method] + ' f. ' + MXP.origin[method] + ' t. ' + MXP.dest[method]
            MXP.nameref[method] = MXP.name[method] + ' r.' + MXP.ref[method]
            LFES.DOFH += 1
        resource = MXP
        print('I am exiting xmlToMethods')

def setupServices(LFES, root):
    '''
    This function sets up the services.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupServices.py")
    getResourceAttributes(LFES.services, root, "Service")
    for child in root:
        if child.tag == "Service":
            SN = serviceNet()
            SN.name = child.attrib['name']
            LFES.services.serviceNets.append(SN)
            if child.find('ServicePlace') != None:
                SP = servicePlace()
            else:
                SP = object()
            if child.find('ServiceTransition') != None:
                ST = serviceTransition()
            else:
                ST = object()    
            for subchild in child:
                if subchild.tag == "ServicePlace":
                    attdict = {}
                    for key in subchild.attrib:
                        attdict[key] = subchild.attrib[key]
                    appendAttributes(SP, attdict)
                if subchild.tag == "ServiceTransition":
                    appendAttributes(ST, subchild.attrib)
            LFES.services.servicePlaces.append(SP)
            LFES.services.serviceTransitions.append(ST)   
            LFES.services.names.append(SN.name)
    print("I am exiting setupServices.py")
    
def setupControllers(LFES, root):
    '''
    This function sets up the controllers.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupControllers.py")
    getResourceAttributes(LFES.controllers, root, "Controller")
    for child in root:  # Set up Peer Recepients
        if child.tag == "Controller":  # Setup control process
            if child.find('MethodxCtrl') != None:
                getResourceMethods(LFES, LFES.controllers, child.iterfind('MethodxCtrl'), 'C')
            else:
                LFES.controllers.methodsxCtrl.append(object())
            if child.find('PeerRecipient') != None:  # Setup peer recipients
                PR = peerRecipient()
                for subchild in child.iterfind('PeerRecipient'):
                    PR.name.append(subchild.attrib['name'])
            else:
                PR = object()
            LFES.controllers.peerRecipients.append(PR)
    print("I am exiting setupControllers.py")

def setupOperands(LFES, root):
    '''
    This function assigns information to the setOperands and numOperands.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupOperands.py")
    for child in root:
        if child.tag == "Operand":
            LFES.setOperands.append(child.attrib["name"])
    LFES.numOperands = len(LFES.setOperands)
    print("I am exiting setupOperands.py")
    
def setupAbstractMethods(LFES, root):
    '''
    This function assigns information to the abstraction.
    :param LFES: myLFES object to be filled
    :param root: root of intermediary tree S
    :return:
    '''
    print("I am entering setupAbstractMethods.py")
    for child in root:
        if child.tag == "Abstractions":
            MXP = []
            MXP_unique = []
            MXF = []
            MXF_unique = []
            MP = []
            MP_unique = []
            for subchild in child:
                if subchild.tag == "MethodxPort":
                    MXP.append(subchild.attrib)
                    MXP_unique.append(subchild.attrib['name'].replace('store', 'transport')+subchild.attrib['ref'])
                if subchild.tag == "MethodxForm":
                    MXF.append(subchild.attrib)
                    MXF_unique.append(subchild.attrib['name'])
                if subchild.tag == "MethodPair":
                    MP.append(subchild.attrib)
                    MP_unique.append(subchild.attrib['name1'].replace('store', 'transport')+subchild.attrib['ref1'] +
                                     subchild.attrib['name2'].replace('store', 'transport')+subchild.attrib['ref2'])
            # Unique 'name+ref'
            methodxPortIdx = np.unique(MXP_unique, return_index=True)[1]
            methodxPortIdx.sort()
            for idx in methodxPortIdx:
                MXP[idx]['name'] = MXP[idx]['name'].replace('store', 'transport')
                appendAttributes(LFES.abstract.methodsxPort, MXP[idx])
            # MethodxForms
            methodxFormIdx = np.unique(MXF_unique, return_index=True)[1]
            methodxFormIdx.sort()
            for idx in methodxFormIdx:
                appendAttributes(LFES.abstract.methodsxForm, MXF[idx])
            # Unique 'name1+ref1+name2+ref2'
            methodPairIdx = np.unique(MP_unique, return_index=True)[1]
            methodPairIdx.sort()
            for idx in methodPairIdx:
                MP[idx]['name1'] = MP[idx]['name1'].replace('store', 'transport')
                MP[idx]['name2'] = MP[idx]['name2'].replace('store', 'transport')
                appendAttributes(LFES.abstract.methodPair, MP[idx])

    LFES.numHoldingProcess = len(LFES.abstract.methodsxPort.ref)
    LFES.setHoldingProcess = LFES.abstract.methodsxPort.ref[:]
    print("I am exiting setupAbstractMethods.py")
