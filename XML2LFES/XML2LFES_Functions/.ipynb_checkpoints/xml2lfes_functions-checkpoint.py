# -*- coding: utf-8 -*-

import xml.etree.ElementTree as ET
import numpy as np
from XML2LFES.XML2LFES_Classes import *


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
    :param objectA:
    :param dictB:
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
    :param objectA:
    :param dictB:
    :return:
    '''
    print("I am entering appendAttributes.py")
    for key, value in dictB.items():
        if hasattr(objA, key):
            oldVal = getattr(objA, key, [])
            newVal = oldVal + [value]
            setattr(objA, key, newVal)
    print("I am exiting appendAttributes.py")


def getResourceAttributes(objA, root, resourceType):
    '''
    This function inserts information from the intermediary LFES tree structure 
    to a resource object for specified resource type
    :param objA: resource object
    :param root: root of intermediary LFES tree structure
    :param resourcetype: resource tag (i.e. "Machine", "IndBuffer", etc.)
    :return:
    '''
    print("I am entering getResourceAttributes.py")
    attlist = []
    for child in root:
        if child.tag == resourceType:
            attlist.append(child.attrib)
    objattrib = attlist[0].keys()
    attdict = {x: [i.get(x, '') for i in attlist] for x in objattrib}
    for key in attdict:
        if key == 'name':
            setattr(objA, 'names', attdict[key])
        if key == 'controller':
            for k1 in range(len(attdict[key])):
                attdict[key][k1] = attdict[key][k1].split(", ")
            setattr(objA, 'controller', attdict[key])
        else:
            setattr(objA, key, attdict[key])
    print("I am exiting getResourceAttributes.py")
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
    print("I am entering getResourceMethods.py")
    if opt == 'M': # If it's a transformation process
        MXF = methodxForm()
        for method in objA:
            appendAttributes(MXF, method.attrib)
            LFES.setTransformProcess.append(method.attrib['name'])
#             LFES.setTransformProcessOperands.append(method.attrib['operand'])
#             LFES.setTransformProcessOutputs.append(method.attrib['output'])
            LFES.DOFM += 1 
        resource.methodsxForm.append(MXF)
    elif opt == 'C': # If it's a control process
        MXC = methodxCtrl()
        for method in objA:
            appendAttributes(MXC, method.attrib)
            LFES.setControlProcess.append(method.attrib['name']+': '+method.attrib['ref'])
            LFES.DOFC += 1  
        resource.methodsxCtrl.append(MXC)
    elif opt == 'H': # If it's a transportation process
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
        
    print("I am exiting getResourceMethods.py")


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
            # Setup Machine Transformation Process
            if child.find('MethodxForm') != None:
                getResourceMethods(LFES, LFES.machines, child.iterfind('MethodxForm'), 'M')
            else:
                LFES.machines.methodsxForm.append(object())
            # Setup Machine Transportation process
            if child.find('MethodxPort') != None:
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
            # Setup Transportation process
            if child.find('MethodxPort') != None:
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
            # Setup Transportation process
            if child.find('MethodxPort') != None:
                getResourceMethods(LFES, LFES.transporters, child.iterfind('MethodxPort'), 'H')
            else:
                LFES.transporters.methodsxPort.append(object())

    
    print("I am exiting setupTransporters.py")

    
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
                        if key == 'name':
                            attdict['names'] = subchild.attrib[key]
                        else:
                            attdict[key] = subchild.attrib[key]
                    appendAttributes(SP, attdict)
                if subchild.tag == "ServiceTransition":
                    appendAttributes(ST, subchild.attrib)
            LFES.services.servicePlaces.append(SP)
            LFES.services.serviceTransitions.append(ST)   
    for name in LFES.services.names:
        SN = serviceNet()
        SN.name = name
        LFES.services.serviceNets.append(SN)
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
    # Set up Peer Recepients
    for child in root:
        if child.tag == "Controller":
            # Setup control process
            if child.find('MethodxCtrl') != None:
                getResourceMethods(LFES, LFES.controllers, child.iterfind('MethodxCtrl'), 'C')
            else:
                LFES.controllers.methodsxCtrl.append(object()) 
            # Setup peer recipients
            if child.find('PeerRecipient') != None:
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
    
    
def setupAbstractTransportationMethods(LFES, root):
    '''
    :param LFES:
    :param root:
    :return:
    '''
    print("I am entering setupAbstractTransportationMethods.py")
    for child in root:
        if child.tag == "Abstractions":
            MXP = []
            MXP_unique = []
            MP = []
            MP_unique = []
            for subchild in child:
                if subchild.tag == "MethodxPort":
                    MXP.append(subchild.attrib)
                    MXP_unique.append(subchild.attrib['name'].replace('store', 'transport')+subchild.attrib['ref'])
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
            # Unique 'name1+ref1+name2+ref2'
            methodPairIdx = np.unique(MP_unique, return_index=True)[1]
            methodPairIdx.sort()
            for idx in methodPairIdx:
                MP[idx]['name1'] = MP[idx]['name1'].replace('store', 'transport')
                MP[idx]['name2'] = MP[idx]['name2'].replace('store', 'transport')
                appendAttributes(LFES.abstract.methodPair, MP[idx])

    print("I am exiting setupAbstractTransportationMethods.py")
