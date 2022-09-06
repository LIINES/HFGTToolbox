"""
Copyright 2020 LIINES
@author: Dakota Thompson
@company: Thayer School of Engineering at Dartmouth
@lab: LIINES Lab
@Modified: 08/31/2022

"""

import os
import time
import math
import numpy as np
import pandas as pd
import glob
from concurrent.futures import ProcessPoolExecutor
import sparse
from sparse import *
from scipy.sparse import dok_matrix, lil_matrix, csr_matrix, coo_matrix, hstack, vstack, find
from XML2LFES.XML2LFES_Classes import *


def calcResourceCounts(LFES):
    '''
    This function calculates the number of each type of resource present in the system.
    :param LFES: myLFES in transition
    :return:
    '''
    print("I am entering calResourceCounts.py")
    LFES.numMachines = len(LFES.machines.name)
    LFES.numIndBuffers = len(LFES.indBuffers.name)
    LFES.numBuffers = LFES.numMachines + LFES.numIndBuffers
    LFES.numTransporters = len(LFES.transporters.name)
    LFES.numResources = LFES.numBuffers + LFES.numTransporters
    LFES.numControllers = len(LFES.controllers.name)
    LFES.numServices = len(LFES.services.name)
    print("I am exiting calResourceCounts.py")
    

def calcResourceIndices(LFES):
    '''
    This function assigns numeric indices to each machine, independent buffer and transporter
    present in the system.  In addition, it assigns an index for each resource in the system
    from the union of machines,independent buffers and transporters.
    :param LFES: myLFES in transition
    :return:
    '''
    print("I am entering calResourceIndices.py")
    LFES.machines.idxMachine = [x for x in range(LFES.numMachines)]
    LFES.indBuffers.idxBuffers = [x for x in range(LFES.numIndBuffers)]
    LFES.transporters.idxTransporters = [x for x in range(LFES.numTransporters)]
    LFES.machines.idxResource = LFES.machines.idxMachine
    LFES.indBuffers.idxResource = [i+LFES.numMachines for i in LFES.indBuffers.idxBuffers]
    LFES.transporters.idxResource = [i+LFES.numBuffers for i in LFES.transporters.idxTransporters]
    print("I am exiting calResourceIndices.py")


def calcResourceSet(LFES):
    '''
    This function calculates the union of Transformation Resources and Independent Buffers.
    It also assigns a buffer index for every buffer in the system.
    :param LFES:
    :return:
    '''
    print("I am entering calcResourceSet.py")
    LFES.resources.name = LFES.machines.name+LFES.indBuffers.name
    LFES.resources.idx = list((range(len(LFES.machines.idxResource)+len(LFES.indBuffers.idxResource))))
    print("I am exiting calcResourceSet.py")


def packSetTransformProcess(LFES):
    '''
    This function packs the set of transformation processes with numpy unique.
    It also calculates the number of transformation processes. 
    :param LFES:
    :return:
    '''
    print("I am entering packSetTransformProcess.py")
    indices = np.unique(LFES.setTransformProcess, return_index=True)[1]
    LFES.setTransformProcess = [LFES.setTransformProcess[index] for index in sorted(indices)]
    LFES.numTransformProcess = len(LFES.setTransformProcess)
    print("I am exiting packSetTransformProcess.py")


def makeSetTransportProcess(LFES):
    '''
    This function computes the set of all possible transportation processes in the system.
    This set of processes includes storage at a certain buffer element and transportation from one buffer
    element to all other buffer elements present in the system.
    :param LFES:
    :return:
    '''
    print("I am entering makeSetTransportProcesses.py")
    setBuffers = LFES.machines.name+LFES.indBuffers.name
    for k in range(len(LFES.abstract.methodsxPort.name)):
        for k1 in range(len(setBuffers)):
            for k2 in range(len(setBuffers)):
                if k1 == k2:
                    temp = LFES.abstract.methodsxPort.name[k].replace('transport', 'store')
                    LFES.setTransportProcess.append(temp+" @ "+setBuffers[k1])
                else:
                    LFES.setTransportProcess.append(LFES.abstract.methodsxPort.name[k]+' f. ' + setBuffers[k1]+' t. '+setBuffers[k2])
    indices = np.unique(LFES.setTransportProcess, return_index=True)[1]
    LFES.setTransportProcess = [LFES.setTransportProcess[index] for index in sorted(indices)]
    LFES.numTransportProcess = len(LFES.setTransportProcess)
    print("I am exiting makeSetTransportProcesses.py")


def makeSetTransportRefProcess(LFES):
    '''
    This function makes all possible refined transportation processes from an LFES.
    :param LFES:
    :return:
    '''
    print("I am entering makeSetTransportRefProcess.py")
    setBuffers = LFES.machines.name+LFES.indBuffers.name
    for k in range(len(LFES.abstract.methodsxPort.name)):
        for k1 in range(len(setBuffers)):
            for k2 in range(len(setBuffers)):
                if k1 == k2:
                    temp = LFES.abstract.methodsxPort.name[k].replace('transport', 'store')
                    LFES.setTransportRefProcess.append(temp+" @ "+setBuffers[k1] + " - " + LFES.abstract.methodsxPort.ref[k]+" -")
                else:
                    LFES.setTransportRefProcess.append(LFES.abstract.methodsxPort.name[k]+' f. ' + setBuffers[k1]+' t. ' + setBuffers[k2]+" - "+LFES.abstract.methodsxPort.ref[k]+" -")
                LFES.setHoldingProcess.append(LFES.abstract.methodsxPort.ref[k])
    
    LFES.numTransportRefProcess = len(LFES.setTransportRefProcess)
    indices = np.unique(LFES.setHoldingProcess, return_index=True)[1]
    LFES.setHoldingProcess = [LFES.setHoldingProcess[index] for index in sorted(indices)]
    LFES.numHoldingProcess = len(LFES.setHoldingProcess)
    print("I am exiting makeSetTransportRefProcess.py")


def packSetControlProcess(LFES):
    '''
    This function packs the set of control processes with numpy unique
    and also calculates the number of control processes.
    :param LFES:
    :return:
    '''
    print("I am entering packSetControlProcess.py")
    indices = np.unique(LFES.setControlProcess, return_index=True)[1]
    LFES.setControlProcess = [LFES.setControlProcess[index] for index in sorted(indices)]
    LFES.numControlProcess = len(LFES.setControlProcess)
    print("I am exiting packSetControlProcess.py")


def calcMethodPairIdxProc(LFES):
    '''
    The function finds the index of each method pair within the set of transform processes.
    If the method pair name is not found, the index within the set of transportation
    methods is found instead.
    :param LFES:
    :return:
    '''
    print("I am entering calcMethodPairIdxProc.py")
    for k1 in range(len(LFES.abstract.methodPair.name1)):
        try:
            idxProc1 = LFES.setTransformProcess.index(LFES.abstract.methodPair.name1[k1])
        except ValueError:
            idx1PortName = [1 if LFES.abstract.methodPair.name1[k1]==elem else 0 for elem in LFES.abstract.methodsxPort.name]
            if LFES.abstract.methodPair.ref1[k1]:
                idx1PortRef = [1 if LFES.abstract.methodPair.ref1[k1]==elem else 0 for elem in LFES.abstract.methodsxPort.ref]
                idx1PortName = np.logical_and(idx1PortName, idx1PortRef)
            idxProc1 = np.nonzero(idx1PortName)[0][0] + LFES.numTransformProcess
        LFES.abstract.methodPair.idxProc1.append(idxProc1)
        try:
            idxProc2 = LFES.setTransformProcess.index(LFES.abstract.methodPair.name2[k1])
        except ValueError:
            idx2PortName = [1 if LFES.abstract.methodPair.name2[k1]==elem else 0 for elem in LFES.abstract.methodsxPort.name]
            if LFES.abstract.methodPair.ref2[k1]:
                idx2PortRef = [1 if LFES.abstract.methodPair.ref2[k1]==elem else 0 for elem in LFES.abstract.methodsxPort.ref]
                idx2PortName = np.logical_and(idx2PortName, idx2PortRef)
            idxProc2 = np.nonzero(idx2PortName)[0][0] + LFES.numTransformProcess
        LFES.abstract.methodPair.idxProc2.append(idxProc2)
    print("I am exiting calcMethodPairIdxProc.py")


def initializeKnowledgeBasesConstraintsMatrices(LFES):
    '''
    This function initializes the knowledge bases and constraints matrices to empty
    sparse matrices of type COO.
    :param LFES:
    :return:
    '''
    print("I am entering initializeKnowledgeBasesConstraintsMatrices.py")
    LFES.JM = coo_matrix((LFES.numTransformProcess, LFES.numMachines), dtype=int)
    LFES.KM = coo_matrix((LFES.numTransformProcess, LFES.numMachines), dtype=int)
    LFES.AM = coo_matrix((LFES.numTransformProcess, LFES.numMachines), dtype=int)
    LFES.JH = coo_matrix((LFES.numTransportProcess, LFES.numResources), dtype=int)
    LFES.KH = coo_matrix((LFES.numTransportProcess, LFES.numResources), dtype=int)
    LFES.AH = coo_matrix((LFES.numTransportProcess, LFES.numResources), dtype=int)
    LFES.JHref = coo_matrix((LFES.numTransportRefProcess, LFES.numResources), dtype=int)
    LFES.KHref = coo_matrix((LFES.numTransportRefProcess, LFES.numResources), dtype=int)
    LFES.AHref = coo_matrix((LFES.numTransportRefProcess, LFES.numResources), dtype=int)
    print("I am exiting initializeKnowledgeBasesConstraintsMatrices.py")
    
    
def initializeKnowledgeBasesConstraintsTensors(LFES):
    '''
    This function initializes the knowledge bases and constraints tensors to
    sparse tensors of type DOK.
    :param LFES:
    :return:
    '''
    print("I am entering initializeKnowledgeBasesConstraintsTensors.py")
    LFES.JHT = DOK(shape=(LFES.numBuffers,LFES.numBuffers,LFES.numResources), dtype=int)
    LFES.AHT = DOK(shape=(LFES.numBuffers,LFES.numBuffers,LFES.numResources), dtype=int)
    LFES.KHT = DOK(shape=(LFES.numBuffers,LFES.numBuffers,LFES.numResources), dtype=int)
    LFES.JHrefT = DOK(shape=(LFES.numHoldingProcess,LFES.numBuffers,LFES.numBuffers,LFES.numResources), dtype=int)
    LFES.AHrefT = DOK(shape=(LFES.numHoldingProcess,LFES.numBuffers,LFES.numBuffers,LFES.numResources), dtype=int)
    LFES.KHrefT = DOK(shape=(LFES.numHoldingProcess,LFES.numBuffers,LFES.numBuffers,LFES.numResources), dtype=int)
    print("I am exiting initializeKnowledgeBasesConstraintsTensors.py")


