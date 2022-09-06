"""
Copyright 2020 LIINES
@company: Thayer School of Engineering at Dartmouth
@lab: LIINES Lab
@Modified: 01/20/2022

"""

from .XML2LFES_Functions import *

def XML2LFES(xmlfile, verboseMode):
    '''
    This function reads the XML input file, instantiates a LFES called myLFES,
    and populates the instance with its constituents, along with their attributes and methods.
    :param xmlFile: Input file representing the system
    :return: myLFES: An instantiated Large Flexible Engineering System object ready to compute HFGT mathematical models
    '''

    print("I am entering XML2LFES.py")
    S = XML2Struct(xmlfile)
    
    # Initialize the LFES Structure
    myLFES = LFES()
    
    # Fill the High LFES Attributes
    insertAttributes(myLFES, S[1].attrib)

    if verboseMode <= 2:
        # Setup Machines
        if 'Machine' in S[2]:
            setupMachines(myLFES, S[1])
        else:
            myLFES.machines.name = []

        # Setup Independent Buffers
        if 'IndBuffer'in S[2]:
            setupIndBuffers(myLFES, S[1])
        else:
            myLFES.indBuffers.name = []

        # Setup Transporters
        if 'Transporter' in S[2]:
            setupTransporters(myLFES, S[1])
        else:
            myLFES.transporters.name = []
    else:
        setupMethodIndicies(myLFES, S[1])
        
    # Setup Services
    if 'Service' in S[2]:
        setupServices(myLFES, S[1])
    else:
        myLFES.services.name = []
        
    # Setup Controllers
    if 'Controller' in S[2]:
        setupControllers(myLFES, S[1])
    else:
        myLFES.controllers.name = []
        
    # Setup Operands
    if 'Operand' in S[2]:
        setupOperands(myLFES, S[1])
    else:
        myLFES.setOperands = []

    # Setup Abstract Transportation Methods
    if 'Abstractions' in S[2]:
        setupAbstractMethods(myLFES, S[1])

    print("I am exiting XML2LFES.py")
    return myLFES