def calcJM_KM_AM(LFES):
    '''
    The function calculates the Transformation Knowledge Base JM, Constraints Matrix KM, 
    and Transformation Concept AM.
    :param LFES:
    :return:
    '''
    print("I am entering calcJM_KM_AM.py")
    for k1 in range(LFES.numMachines):
        idxL = lil_matrix((LFES.numTransformProcess, 1), dtype=int)
        if isinstance(LFES.machines.methodsxForm[k1], methodxForm):
            for k2 in range(len(LFES.machines.methodsxForm[k1].name)):
                idxTemp = np.array([1 if LFES.machines.methodsxForm[k1].name[k2] == elem else 0 for elem in LFES.setTransformProcess]).reshape(LFES.numTransformProcess, 1)
                idxL += idxTemp
            (i,j,v) = find(idxL)
            LFES.JM.row = np.concatenate((LFES.JM.row,i))
            LFES.JM.col = np.concatenate((LFES.JM.col,np.repeat(k1,len(i))))
            LFES.JM.data = np.concatenate((LFES.JM.data,v))
            if not(LFES.machines.methodsxForm[k1].status[k2]=='true'):
                LFES.KM.row = np.concatenate((LFES.KM.row,i))
                LFES.KM.col = np.concatenate((LFES.KM.col,[k1]))
                LFES.KM.data = np.concatenate((LFES.KM.data,v))
    if LFES.KM.nnz != 0:
        LFES.AM = LFES.JM.tocsr()-LFES.KM.tocsr()
    else:
        LFES.AM = LFES.JM.tocsr()
    print("I am exiting calcJM_KM_AM.py")


def calcMachineIdxForm(LFES):
    '''
    This function loops through each machine's transformation processes and finds the 
    corresponding index within the set of transformation processes.
    :param LFES:
    :return:
    '''
    print("I am entering calcMachineIdxForm.py")
    for k1 in range(len(LFES.machines.methodsxForm)):
        if isinstance(LFES.machines.methodsxForm[k1], methodxForm):
            for k2 in range(len(LFES.machines.methodsxForm[k1].name)):
                LFES.machines.methodsxForm[k1].idxForm.append(LFES.setTransformProcess.index(LFES.machines.methodsxForm[k1].name[k2]))
    print("I am exiting calcMachineIdxForm.py")
    

def calcMachineIdxPort(LFES):
    '''
    This function loops through each machine's transportation processes and sets the 
    associated indices: idxOrigin, idxDest, idxHold, idxPort and idxPortRef.
    :param LFES:
    :return:
    '''
    print("I am entering calcMachineIdxPort.py")
    for k1 in range(len(LFES.machines.methodsxPort)):
        if isinstance(LFES.machines.methodsxPort[k1], methodxPort):
            for k2 in range(len(LFES.machines.methodsxPort[k1].origin)):
                LFES.machines.methodsxPort[k1].idxOrigin.append(LFES.resources.name.index(LFES.machines.methodsxPort[k1].origin[k2]))
                LFES.machines.methodsxPort[k1].idxDest.append(LFES.resources.name.index(LFES.machines.methodsxPort[k1].dest[k2]))
                LFES.machines.methodsxPort[k1].idxHold.append(LFES.abstract.methodsxPort.ref.index(LFES.machines.methodsxPort[k1].ref[k2]))
                LFES.machines.methodsxPort[k1].idxPort.append(getIdxPort(LFES.machines.methodsxPort[k1].idxOrigin[k2], LFES.machines.methodsxPort[k1].idxDest[k2], LFES.numBuffers))
                LFES.machines.methodsxPort[k1].idxPortRef.append(getIdxPortRef(LFES.machines.methodsxPort[k1].idxPort[k2], LFES.machines.methodsxPort[k1].idxHold[k2], LFES.numTransportProcess))
    print("I am exiting calcMachineIdxPort.py")


def calcIndBufferIdxPort(LFES):
    '''
    This function loops through each independent buffer's transportation processes and sets the
    associated indicies: idxOrigin, idxDest, idxHold, idxPort and idxPortRef.
    :param LFES:
    :return:
    '''
    print("I am entering calcIndBufferIdxPort.py")
    for k1 in range(len(LFES.indBuffers.methodsxPort)):
        if isinstance(LFES.indBuffers.methodsxPort[k1], methodxPort):
            for k2 in range(len(LFES.indBuffers.methodsxPort[k1].origin)):
                LFES.indBuffers.methodsxPort[k1].idxOrigin.append(LFES.resources.name.index (LFES.indBuffers.methodsxPort[k1].origin[k2]))
                LFES.indBuffers.methodsxPort[k1].idxDest.append(LFES.resources.name.index(LFES.indBuffers.methodsxPort[k1].dest[k2]))
                LFES.indBuffers.methodsxPort[k1].idxHold.append( LFES.abstract.methodsxPort.ref.index(LFES.indBuffers.methodsxPort[k1].ref[k2]))
                LFES.indBuffers.methodsxPort[k1].idxPort.append(getIdxPort(LFES.indBuffers.methodsxPort[k1].idxOrigin[k2], LFES.indBuffers.methodsxPort[k1].idxDest[k2], LFES.numBuffers))
                LFES.indBuffers.methodsxPort[k1].idxPortRef.append(getIdxPortRef(LFES.indBuffers.methodsxPort[k1].idxPort[k2], LFES.indBuffers.methodsxPort[k1].idxHold[k2], LFES.numTransportProcess))
    print("I am exiting calcIndBufferIdxPort.py")


def calcTransporterIdxPort(LFES):
    '''
    This function loops through each transporter's transportation processes and sets the
    associated indicies: idxOrigin, idxDest, idxHold, idxPort and idxPortRef.
    :param LFES:
    :return:
    '''
    print("I am entering calcTransporterIdxPort.py")
    for k1 in range(len(LFES.transporters.methodsxPort)):
        if isinstance(LFES.transporters.methodsxPort[k1], methodxPort):
            for k2 in range(len(LFES.transporters.methodsxPort[k1].origin)):
                LFES.transporters.methodsxPort[k1].idxOrigin.append(LFES.resources.name.index (LFES.transporters.methodsxPort[k1].origin[k2]))
                LFES.transporters.methodsxPort[k1].idxDest.append(LFES.resources.name.index (LFES.transporters.methodsxPort[k1].dest[k2]))
                LFES.transporters.methodsxPort[k1].idxHold.append( LFES.abstract.methodsxPort.ref.index(LFES.transporters.methodsxPort[k1].ref[k2]))
                LFES.transporters.methodsxPort[k1].idxPort.append(getIdxPort(LFES.transporters.methodsxPort[k1].idxOrigin[k2], LFES.transporters.methodsxPort[k1].idxDest[k2], LFES.numBuffers))
                LFES.transporters.methodsxPort[k1].idxPortRef.append(getIdxPortRef(LFES.transporters.methodsxPort[k1].idxPort[k2], LFES.transporters.methodsxPort[k1].idxHold[k2], LFES.numTransportProcess))
    print("I am exiting calcTransporterIdxPort.py")


def getIdxPort(idxOrigin, idxDest, numBuffers):
    '''
    This function calculates the non-projected transportation process index.
    :param idxOrigin: origin index
    :param idxDest: destination index
    :param numBuffers: number of buffers
    :return:
    '''
    idxPort = numBuffers*(idxOrigin)+idxDest
    return idxPort


def getIdxPortRef(idxPort, idxHold, numTransportProcess):
    '''
    This function finds a transportation process within setTransportRefProcess.
    :param idxPort: index of process within setTransportProcess
    :param idxHold: holding process index
    :param numTransportProcess:
    :return: refined transportation process index
    '''
    idxPortRef = numTransportProcess*(idxHold)+idxPort
    return idxPortRef


def calcJH_KH_AH(LFES):
    '''
    This function calculates Transportation Knowledge Base JH, Constraints Matrix KH, 
    and Transportation Concept AH.
    :param LFES:
    :return:
    '''
    print("I am entering calcJH_KH_AH.py")
    for k1 in range(LFES.numResources):
        if k1 < LFES.numMachines:
            if isinstance(LFES.machines.methodsxPort[k1], methodxPort):
                idxN = np.unique(LFES.machines.methodsxPort[k1].idxPort)
                for k2 in idxN:
                    LFES.JH.row = np.concatenate((LFES.JH.row, [k2]))
                    LFES.JH.col = np.concatenate((LFES.JH.col, [k1]))
                    LFES.JH.data = np.concatenate((LFES.JH.data, [1]))
                    if not (LFES.machines.methodsxPort[k1].status=='true'):
                        LFES.KH.row = np.concatenate((LFES.KH.row, [k2]))
                        LFES.KH.col = np.concatenate((LFES.KH.col, [k1]))
                        LFES.KH.data = np.concatenate((LFES.KH.data, [1]))
        elif k1 >= LFES.numMachines and k1 < LFES.numBuffers:
            k = k1 - LFES.numMachines
            if isinstance(LFES.indBuffers.methodsxPort[k], methodxPort):
                idxN = np.unique(LFES.indBuffers.methodsxPort[k].idxPort)
                for k2 in idxN:
                    LFES.JH.row = np.concatenate((LFES.JH.row, [k2]))
                    LFES.JH.col = np.concatenate((LFES.JH.col, [k1]))
                    LFES.JH.data = np.concatenate((LFES.JH.data, [1]))
                    if not (LFES.indBuffers.methodsxPort[k].status=='true'):
                        LFES.KH.row = np.concatenate((LFES.KH.row, [k2]))
                        LFES.KH.col = np.concatenate((LFES.KH.col, [k1]))
                        LFES.KH.data = np.concatenate((LFES.KH.data, [1]))
        else:
            k = k1 - LFES.numBuffers
            if isinstance(LFES.transporters.methodsxPort[k], methodxPort):
                idxN = np.unique(LFES.transporters.methodsxPort[k].idxPort)
                for k2 in idxN:
                    LFES.JH.row = np.concatenate((LFES.JH.row, [k2]))
                    LFES.JH.col = np.concatenate((LFES.JH.col, [k1]))
                    LFES.JH.data = np.concatenate((LFES.JH.data, [1]))
                    if not (LFES.transporters.methodsxPort[k].status=='true'):
                        LFES.KH.row = np.concatenate((LFES.KH.row, [k2]))
                        LFES.KH.col = np.concatenate((LFES.KH.col, [k1]))
                        LFES.KH.data = np.concatenate((LFES.KH.data, [1]))
    LFES.AH = LFES.JH.tocsr() - LFES.KH.tocsr()
    print("I am exiting calcJH_KH_AH.py")
    
    
def calcJHT_KHT_AHT(LFES):
    '''
    This function calculates Transportation Knowledge Base, Constraints tensor,
    and Transportation Concept tensors.
    :param LFES:
    :return:
    '''
    print('I am entering calcJHT_KHT_AHT')
    LFES.JHT = tensorize(LFES.JH, [LFES.numBuffers,LFES.numBuffers,LFES.numResources], [1,0], [2])
    LFES.KHT = tensorize(LFES.KH, [LFES.numBuffers,LFES.numBuffers,LFES.numResources], [1,0], [2])
    LFES.AHT = LFES.JHT - LFES.KHT
    print('I am exiting calcJHT_KHT_AHT')


def calcJHref_KHref_AHref(LFES):
    '''
    Thie function calculates the Refined Transportation Knowledge Base JH, Constraints Matrix KH, 
    and Refined Transportation Concept AH.
    :param LFES:
    :return:
    '''
    print("I am entering calcJHref_KHref_AHref.py")
    for k1 in range(LFES.numResources):
        if k1 < LFES.numMachines:
            if isinstance(LFES.machines.methodsxPort[k1], methodxPort):
                for k2 in range(len(LFES.machines.methodsxPort[k1].idxPortRef)):
                    idxN = LFES.machines.methodsxPort[k1].idxPortRef[k2]
                    LFES.JHref.row = np.concatenate((LFES.JHref.row, [idxN]))
                    LFES.JHref.col = np.concatenate((LFES.JHref.col, [k1]))
                    LFES.JHref.data = np.concatenate((LFES.JHref.data, [1]))
                    if not (LFES.machines.methodsxPort[k1].statusref[k2]=='true'):
                        LFES.KHref.row = hstack((LFES.KHref.row, [idxN]))
                        LFES.KHref.col = hstack((LFES.KHref.col, [k1]))
                        LFES.KHrefH.data = hstack((LFES.KHref.data, [1]))
        elif k1 >= LFES.numMachines and k1 < LFES.numBuffers:
            k = k1 - LFES.numMachines
            if isinstance(LFES.indBuffers.methodsxPort[k], methodxPort):
                for k2 in range(len(LFES.indBuffers.methodsxPort[k].idxPortRef)):
                    idxN = LFES.indBuffers.methodsxPort[k].idxPortRef[k2]
                    LFES.JHref.row = np.concatenate((LFES.JHref.row, [idxN]))
                    LFES.JHref.col = np.concatenate((LFES.JHref.col, [k1]))
                    LFES.JHref.data = np.concatenate((LFES.JHref.data, [1]))
                    if not (LFES.indBuffers.methodsxPort[k].statusref[k2] == 'true'):
                        LFES.KHref.row = hstack((LFES.KHref.row, [idxN]))
                        LFES.KHref.col = hstack((LFES.KHref.col, [k1]))
                        LFES.KHrefH.data = hstack((LFES.KHref.data, [1]))
        else:
            k = k1 - LFES.numBuffers
            if isinstance(LFES.transporters.methodsxPort[k], methodxPort):
                for k2 in range(len(LFES.transporters.methodsxPort[k].idxPortRef)):
                    idxN = LFES.transporters.methodsxPort[k].idxPortRef[k2]
                    LFES.JHref.row = np.concatenate((LFES.JHref.row, [idxN]))
                    LFES.JHref.col = np.concatenate((LFES.JHref.col, [k1]))
                    LFES.JHref.data = np.concatenate((LFES.JHref.data, [1]))
                    if not (LFES.transporters.methodsxPort[k].statusref[k2] == 'true'):
                        LFES.KHref.row = hstack((LFES.KHref.row, [idxN]))
                        LFES.KHref.col = hstack((LFES.KHref.col, [k1]))
                        LFES.KHrefH.data = hstack((LFES.KHref.data, [1]))
    LFES.AHref = LFES.JHref.tocsr() - LFES.KHref.tocsr()
    print("I am exiting calcJHref_KHref_AHref.py")
    
    
def calcJHrefT_KHrefT_AHrefT(LFES):
    '''
    This function calculates the Refined Transportation Knowledge Base, Constraints tensor,
    and Refined Transportation Concept tensors.
    :param LFES:
    :return:
    '''
    print('I am entering calcJHrefT_KHrefT_AHrefT')
    LFES.JHrefT = tensorize(LFES.JHref, [LFES.numHoldingProcess,LFES.numBuffers,LFES.numBuffers,LFES.numResources], [2,1,0], [3])
    LFES.KHrefT = tensorize(LFES.KHref, [LFES.numHoldingProcess,LFES.numBuffers,LFES.numBuffers,LFES.numResources], [2,1,0], [3])
    LFES.AHrefT = LFES.JHrefT - LFES.KHrefT
    print('I am exiting calcJHrefT_KHrefT_AHrefT')


def calcStrucDOF(LFES):
    '''
    This function calculates the transformation degrees of freedom (DOFM), the transportation degrees of
    freedom (DOFH), and the refined transportation degrees of freedom (DOFHref).
    :param LFES:
    :return:
    '''
    print("I am entering calcStrucDOF.py")
    if LFES.AM.get_shape()[0] and LFES.AM.get_shape()[1]:
        LFES.DOFM = LFES.AM.sum()
    if LFES.AH.get_shape()[0] and LFES.AH.get_shape()[1]:
        LFES.DOFH = LFES.AH.sum()
    if LFES.AHref.get_shape()[0] and LFES.AHref.get_shape()[1]:
        LFES.DOFHref = LFES.AHref.sum()
    print("I am exiting calcStructDOF.py")


def calcJS_KS_AS(LFES):
    '''
    This function calculates System Knowledge base JS, System Constraints Matrix KS, and System Concept AS.
    :param LFES:
    :return:
    '''
    print("I am entering calcJS_KS_AS.py")
    LFES.JS = vstack([hstack([LFES.JM, csr_matrix((LFES.numTransformProcess, LFES.numIndBuffers+LFES.numTransporters), dtype=int)]), LFES.JHref], format='csr')
    LFES.KS = vstack([hstack([LFES.KM, csr_matrix((LFES.numTransformProcess, LFES.numIndBuffers+LFES.numTransporters), dtype=int)]), LFES.KHref], format='csr')
    LFES.AS = vstack([hstack([LFES.AM, csr_matrix((LFES.numTransformProcess, LFES.numIndBuffers+LFES.numTransporters), dtype=int)]), LFES.AHref], format='csr')
    LFES.DOFS = LFES.AS.sum()
    LFES.numProcesses = LFES.AS.get_shape()[0]
    print("I am exiting calcJS_KS_AS.py")


def initializeControl(LFES):
    '''
    This function initializes the control structure within LFES as sparse matrices of type lil.
    :param LFES:
    :return:
    '''
    print("I am entering initializeControl.py")
    LFES.CAM = coo_matrix((LFES.numResources, LFES.numControllers), dtype=int)
    LFES.CADM = coo_matrix((LFES.numControllers, LFES.numControllers), dtype=int)
    LFES.partialSAMproj = coo_matrix((LFES.numControllers + LFES.DOFS, LFES.numControllers + LFES.DOFS), dtype=int)
    LFES.CPRAM = coo_matrix((LFES.numResources, LFES.numResources+LFES.numControllers), dtype=int)
    LFES.CPPAM = coo_matrix((LFES.numProcesses, LFES.numProcesses+LFES.numControlProcess), dtype=int)
    print("I am exiting initializeControl.py")


def makeCPRAM(LFES):
    '''
    This function calculates the Cyber Physical Resource Agency Matrix CPRAM.
    :param LFES:
    :return:
    '''
    print("I am entering makeCPRAM.py")
    resourceControl = []
    resourceAutonomous = [];
    if LFES.numMachines > 0:
        resourceControl = resourceControl + LFES.machines.controller
        if LFES.machines.autonomous:
            resourceAutonomous = np.hstack((resourceAutonomous, LFES.machines.autonomous))
        else:
            resourceAutonomous = np.hstack((resourceAutonomous, np.tile(['true'], LFES.numMachines)))
    if LFES.numIndBuffers > 0:
        resourceControl = resourceControl + LFES.indBuffers.controller
        if LFES.indBuffers.autonomous:
            resourceAutonomous = np.hstack((resourceAutonomous, LFES.indBuffers.autonomous))
        else:
            resourceAutonomous = np.hstack((resourceAutonomous, np.tile(['true'], LFES.numIndBuffers)))
    if LFES.numTransporters > 0:
        resourceControl = resourceControl + LFES.transporters.controller
        if LFES.transporters.autonomous:
            resourceAutonomous = np.hstack((resourceAutonomous, LFES.transporters.autonomous))
        else:
            resourceAutonomous = np.hstack((resourceAutonomous, np.tile(['true'], LFES.numTransporters)))
    LFES.CPRAM = LFES.CPRAM.tolil()
    LFES.CAM = LFES.CAM.tolil()
    for k1 in range(LFES.numControllers):
        for k2 in range(LFES.numResources):
            if LFES.controllers.name[k1] in resourceControl[k2]:
                LFES.CPRAM[k2, LFES.numResources + k1] = 1
                LFES.CAM[k2, k1] = 1

    resourceAutonomous = np.array([x == 'true' for x in resourceAutonomous]).reshape((LFES.numResources, 1))
    diagMat = np.zeros((LFES.numResources, LFES.numResources), dtype=int)
    np.fill_diagonal(diagMat, 1)
    LFES.CPRAM[:, 0:LFES.numResources] = np.multiply(diagMat, resourceAutonomous)
    print("I am exiting makeCPRAM.py")


def makeCPPAM(LFES):
    '''
    This function calculates the Cyber Physical Process Agregation Matrix CPPAM.
    :param LFES:
    :return:
    '''
    print("I am entering makeCPPAM.py")
    if LFES.numTransformProcess > 0:
        if LFES.numControlProcess > 0:
            for k1 in range(LFES.numTransformProcess):
                LFES.CPPAM[k1, LFES.numProcesses:LFES.numProcesses+LFES.numControlProcess] = [True if LFES.setTransformProcess[k1] in x else False for x in LFES.setControlProcess]
    if LFES.numHoldingProcess > 0:
        if LFES.numControlProcess > 0:
            for k1 in range(LFES.numHoldingProcess):
                LFES.CPPAM[LFES.numTransformProcess+(k1*LFES.numTransportProcess):LFES.numTransformProcess+(k1+1)*LFES.numTransportProcess, LFES.numProcesses:LFES.numProcesses+LFES.numControlProcess] = np.tile([True if LFES.setHoldingProcess[k1] in x else False for x in LFES.setControlProcess], (LFES.numTransportProcess, 1))
    if LFES.numControlProcess > 0:
        for k1 in range(LFES.numControlProcess):
            if "store" in LFES.setControlProcess[k1]:
                storage = np.array([True if "store" in x else False for x in LFES.setTransportRefProcess]).reshape(LFES.CPPAM[LFES.numTransformProcess:, LFES.numProcesses+k1].shape)
                LFES.CPPAM[LFES.numTransformProcess:, LFES.numProcesses+k1] = np.logical_and(LFES.CPPAM[LFES.numTransformProcess: , LFES.numProcesses+3].toarray(),storage)
    LFES.CPPAM = LFES.CPPAM.tolil()
    LFES.CPPAM[range(LFES.numProcesses), range(LFES.numProcesses)] = np.ones(LFES.numProcesses)
    print("I am exiting makeCPPAM.py")


def calcControllerJS(LFES):
    '''
    This function calculates the Cyber Physical JS matrix.
    :param LFES:
    :return:
    '''
    print("I am entering calcControllerJS.py")
    JC = lil_matrix((LFES.numControlProcess, LFES.numControllers), dtype=bool)
    KC = lil_matrix((LFES.numControlProcess, LFES.numControllers), dtype=bool)
    if LFES.numControlProcess > 0:
        for k1 in range(LFES.numControllers):
            if LFES.controllers.status[k1] == 'false':
                continue
            idx = np.zeros((LFES.numControlProcess, 1))
            for k2 in range(len(LFES.setControlProcess)):
                for ref in LFES.controllers.methodsxCtrl[k1].ref:
                    if ref in LFES.setControlProcess[k2]:
                        idx[k2] = 1
            JC[:, k1] = idx
            for k2 in range(len(idx)):
                if idx[k2]:
                    KC[k2, k1] = not (LFES.controllers.methodsxCtrl[k1].status[k2] == 'true')
    AC = JC
    for k in range(KC.getnnz()):
        AC[KC.nonzero()[0][k], KC.nonzero()[1][k]] = 0
    upper_right_zeros = lil_matrix((LFES.numProcesses, LFES.numControllers), dtype=bool)
    lower_left_zeros = lil_matrix((LFES.numControlProcess, LFES.numResources), dtype=bool)
    ASC = vstack((hstack((LFES.AS, upper_right_zeros)), hstack((lower_left_zeros, AC))), format='csr')
    for w in range(LFES.numProcesses):
        for v in range(LFES.numResources):
            if LFES.AS[w, v]:
                active = 0
                for w1 in range(LFES.numProcesses + LFES.numControlProcess):
                    for v1 in range(LFES.numResources + LFES.numControllers):
                        active = ASC[w1, v1] * LFES.CPPAM[w, w1] * LFES.CPRAM[v, v1]
                        if active > 0:
                            break
                    if active > 0:
                        break
                LFES.AS[w, v] = active
    print("I am exiting calcControllerJS.py")


def makeCADM(LFES):
    '''
    This function calculates the Controller Adjacency Matrix CADM.
    :param LFES:
    :return:
    '''
    print("I am entering makeCADM.py")
    numControllers = len(LFES.controllers.peerRecipients)
    LFES.CADM = LFES.CADM.tocsr()
    for k1 in range(numControllers):
        if hasattr(LFES.controllers.peerRecipients[k1], 'name'):
            numRecipients = len(LFES.controllers.peerRecipients[k1].name)
            for k2 in range(numRecipients):
                idx = [True if item==LFES.controllers.peerRecipients[k1].name[k2] else False for item in LFES.controllers.name]
                LFES.CADM[k1,:] = np.logical_or(LFES.CADM[k1,:].toarray(), idx)
    print("I am leaving makeCADM.py")


def makeServiceNet(LFES):
    '''
    This function generates a serviceNet object for each service and fills in the
    Mpos, Mneg, and dualAdjacency variables.
    :param LFES:
    :return:
    '''
    print("I am entering makeServiceNet.py")
    for k1 in range(LFES.numServices):
        serviceNet = PetriNetwork()
        serviceNet.name = LFES.services.names[k1]
        # Service Places
        for p1 in range(len(LFES.services.servicePlaces[k1].name)):
            serviceNet.place.index.append(p1)
            serviceNet.place.name.append(LFES.services.servicePlaces[k1].name[p1])
        # Service Transitions
        for t1 in range(len(LFES.services.serviceTransitions[k1].name)):
            serviceNet.transition.index.append(t1)
            serviceNet.transition.name.append(LFES.services.serviceTransitions[k1].name[t1])
            # origin
            myPreSet = LFES.services.serviceTransitions[k1].preset[t1].split(',')
            o_list = [None] * len(myPreSet)
            for o1 in range(len(myPreSet)):
                try:
                    origin = serviceNet.place.name.index(myPreSet[o1])
                except ValueError:
                    origin = None
                o_list[o1] = origin
            serviceNet.transition.origin.append(o_list)
            # dest
            myPostSet = LFES.services.serviceTransitions[k1].postset[t1].split(',')
            d_list = [None] * len(myPostSet)
            for d1 in range(len(myPostSet)):
                try:
                    dest = serviceNet.place.name.index(myPostSet[d1])
                except ValueError:
                    dest = None
                d_list[d1] = dest
            serviceNet.transition.dest.append(d_list)
        # Service Arcs
        serviceNet.arc = Arc(serviceNet)
        # Save Net
        LFES.services.serviceNets[k1] = serviceNet
        # Service Incidence Matrices
        temp = np.array(serviceNet.arc.arcPTidx)
        LFES.services.Mneg.append(csr_matrix((np.ones(len(temp)), (temp[:, 0], temp[:, 1])), shape=(
        len(LFES.services.servicePlaces[k1].name), len(LFES.services.serviceTransitions[k1].name))))
        temp = np.array(serviceNet.arc.arcTPidx)
        LFES.services.Mpos.append(csr_matrix((np.ones(len(temp)), (temp[:, 1], temp[:, 0])), shape=(
        len(LFES.services.servicePlaces[k1].name), len(LFES.services.serviceTransitions[k1].name))))
        LFES.services.dualAdjacency.append(LFES.services.Mpos[k1].transpose().dot(LFES.services.Mneg[k1]))
    print("I am exiting makeServiceNet.py")


def makeServiceFeasibility(LFES):
    '''
    This function calculates the service feasibility matrix. It uses the DOFs to find
    the services performed by the DOFs.
    :param LFES:
    :return:
    '''
    print("I am entering makeServiceFeasibility.py")

    setRefinements = np.zeros((LFES.numTransformProcess, 1))
    for k1 in range(len(LFES.setHoldingProcess)):
        temp = np.tile([LFES.setHoldingProcess[k1]], (LFES.numTransportProcess, 1))
        setRefinements = np.vstack((setRefinements, temp))

    '''Original Lambda: sigma(El) x sigma(P)'''
    print('Original Lambda: sigma(El) x sigma(P)')
    myProcesses = LFES.setTransformProcess + LFES.setTransportRefProcess

    for k1 in range(LFES.numServices):
        print('Service %d' % (k1))
        name = LFES.services.serviceTransitions[k1].name
        linkname1 = LFES.services.serviceTransitions[k1].methodLinkName
        linkref1 = LFES.services.serviceTransitions[k1].methodLinkRef
        preset1 = LFES.services.serviceTransitions[k1].preset
        postset1 = LFES.services.serviceTransitions[k1].postset

        LFES.services.RawLambda.append(np.zeros((len(linkname1), len(myProcesses)), dtype=int))
        LFES.services.RawLambda_neg.append(np.zeros((len(linkname1), len(myProcesses)), dtype=int))
        LFES.services.RawLambda_pos.append(np.zeros((len(linkname1), len(myProcesses)), dtype=int))
        for k2 in range(len(linkname1)):
            if not linkref1[k2]:
                idx1 = [1 if linkname1[k2] == elem else 0 for elem in myProcesses]
                LFES.services.RawLambda[k1][k2] = idx1
                if preset1[k2]:
                    LFES.services.RawLambda_neg[k1][k2] = idx1
                if postset1[k2]:
                    LFES.services.RawLambda_pos[k1][k2] = idx1
            else:
                idx1 = [1 if linkref1[k2] == elem else 0 for elem in setRefinements]
                LFES.services.RawLambda[k1][k2] = idx1
                if preset1[k2]:
                    LFES.services.RawLambda_neg[k1][k2] = idx1
                if postset1[k2]:
                    LFES.services.RawLambda_pos[k1][k2] = idx1

    '''Projected General Lambda: sigma(El) x DOFS'''
    print('Projected General Lambda: sigma(El) x DOFS')
    idxDOFProcesses = [LFES.AS.nonzero()[0][i] for i in np.argsort(LFES.AS.nonzero()[1])]
    singleLambda = np.zeros((0, LFES.DOFS))

    for k1 in range(LFES.numServices):
        print('Service %d' % (k1))
        linkName1 = LFES.services.serviceTransitions[k1].methodLinkName
        linkRef1 = LFES.services.serviceTransitions[k1].methodLinkRef

        LFES.services.Lambda.append(np.zeros((len(linkName1), LFES.DOFS)))
        for k2 in range(len(linkName1)):
            if not linkRef1[k2]:
                idx1 = [1 if linkName1[k2] == elem else 0 for elem in myProcesses]
                idx2 = np.nonzero([1 if elem in np.nonzero(idx1)[0] else 0 for elem in idxDOFProcesses])[0]
                LFES.services.Lambda[k1][k2, idx2] = 1
            else:
                if linkName1[k2] == 'transport':
                    idx1 = np.logical_or([1 if linkName1[k2] in element else 0 for element in myProcesses],
                                         [1 if 'store' in element else 0 for element in myProcesses])
                else:
                    idx1 = [1 if linkName1[k2] in element else 0 for element in myProcesses]
                idx2 = [1 if linkRef1[k2] == element else 0 for element in setRefinements]
                idx3 = np.multiply(idx1, idx2)
                idx4 = np.nonzero(idx3)[0]
                idx5 = np.zeros((1, LFES.DOFS))
                for k3 in range(len(idx4)):
                    temp = np.array([1 if elem == idx4[k3] else 0 for elem in idxDOFProcesses])
                    for idx in temp.nonzero()[0]:
                        idx5[0, idx] = 1
                LFES.services.Lambda[k1][k2, :] = idx5
        singleLambda = np.vstack((singleLambda, LFES.services.Lambda[k1]))
    LFES.Lambda = singleLambda

    '''Raw xForm Lambda: sigma(El) x sigma(P_mu)'''
    print('Raw xForm Lambda: sigma(El) x sigma(P_mu)')
    myxFormProcesses = LFES.setTransformProcess

    for k1 in range(LFES.numServices):
        print('Service %d' % (k1))
        name = LFES.services.serviceTransitions[k1].name
        linkname1 = LFES.services.serviceTransitions[k1].methodLinkName
        linkref1 = LFES.services.serviceTransitions[k1].methodLinkRef
        preset1 = LFES.services.serviceTransitions[k1].preset
        postset1 = LFES.services.serviceTransitions[k1].postset

        LFES.services.RawxFormLambda.append(np.zeros((len(linkname1), len(myxFormProcesses))))
        LFES.services.RawxFormLambda_pos.append(np.zeros((len(linkname1), len(myxFormProcesses))))
        LFES.services.RawxFormLambda_neg.append(np.zeros((len(linkname1), len(myxFormProcesses))))
        for k2 in range(len(linkname1)):
            if name[k2] != 'maintain':
                if not linkref1[k2]:
                    idx1 = [1 if linkname1[k2] == elem else 0 for elem in myxFormProcesses]
                    LFES.services.RawxFormLambda[k1][k2, :] = idx1
                    if preset1[k2]:
                        LFES.services.RawxFormLambda_neg[k1][k2] = idx1
                    if postset1[k2]:
                        LFES.services.RawxFormLambda_pos[k1][k2] = idx1
                else:
                    idx1 = [1 if linkref1[k2] in elem else 0 for elem in myxFormProcesses]
                    LFES.services.RawxFormLambda[k1][k2, :] = idx1
                    if preset1[k2]:
                        LFES.services.RawxFormLambda_neg[k1][k2] = idx1
                    if postset1[k2]:
                        LFES.services.RawxFormLambda_pos[k1][k2] = idx1

    '''Projected xForm Lambda: sigma(El) x DOFM'''
    print('Projected xForm Lambda: sigma(El) x DOFM')
    idxDOFxFormProcesses = [LFES.AM.nonzero()[0][i] for i in np.argsort(LFES.AM.nonzero()[1])]
    xFormSingleLambda = np.zeros((0, LFES.DOFM))

    for k1 in range(LFES.numServices):
        print('Service %d' % (k1))
        name = LFES.services.serviceTransitions[k1].name
        linkName1 = LFES.services.serviceTransitions[k1].methodLinkName
        linkRef1 = LFES.services.serviceTransitions[k1].methodLinkRef

        LFES.services.xFormLambda.append(np.zeros((len(linkName1), LFES.DOFM)))
        for k2 in range(len(linkName1)):
            if name[k2] != 'maintain':
                if not linkRef1[k2]:
                    idx1 = [1 if linkName1[k2] == elem else 0 for elem in myProcesses]
                    idx2 = np.nonzero([1 if elem in np.nonzero(idx1)[0] else 0 for elem in idxDOFxFormProcesses])[0]
                    LFES.services.xFormLambda[k1][k2, idx2] = 1
                else:
                    if linkName1[k2] == 'transport':
                        idx1 = np.logical_or([1 if linkName1[k2] in element else 0 for element in myProcesses],
                                             [1 if 'store' in element else 0 for element in myProcesses])
                    else:
                        idx1 = [1 if linkName1[k2] in element else 0 for element in myProcesses]
                    idx2 = [1 if linkRef1[k2] == element else 0 for element in setRefinements]
                    idx3 = np.multiply(idx1, idx2)
                    idx4 = np.nonzero(idx3)[0]
                    idx5 = np.zeros((1, LFES.DOFS))
                    for k3 in range(len(idx4)):
                        temp = np.array([1 if elem == idx4[k3] else 0 for elem in idxDOFxFormProcesses])
                        for idx in temp.nonzero()[0]:
                            idx5[0, idx] = 1
                    for idx in idx5.nonzero()[0]:
                        LFES.services.xFormLambda[k1][k2, idx] = 1
        xFormSingleLambda = np.vstack((xFormSingleLambda, LFES.services.xFormLambda[k1]))
    LFES.xFormLambda = xFormSingleLambda

    '''xPort Lambda: sigma(El) x Pgamma'''
    print('xPort Lambda: sigma(El) x Pgamma')
    for k1 in range(LFES.numServices):
        print('Service %d' % (k1))
        linkName1 = LFES.services.serviceTransitions[k1].methodLinkName
        linkRef1 = LFES.services.serviceTransitions[k1].methodLinkRef
        preset1 = LFES.services.serviceTransitions[k1].preset
        postset1 = LFES.services.serviceTransitions[k1].postset

        LFES.services.xPortLambda.append(np.zeros((len(linkName1), LFES.numHoldingProcess)))
        LFES.services.xPortLambda_pos.append(np.zeros((len(linkName1), LFES.numHoldingProcess)))
        LFES.services.xPortLambda_neg.append(np.zeros((len(linkName1), LFES.numHoldingProcess)))
        for k2 in range(len(linkName1)):
            for k3 in range(LFES.numHoldingProcess):
                if linkRef1[k2] == LFES.setHoldingProcess[k3]:
                    LFES.services.xPortLambda[k1][k2, k3] = 1
                    if preset1[k2]:
                        LFES.services.xPortLambda_neg[k1][k2, k3] = 1
                    if postset1[k2]:
                        LFES.services.xPortLambda_pos[k1][k2, k3] = 1

    print("I am exiting makeServiceFeasibility.py")


def calcMLP(myLFES):
    """
    This function calculates the transformation process-operand incidence matrices.
    :param LFES:
    :return:
    """
    print("I am entering calcMLP.py")
    myLFES.MLP_neg = dok_matrix((myLFES.numOperands, myLFES.numProcesses), dtype=int)
    myLFES.MLP_pos = dok_matrix((myLFES.numOperands, myLFES.numProcesses), dtype=int)
    for k1 in range(myLFES.numMachines):
        if isinstance(myLFES.machines.methodsxForm[k1], methodxForm):
            for k2 in range(len(myLFES.machines.methodsxForm[k1].name)):
                try:
                    idxTemp = myLFES.setTransformProcess.index(myLFES.machines.methodsxForm[k1].name[k2])
                except ValueError:
                    continue
                strMinus = myLFES.machines.methodsxForm[k1].operand[k2].split(', ')
                for strM in range(len(strMinus)):
                    if strMinus[strM]:
                        try:
                            idxTemp2 = myLFES.setOperands.index(strMinus[strM])
                            myLFES.MLP_neg[idxTemp2, idxTemp] = 1
                        except ValueError:
                            continue
                strPlus = myLFES.machines.methodsxForm[k1].output[k2].split(', ')
                for strP in range(len(strPlus)):
                    if strPlus[strP]:
                        try:
                            idxTemp3 = myLFES.setOperands.index(strPlus[strP])
                            myLFES.MLP_pos[idxTemp3, idxTemp] = 1
                        except ValueError:
                            continue
    myLFES.MLg_neg = dok_matrix((myLFES.numOperands, myLFES.numHoldingProcess), dtype=int)
    for g in range(myLFES.numHoldingProcess):
        strMinus = myLFES.abstract.methodsxPort.operand[g].split(', ')
        for op1 in range(len(strMinus)):
            try:
                idxG = myLFES.setOperands.index(strMinus[op1])
            except ValueError:
                continue
            myLFES.MLg_neg[idxG, g] = 1
    myLFES.MLP_neg[:, myLFES.numTransformProcess:] = kron(myLFES.MLg_neg, np.ones((1, myLFES.numTransportProcess))).todense()
    myLFES.MLg_pos = dok_matrix((myLFES.numOperands, myLFES.numHoldingProcess), dtype=int)
    for g in range(myLFES.numHoldingProcess):
        strMinus = myLFES.abstract.methodsxPort.output[g].split(', ')
        for op1 in range(len(strMinus)):
            try:
                idxG = myLFES.setOperands.index(strMinus[op1])
            except ValueError:
                continue
            myLFES.MLg_pos[idxG, g] = 1
    myLFES.MLP_pos[:, myLFES.numTransformProcess:] = kron(myLFES.MLg_pos,np.ones((1, myLFES.numTransportProcess))).todense()
    print("I am exiting calcMLP.py")


def calcMRT(myLFES):
    '''
    This function calculates the positive and negative hetero-functional incidence tensors.
    :param LFES:
    :return:
    '''
    print("I am entering calcMRT.py")
    calcMRTneg(myLFES)
    calcMRTpos(myLFES)
    myLFES.MRTproj = myLFES.MRTproj_pos - myLFES.MRTproj_neg
    myLFES.MRT = myLFES.MRT_pos - myLFES.MRT_neg
    print("I am exiting calcMRT.py")


def calcMRTneg(myLFES):
    """
    This function computes the projected and un-projected forms of the
    negative hetero-functional incidence tensor as well as the 4th order tensor.
    :param LFES:
    :return:
    """
    print("I am entering calcMRTneg.py")
    MRT_neg = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.numProcesses * myLFES.numResources, 1), dtype=bool)
    MRTproj_neg = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.DOFS, 1), dtype=bool)
    for i in range(myLFES.numOperands):
        for y2 in range(myLFES.numBuffers):
            # Find elementary basis vector of i{th} operand
            e_i = getElVec(i, myLFES.numOperands)
            # Find elementary basis vector corresponding to buffer y2
            e_y2 = getElVec(y2, myLFES.numBuffers)
            # Find outer product of e_i and e_y2
            e_iy2 = sparse.outer(e_i, e_y2)
            # Compute Xiy2plus and vectorize it
            Xiy1V = Xiy1minus(i, y2, myLFES).T.reshape((myLFES.numProcesses * myLFES.numResources, 1)[::-1]).T.tocsr()
            # Vectorize AS and find union with Xiy2V
            ASV = myLFES.AS.reshape((myLFES.numProcesses * myLFES.numResources, 1), order='F').tocsr()
            Xiy1VP = ASV.multiply(Xiy1V)
            # Add to MRT_pos
            MRT_neg += sparse.outer(e_iy2, Xiy1VP)
            # Add projection
            dof_projection = applyProjMat(Xiy1V, ASV)
            MRTproj_neg += sparse.outer(e_iy2, dof_projection)
    myLFES.MRT_neg = MRT_neg.sum(axis=3)
    myLFES.MRTproj_neg = MRTproj_neg.sum(axis=3)
    myLFES.MRT_neg4 = tensorize(myLFES.MRT_neg,
                                [myLFES.numOperands, myLFES.numBuffers, myLFES.numProcesses, myLFES.numResources],
                                [0, 1, 2], [3])

    print("I am exiting calcMRTneg.py")


def calcMRTpos(myLFES):
    """
    This function computes the projected and un-projected forms of the
    positive hetero-functional incidence tensor as well as the 4th order tensor.
    :param LFES:
    :return:
    """
    print("I am entering calcMRTpos.py")
    MRT_pos = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.numProcesses * myLFES.numResources, 1), dtype=bool)
    MRTproj_pos = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.DOFS, 1), dtype=bool)
    for i in range(myLFES.numOperands):
        for y2 in range(myLFES.numBuffers):
            # Find elementary basis vector of i{th} operand
            e_i = getElVec(i, myLFES.numOperands)
            # Find elementary basis vector corresponding to buffer y2
            e_y2 = getElVec(y2, myLFES.numBuffers)
            # Find outer product of e_i and e_y2
            e_iy2 = sparse.outer(e_i, e_y2)
            # Compute Xiy2plus and vectorize it
            Xiy2V = Xiy2plus(i, y2, myLFES).T.reshape((myLFES.numProcesses * myLFES.numResources, 1)[::-1]).T.tocsr()
            # Vectorize AS and find union with Xiy2V
            ASV = myLFES.AS.reshape((myLFES.numProcesses * myLFES.numResources, 1), order='F').tocsr()
            Xiy2VP = ASV.multiply(Xiy2V)
            # Add to MRT_pos
            MRT_pos += sparse.outer(e_iy2, Xiy2VP)
            # Add projection
            dof_projection = applyProjMat(Xiy2V, ASV)
            MRTproj_pos += sparse.outer(e_iy2, dof_projection)
    myLFES.MRT_pos = MRT_pos.sum(axis=3)
    myLFES.MRTproj_pos = MRTproj_pos.sum(axis=3)
    myLFES.MRT_pos4 = tensorize(myLFES.MRT_pos,[myLFES.numOperands, myLFES.numBuffers, myLFES.numProcesses, myLFES.numResources],[0, 1, 2], [3])
    print("I am exiting calcMRTpos.py")


def calcARBasic(LFES):
    '''
    This function calculates the hetero-functional adjacency matrix for verbodeMode = 0 (Basic).
    :param LFES:
    :return:
    '''
    print("I am entering calcARbasic.py")
    sP = LFES.numTransformProcess + LFES.numTransportRefProcess
    sR = LFES.numResources
    sM = LFES.numMachines
    sBs = LFES.numBuffers
    sPM = LFES.numTransformProcess
    sPH = LFES.numTransportProcess
    idxL = vstack([LFES.AS.T.tolil().reshape((1, LFES.numResources * LFES.numProcesses))], format='csr')
    idxN = csr_matrix.nonzero(idxL)[1]
    idxAR = np.zeros((len(idxN) ** 2, 2), dtype=int)
    DOFpair = np.zeros((len(idxN) ** 2, 2), dtype=int)
    C = [False] * 5
    c = 0
    c1 = 0
    c2 = 0
    c3 = 0
    c4 = 0
    c5 = 0
    # Initialize Function Sequence Constraints
    if len(LFES.abstract.methodPair.name1) > 0:
        C5 = calcFunSequenceCBasic(LFES)
        C5trueindex = set(zip(C5.nonzero()[0], C5.nonzero()[1]))
        myMethods = 1
    else:
        myMethods = 0
    # Initialize Indices
    w, v = resolvePsiIndex(idxN, sP)
    k = resolveResourceIndexVec(v, sM)
    j, _, u = resolveProcessIndexVec(w, sPM, sPH)

    for i1 in range(len(idxN)):
        k1 = k[i1]
        j1 = j[i1]
        u1 = u[i1]

        for i2 in range(len(idxN)):
            k2 = k[i2]
            j2 = j[i2]
            u2 = u[i2]

            condition1 = (k1 == k2 and k1 > 0 and k2 > 0 and j1 > 0 and j2 > 0)
            condition2 = (k1 == math.floor((u2 - 1) / sBs) + 1 and k1 > 0 and j1 > 0 and u2 > 0)
            condition3 = (k2 == ((u1 - 1) % sBs) + 1 and k2 > 0 and j2 > 0 and u1 > 0)
            condition4 = (((((u1 - 1) % sBs) + 1 == math.floor((u2 - 1) / sBs) + 1 or (
                    (u1 - 1) % sBs) + 1 == k2) and u1 > 0 and u2 > 0))
            condition5 = (i1, i2) in C5trueindex
            if condition1:
                C[0] = True
                c1 += 1
            elif condition2:
                C[1] = True
                c2 += 1
            elif condition3:
                C[2] = True
                c3 += 1
            elif condition4:
                C[3] = True
                c4 += 1

            if myMethods == 1:
                if condition5:
                    C[4] = True
                    c5 += 1
            if condition1 or condition2 or condition3 or condition4:
                if condition5 or (myMethods == 0):
                    idxAR[c, :] = [idxN[i1], idxN[i2]]
                    DOFpair[c, :] = [i1, i2]
                    c += 1
            C = [False] * 5

    idxAR = idxAR[0:c, :]
    DOFpair = DOFpair[0:c, :]

    LFES.idxAR = idxAR
    LFES.idxARproj = DOFpair
    d = [True] * len(DOFpair)
    LFES.ARproj = csr_matrix((d, (DOFpair[:, 0], DOFpair[:, 1])), shape=(LFES.DOFS, LFES.DOFS), dtype=bool)

    d = [True] * len(idxAR)
    if sP * sR < 10 ** 9 and c < 100000:
        LFES.AR = csr_matrix((d, (idxAR[:, 0], idxAR[:, 1])), shape=(sP * sR, sP * sR), dtype=bool)

    LFES.DOFR = c
    LFES.DOFR1 = c1
    LFES.DOFR2 = c2
    LFES.DOFR3 = c3
    LFES.DOFR4 = c4
    LFES.DOFR5 = c5
    print("I am exiting calcARbasic.py")


def resolvePsiIndex(psi, sP):
    '''
    This function resolves the index psi to provide the index of the process w and the index of the resource v.
    :param psi:
    :param sP: sum of numTransformProcess and numTransportRefProcess
    :return w: index of process
    :return v: index of resource
    '''
    print("I am entering resolvePsiIndex.py")
    v = []
    w = []
    for i in psi:
        v.append(math.floor((i)/sP)+1)
        w.append(((i) % sP)+1)
    print("I am exiting resolvePsiIndex.py")
    return w, v


def resolveResourceIndexVec(v, sM):
    '''
    This function resolves the resource index v to provide the index of the machine k.
    :param v: resource index
    :param sM: numMachines
    :return k: machine index
    '''
    print("I am entering resolveResourceIndexVec.py")
    k = np.zeros(len(v))
    idxV = [idx for idx, val in enumerate(v) if val <= sM]
    k[0:len(idxV)] = [v[i] for i in idxV]
    k = k.astype('int')
    print("I am exiting resolveResourceIndexVec.py")
    return k


def resolveProcessIndexVec(w, sPM, sPH):
    '''
    This function calculates all process indicies.
    :param w: process index
    :param sPM: numTransformProcess
    :param sPH: numTransportProcess
    :return j:DOF processes with transformation process indices filled in.
    :return g:DOF processes with holding process indices filled in.
    :return u:DOF processes with transportation process indices filled in.
    '''
    print("I am entering resolveProcessIndexVec.py")
    j = np.zeros_like(w)
    rho = np.zeros_like(w)
    g = np.zeros_like(w)
    u = np.zeros_like(w)
    idxW1 = [idx for idx, val in enumerate(w) if val <= sPM]
    idxW2 = [idx for idx, val in enumerate(w) if val > sPM]
    j[idxW1] = np.array(w)[idxW1]
    rho[idxW2] = np.array(w)[idxW2] - sPM
    g[idxW2] = np.vectorize(math.floor, otypes=[np.float])((rho[idxW2] - 1) / sPH) + 1 + sPM
    u[idxW2] = ((rho[idxW2] - 1) % sPH) + 1
    print("I am exiting resolveProcessIndexVec.py")
    return j, g, u


def calcFunSequenceCBasic(LFES):
    '''
    This function calculates the Functional Sequence Constraints for the
    Hetero-functional Adjacency Matrix.  These constraints need to be
    satisfied on top of the physical continuity constraints. 
 
    The element (idx1,idx2) in C5 is filled if and only if the method pair 
    (idx1,idx2) exists. 
    The code checks if the method pair for element (idx1,idx2) exists by
    looping through all method pairs. For each method pair, the loop finds
    all (idx1,idx2) combinations that adhere to that specific method pair.
    
    :param LFES:
    :return C5: csr sparse matrix of size E_S by E_S
    '''
    print("I am entering calcFunSequenceCBasic.py")
    myDOFprocIDX = [LFES.AS.nonzero()[0][i] for i in np.argsort(LFES.AS.nonzero()[1])]
    temp = LFES.setTransformProcess + LFES.setTransportRefProcess
    myDOFprocList = [temp[i] for i in myDOFprocIDX]
    C5 = lil_matrix((LFES.DOFS, LFES.DOFS), dtype=bool)
    for k1 in range(len(LFES.abstract.methodPair.name1)):
        C5new = lil_matrix((LFES.DOFS, LFES.DOFS), dtype=bool)
        idx1AL = np.array([1 if LFES.abstract.methodPair.name1[k1] in element else 0 for element in myDOFprocList])
        if LFES.abstract.methodPair.name1[k1] == "transport":
            idx1c = np.array([1 if "store" in element else 0 for element in myDOFprocList])
            idx1AL = np.logical_or(idx1AL, idx1c)
        if LFES.abstract.methodPair.ref1[k1]:
            idx1BL = np.zeros(LFES.DOFS)
            for k2 in range(LFES.DOFS):
                temp = "- " + LFES.abstract.methodPair.ref1[k1] + " -" in myDOFprocList[k2]
                idx1BL[k2] = temp
            idx1L = np.logical_and(idx1AL, idx1BL)
        else:
            idx1L = idx1AL
        idx2AL = np.array([1 if LFES.abstract.methodPair.name2[k1] in element else 0 for element in myDOFprocList])
        if LFES.abstract.methodPair.name2[k1] == "transport":
            idx2c = np.array([1 if "store" in element else 0 for element in myDOFprocList])
            idx2AL = np.logical_or(idx2AL, idx2c)
        if LFES.abstract.methodPair.ref2[k1]:
            idx2BL = np.zeros(LFES.DOFS)
            for k2 in range(LFES.DOFS):
                temp = "- " + LFES.abstract.methodPair.ref2[k1] + " -" in myDOFprocList[k2]
                idx2BL[k2] = temp
            idx2L = np.logical_and(idx2AL, idx2BL)
        else:
            idx2L = idx2AL
        idx1N = np.nonzero(idx1L)[0]
        idx2N = np.nonzero(idx2L)[0]
        for k2 in idx1N:
            for k3 in idx2N:
                C5new[k2, k3] = True
        C5 = (C5 + C5new).astype(bool)
    C5 = C5.tocsr()
    print("I am exiting calcFunSequenceCBasic.py")
    return C5


def calcARPar(LFES):
    '''
    This function calculates the hetero-functional adjacency matrix for verbodeMode = 1 (Parallelized).
    :param LFES:
    :return:
    '''
    print("I am entering calcARPar.py")

    sP = LFES.numTransformProcess + LFES.numTransportRefProcess
    sM = LFES.numMachines
    sPM = LFES.numTransformProcess
    sPH = LFES.numTransportProcess
    As = LFES.AS
    idxN = vecL(As)
    idxN = np.sort(idxN)
    w, v = resolvePsiIndex(idxN, sP)
    k = resolveResourceIndexVec(v, sM)
    j, g, u = resolveProcessIndexVec(w, sPM, sPH)
    procIdx = j + g - 1
    numProcessors = 4
    dataDiv = np.linspace(0, len(idxN), numProcessors + 1, dtype='int')
    print('in AR loop with %d processors' % (numProcessors))
    start_time = time.time()
    executor = ProcessPoolExecutor(max_workers=numProcessors)
    futures = [executor.submit(calcARLoop, LFES, dataDiv[k1], dataDiv[k1 + 1], idxN, k, j, u, procIdx) for k1 in
               range(numProcessors)]
    executor.shutdown(wait=True)
    print("AR creation %s seconds ---" % (time.time() - start_time))
    importidxARandARprojPair(LFES)
    LFES.DOFR = len(LFES.idxARproj)
    print("I am exiting calcARPar.py")


def vecL(A):
    '''
    This function returns a vectorized (one-dimensional) version of matrix A.
    :param A: sparse matrix
    :return idxN3: one-dimensional array
    '''
    idxN1 = np.nonzero(A)[0]
    idxN2 = np.nonzero(A)[1]
    m = A.shape[0]
    idxN3 = [m*(i)+j for i, j in zip(idxN2, idxN1)]
    return(idxN3)


def calcARLoop(LFES, start_split, end_split, idxN, k, j, u, procIdx):
    '''
    This function is called within calcARPar and is used to generate idxAR and DOFpair
    for a segment of data between start_split and end_split. Each call to calcARLoop
    generates two csv files.
    :param LFES:
    :param start_split: data segment starting point
    :param end_split: data segment ending point
    :param idxN: vectorized AS matrix
    :param k: machine index
    :param j:
    :param u:
    :param procIdx: process index
    '''
    print('[pid:%s] entering calcARLoop on range starting %s' % (os.getpid(), start_split))
    idxAR = np.zeros((len(idxN) ** 2, 2), dtype=int)
    DOFpair = np.zeros((len(idxN) ** 2, 2), dtype=int)
    sBs = LFES.numBuffers
    # Initialize Function Sequence Constraints
    if len(LFES.abstract.methodPair.name1) > 0:
        myMethods = 1
    else:
        myMethods = 0
    c = 0
    for i1 in range(start_split, end_split):
        k1 = k[i1]
        j1 = j[i1]
        u1 = u[i1]
        procIdx1 = procIdx[i1]
        for i2 in range(len(idxN)):
            k2 = k[i2]
            j2 = j[i2]
            u2 = u[i2]
            procIdx2 = procIdx[i2]
            condition1 = (k1 == k2 and k1 > 0 and k2 > 0 and j1 > 0 and j2 > 0)
            condition2 = (k1 == math.floor((u2 - 1) / sBs) + 1 and k1 > 0 and j1 > 0 and u2 > 0)
            condition3 = (k2 == ((u1 - 1) % sBs) + 1 and k2 > 0 and j2 > 0 and u1 > 0)
            condition4 = (((((u1 - 1) % sBs) + 1 == math.floor((u2 - 1) / sBs) + 1 or (
                    (u1 - 1) % sBs) + 1 == k2) and u1 > 0 and u2 > 0))
            if myMethods == 1:
                temp1 = [LFES.abstract.methodPair.idxProc1[k1] == 0 for k1 in
                         range(len(LFES.abstract.methodPair.idxProc1))]
                temp2 = [LFES.abstract.methodPair.idxProc2[k1] == 0 for k1 in
                         range(len(LFES.abstract.methodPair.idxProc1))]
                condition5 = any(np.logical_and(temp1, temp2))
            if condition1 or condition2 or condition3 or condition4:
                if condition5 or myMethods == 0:
                    idxAR[c, :] = [idxN[i1], idxN[i2]]
                    DOFpair[c, :] = [i1, i2]
                    c += 1
    idxAR = idxAR[0:c, :]
    DOFpair = DOFpair[0:c, :]
    df_1 = pd.DataFrame(idxAR)
    df_2 = pd.DataFrame(DOFpair)
    idxARfilename = ('ARData/[pid:%s]_idxAR_calculation_on_range_starting_%s' % (os.getpid(), start_split))
    DOFPairfilename = ('ARData/[pid:%s]_DOFPair_calculation_on_range_starting_%s' % (os.getpid(), start_split))
    df_1.to_csv(idxARfilename + '.csv', index=False)
    df_2.to_csv(DOFPairfilename + '.csv', index=False)
    print('[pid:%s] calculation on range starting %s complete with %s DOF' % (os.getpid(), start_split, c))


def importidxARandARprojPair(LFES):
    '''
    This function is called within calcARPar and loads in DOF-pairs
    from the csv files produced in calcARLoop.
    :param LFES:
    :return:
    '''
    print("I am entering importidxARandARprojPair.py")
    filenames = glob.glob('ARData/*idxAR'+"*.csv")
    dfs = []
    for filename in filenames:
        dfs.append(pd.read_csv(filename))
    LFES.idxAR = pd.concat(dfs, ignore_index=True).to_numpy()
    filenames = glob.glob('ARData/*DOFPair'+"*.csv")
    dfs = []
    for filename in filenames:
        dfs.append(pd.read_csv(filename))
    LFES.idxARproj = pd.concat(dfs, ignore_index=True).to_numpy()
    print("I am exiting importidxARandARprojPair.py")


def calcARInc(LFES):
    '''
    This function calculates the hetero-functional adjacency matrix for verboseMode = 3 (Incidence Tensor).
    :param LFES:
    :return:
    '''
    print("I am entering calcARInc")
    MR_neg = matricize(LFES.MRT_neg,[1,0],[2]);
    MR_pos = matricize(LFES.MRT_pos,[1,0],[2]);
    
    i_neg = MR_neg.nonzero()
    v_neg = [MR_neg[i_neg[0][i], i_neg[1][i]] for i in range(len(i_neg[0]))]
    i_pos = MR_pos.nonzero()
    v_pos = [MR_pos[i_pos[0][i], i_pos[1][i]] for i in range(len(i_pos[0]))]
    sMR_neg = csr_matrix((v_neg, (i_neg)), shape=(MR_neg.shape[0], MR_neg.shape[1]))
    sMR_pos = csr_matrix((v_pos, (i_pos)), shape=(MR_pos.shape[0], MR_pos.shape[1]))
    AR = dot(sMR_pos.transpose(), sMR_neg)
    LFES.AR = AR
    LFES.idxAR = AR.nonzero()
    
    ic = np.unique(LFES.idxAR, return_inverse=True)[1]
    LFES.idxARproj = np.array([[ic[i], ic[i+int(len(ic)/2)]] for i in range(int(len(ic)/2))])
    LFES.ARproj = csr_matrix((np.ones(len(LFES.idxARproj[:,0])), (LFES.idxARproj[:,0], LFES.idxARproj[:,1])), shape=(LFES.DOFS,LFES.DOFS))
    
    print("I am exiting calcARInc")


def calcARIncJulia(LFES):
    '''
    This function calculates the hetero-functional adjacency matrix for verboseMode = 4.
    :param LFES: the total LFES object
    :param: segments: the number of segments to calculate A_rho with
    :return:
    '''
    print("I am entering calcARIncJulia")
    MR_neg = matricize(LFES.MRT_neg, [1, 0], [2])
    MR_pos = matricize(LFES.MRT_pos, [1, 0], [2])

    LFES.MR_neg = MR_neg
    LFES.MR_pos = MR_pos

    # export mats to CSV
    np.savetxt("MR_neg.csv", np.transpose(MR_neg.nonzero()), delimiter=",", header="buffer,DOF", comments='')
    np.savetxt("MR_pos.csv", np.transpose(MR_pos.nonzero()), delimiter=",", header="buffer,DOF", comments='')

    juliaPath = "./VirtualEnv/Julia-1.7.app/Contents/resources/julia/bin/"
    os.system(juliaPath + "julia calcARJulia.jl")

    LFES.idxAR = pd.read_csv("ARIdx.csv")


def methodsToInc(myLFES):
    """
    This function sets up all the incidence matrices to calculate A_rho from indices
    :param: LFES: the LFES object whose incidence matrices will be populated
    :return:
    """
    print('I am entering methodsToInc')
    myLFES.DOFS = len(myLFES.methodsxForm.idxProc) + len(myLFES.methodsxPort.idxProc)

    myLFES.numTransformProcess = max(myLFES.methodsxForm.idxProc) + 1
    myLFES.numTransportProcess = myLFES.numBuffers**2
    myLFES.numHoldingProcesses = len(myLFES.abstract.methodsxPort.ref)
    myLFES.numTransportRefProcess = myLFES.numBuffers**2*myLFES.numHoldingProcesses
    myLFES.numProcesses = myLFES.numTransformProcess + myLFES.numTransportRefProcess
    myLFES.numResources = max(max(myLFES.methodsxForm.resource), max(myLFES.methodsxPort.resource)) + 1
    MRT_neg = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.numResources*myLFES.numProcesses), dtype=np.uint8)
    MRT_pos = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.numResources*myLFES.numProcesses), dtype=np.uint8)
    AS = DOK((myLFES.numProcesses, myLFES.numResources), dtype=np.uint8)
    # MRTproj_neg = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.DOFS), dtype=int)
    # MRTproj_pos = DOK((myLFES.numOperands, myLFES.numBuffers, myLFES.DOFS), dtype=int)
    for k1 in range(len(myLFES.methodsxForm.idxProc)):
        AS[myLFES.methodsxForm.idxProc[k1], myLFES.methodsxForm.resource[k1]] = 1
        if myLFES.methodsxForm.operand[k1] != "":
            for k2 in myLFES.methodsxForm.operand[k1].split(', '):
                dof = myLFES.methodsxForm.resource[k1] * myLFES.numProcesses + myLFES.methodsxForm.idxProc[k1]
                MRT_neg[int(k2), myLFES.methodsxForm.resource[k1], dof] = 1
                # MRTproj_neg[int(k2), int(myLFES.methodsxForm.resource[k1]), k1] = 1
        if myLFES.methodsxForm.output[k1] != "":
            for k2 in myLFES.methodsxForm.output[k1].split(', '):
                dof = myLFES.methodsxForm.resource[k1] * myLFES.numProcesses + myLFES.methodsxForm.idxProc[k1]
                MRT_pos[int(k2), myLFES.methodsxForm.resource[k1], dof] = 1
                # MRTproj_pos[int(k2), int(myLFES.methodsxForm.resource[k1]), k1] = 1

    for k3 in range(len(myLFES.methodsxPort.idxProc)):
        transRefProc = myLFES.methodsxPort.ref[k3] * myLFES.numTransportProcess + myLFES.methodsxPort.origin[k3] * myLFES.numBuffers + myLFES.methodsxPort.dest[k3]
        AS[transRefProc + myLFES.numTransformProcess, myLFES.methodsxPort.resource[k3]] = 1
        if myLFES.methodsxPort.operand[k3] != "":
            for k4 in myLFES.methodsxPort.operand[k3].split(', '):
                dof = myLFES.methodsxPort.resource[k3] * myLFES.numProcesses + myLFES.numTransformProcess + transRefProc
                MRT_neg[int(k4), myLFES.methodsxPort.origin[k3], dof] = 1
                # MRTproj_neg[int(k4), int(myLFES.methodsxPort.origin[k3]), k3 + len(myLFES.methodsxForm.idxProc)] = 1
        if myLFES.methodsxPort.output[k3] != "":
            for k4 in myLFES.methodsxPort.output[k3].split(', '):
                dof = myLFES.methodsxPort.resource[k3] * myLFES.numProcesses + myLFES.numTransformProcess + transRefProc
                MRT_pos[int(k4), myLFES.methodsxPort.dest[k3], dof] = 1
                # MRTproj_pos[int(k4), int(myLFES.methodsxPort.dest[k3]), k3 + len(myLFES.methodsxForm.idxProc)] = 1

    coords_neg = np.ndarray(shape=(3,MRT_neg.nnz), dtype=np.int64)
    iter = 0
    for k5 in MRT_neg.data.keys():
        coords_neg[0, iter] = k5[0]
        coords_neg[1, iter] = k5[1]
        coords_neg[2, iter] = k5[2]
        iter += 1
    myLFES.MRT_neg = COO([[0], [0], [0]], 1, shape=(1, 1, 1))
    myLFES.MRT_neg.shape = (myLFES.numOperands, myLFES.numBuffers, myLFES.numResources*myLFES.numProcesses)
    myLFES.MRT_neg.coords = coords_neg
    myLFES.MRT_neg.data = np.ones((1, MRT_neg.nnz),dtype=int)[0]
    # myLFES.MRT_neg4 = tensorize(myLFES.MRT_neg,[myLFES.numOperands, myLFES.numBuffers, myLFES.numProcesses, myLFES.numResources],[0, 1, 2], [3])

    coords_pos = np.ndarray(shape=(3, MRT_pos.nnz), dtype=np.int64)
    iter = 0
    for k5 in MRT_pos.data.keys():
        coords_pos[0, iter] = k5[0]
        coords_pos[1, iter] = k5[1]
        coords_pos[2, iter] = k5[2]
        iter += 1
    myLFES.MRT_pos = COO([[0], [0], [0]], 1, shape=(1, 1, 1))
    myLFES.MRT_pos.shape = (myLFES.numOperands, myLFES.numBuffers, myLFES.numResources * myLFES.numProcesses)
    myLFES.MRT_pos.coords = coords_pos
    myLFES.MRT_pos.data = np.ones((1, MRT_pos.nnz),dtype=int)[0]
    # myLFES.MRT_pos4 = tensorize(myLFES.MRT_pos,[myLFES.numOperands, myLFES.numBuffers, myLFES.numProcesses, myLFES.numResources], [0, 1, 2], [3])

    coords_AS = np.ndarray(shape=(2, AS.nnz), dtype=np.int64)
    iter = 0
    for k5 in AS.data.keys():
        coords_AS[0, iter] = k5[0]
        coords_AS[1, iter] = k5[1]
        iter += 1
    myLFES.AS = COO([[0], [0]], 1, shape=(1, 1))
    myLFES.AS.shape = (myLFES.numProcesses, myLFES.numResources)
    myLFES.AS.coords = coords_AS
    myLFES.AS.data = np.ones((1, AS.nnz), dtype=int)[0]
    # myLFES.MRT = myLFES.MRT_pos - myLFES.MRT_neg


def matricize(ATensor, R, C):
    '''
    This function transforms a tensor into a 2-D matrix.
    :param ATensor: tensor to be transformed
    :param R: dimension indicies to be merged
    :param C: dimension indicies to be maintained
    :return: AMatrix: matrix form of the input tensor
    '''
    print("I am entering matricize.py")
    P = list(ATensor.shape)
    J = np.prod([P[i] for i in R])
    K = [P[i] for i in C]
    K.append(J)
    R = np.array(R)

    AMatrix = COO([[0]] * len(K), 1, shape=(1, 1))
    AMatrix.shape = K
    AMatrix.data = ATensor.data
    coords = ATensor.coords
    newReshape = np.ndarray(shape=(len(K), ATensor.nnz), dtype=np.int64)

    flattend = coords[R[0]]
    for k1 in range(len(R) - 1):
        flattend = flattend + coords[R[k1 + 1]] * P[R[k1]]

    newReshape[min(R)] = flattend
    K[min(R)] = J
    for k2 in C:
        if sum(R < k2):
            K[k2 - sum(R < k2) + 1] = P[k2]
            newReshape[k2 - sum(R < k2) + 1] = coords[k2]
        else:
            K[k2] = P[k2]
            newReshape[k2] = coords[k2]

    AMatrix.coords = newReshape
    AMatrix.shape = tuple(K)

    print("I am exiting matricize.py")
    return AMatrix


def tensorize(AMatrix, P, R, C):
    '''
    This function transforms a 2-D matrix into a tensor.
    :param AMatrix: the matrix to be transformed
    :param P: int array holding new dimensions of tensor
    :param R: int array corresponding to order of dimension indices
    :param C: int array corresponding to final dimension index
    :return ATensor: Tensorized version of AMatrix
    '''
    # print('I am entering tensorize.py')
    dims = [P[i] for i in R + C]
    order = R + C
    ATensor = COO(AMatrix.T).reshape(dims[::-1]).T.transpose(axes=order)
    # print('I am exiting tensorize.py')
    return ATensor


def getElVec(k, n):
    """
    Calculates elementary basis vector of length n with
    a non-zero value at position k.
    :param: k (int): Position where vector is non-zero.
    :param: n (int): Size of the vector
    :return: x (COO): elementary basis vector as COO sparse array
    """
    # print("I am entering getElVec.py")
    # Initialize a DOK sparse array of dimension (n,)
    x = DOK(shape=(n,), dtype=bool)
    # Assign value to be true at kth position
    if k >= 0:
        x[k] = True
    # print("I am exiting getElVec.py")
    return sparse.COO(x)


def Xiy1minus(i, y1, myLFES):
    """
    A matrix with the same dimension as the system concept A_s, which indicates
    where the associated process both withdraws input operand l_i and originates at the buffer bs_y1.
    Corresponds to equation 65 in the paper titled
    "A Tensor-Based Formulation of Hetero-functional Graph Theory"

    :param: i (int): Index of system operand.
    :param: y1 (int): Index of origin buffer
    :param: myLFES (object): Instance of the LFES class.
    :return: Xiy1minus (DOK): Matrix indicating system process pulling operand i and originating at buffer y1.
    """
    # print("I am entering Xiy1minus.py")
    myLFES.M_minus_LP_mu = myLFES.MLP_neg[:, 0:myLFES.numTransformProcess]
    if y1 < myLFES.numMachines:
        a = sparse.dot(sparse.dot(sparse.COO(myLFES.M_minus_LP_mu).T, \
                                  getElVec(i, myLFES.numOperands).reshape((myLFES.numOperands, 1))), \
                       getElVec(y1, myLFES.numMachines).reshape((myLFES.numMachines, 1)).T)
    else:
        a = sparse.COO(DOK((myLFES.numTransformProcess, myLFES.numMachines), dtype=bool))
    b = coo_matrix((myLFES.numTransformProcess, myLFES.numResources - myLFES.numMachines), dtype=bool)
    a = COO.to_scipy_sparse(a)
    uh = hstack((a, b))
    c = sparse.dot(sparse.COO(myLFES.MLg_neg).T, getElVec(i, myLFES.numOperands).reshape((myLFES.numOperands, 1)))
    d = sparse.kron(getElVec(y1, myLFES.numBuffers).reshape((myLFES.numBuffers, 1)),
                    np.array([[True] * myLFES.numBuffers]).T)
    e = sparse.COO(np.array([[True] * myLFES.numResources]))
    bh = COO.to_scipy_sparse(sparse.kron(sparse.kron(c, d), e))
    xiyiminus = vstack((uh, bh))
    # print("I am exiting Xiy1minus.py")
    return xiyiminus


def Xiy2plus(i, y2, myLFES):
    """
    A matrix with the same dimension as the system concept A_s, which indicates
    where the associated process both injects input operand l_i and at destination buffer bs_y2.
    Corresponds to equation 67 in the paper titled
    "A Tensor-Based Formulation of Hetero-functional Graph Theory"

    :param: i (int): Index of system operand.
    :param: y2 (int): Index of destination buffer
    :param: myLFES (object): Instance of the LFES class.
    :return: Xiy2plus (COO): Matrix indicating system process pushing operand i at destination buffer y2.
    """
    # print("I am entering Xiy2plus.py")
    myLFES.M_plus_LP_mu = myLFES.MLP_pos[:, 0:myLFES.numTransformProcess]
    if y2 < myLFES.numMachines:
        a = sparse.dot(sparse.dot(sparse.COO(myLFES.M_plus_LP_mu).T, \
                                  getElVec(i, myLFES.numOperands).reshape((myLFES.numOperands, 1))), \
                       getElVec(y2, myLFES.numMachines).reshape((myLFES.numMachines, 1)).T)
    else:
        a = sparse.COO(DOK((myLFES.numTransformProcess, myLFES.numMachines), dtype=bool))
    b = coo_matrix((myLFES.numTransformProcess, myLFES.numResources - myLFES.numMachines), dtype=bool)
    a = COO.to_scipy_sparse(a)
    uh = hstack((a, b))
    c = sparse.dot(sparse.COO(myLFES.MLg_pos).T, getElVec(i, myLFES.numOperands).reshape((myLFES.numOperands, 1)))
    d = sparse.kron(np.array([[True] * myLFES.numBuffers]).T,
                    getElVec(y2, myLFES.numBuffers).reshape((myLFES.numBuffers, 1)))
    e = sparse.COO(np.array([[True] * myLFES.numResources]))
    bh = COO.to_scipy_sparse(sparse.kron(sparse.kron(c, d), e))
    xiy2plus = vstack((uh, bh))
    # print("I am exiting Xiy2plus.py")
    return xiy2plus


def applyProjMat(Matrix, ASV):
    """
    This function applies the projection operation
    :param: Matrix: Vectorized matrix to be projected upon
    :param: ASV: Vectorized AS matrix
    :return: Projected_Matrix: Projected Matrix.
    """
    # print("I am entering applyProjMat.py")
    Projected_Matrix = Matrix[np.sort(np.nonzero(ASV)[0]), :]
    # print("I am exiting applyProjMat.py")
    return Projected_Matrix


def combineHFAMandCADM(LFES):
    '''
    This function combines DOFS & HFAM with CAM & CADM.
    :param LFES:
    :return:
    '''
    print("I am entering combineHFAMandCADM.py")
    idxResources = np.sort(LFES.AS.nonzero()[1])
    controlDOF = lil_matrix((LFES.DOFS, LFES.numControllers), dtype=bool)
    for k1 in range(LFES.DOFS):
        controlDOF[k1, :] = LFES.CAM[idxResources[k1], :]
    SystemAdjacencyMatrix = hstack([LFES.ARproj, controlDOF])
    ControlPart = hstack([controlDOF.transpose(), LFES.CADM])
    SystemAdjacencyMatrix = vstack([SystemAdjacencyMatrix, ControlPart])
    LFES.partialSAMproj = SystemAdjacencyMatrix.tocsr()
    print("I am exiting combineHFAMandCADM.py")

