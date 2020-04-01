function [myLFES,S]=XML2LFES(xmlFile)
%%  Copyright 2018 Engineering Systems Analytics LLC
%
% This function converts an XML file into an LFES structure (version 2).
% Proposed Usage:  LFES=XML2LFES(XMLFile)
disp(['I am entering ' 'XML2LFES.m'])
S=xml2struct(xmlFile);

%% Initialize the LFES Structure
myLFES = initializeLFES;

%% Fill the High LFES Attributes
myLFES=insertObjB(myLFES,S.LFES.Attributes);

%% Setup Machines
if ismember('Machine',fieldnames(S.LFES))
    myLFES = setupMachines(myLFES, S);
else
    myLFES.machines.names=cell(0);
end

%% Setup Independent Buffers
if ismember('IndBuffer',fieldnames(S.LFES))
    myLFES = setupIndBuffers(myLFES, S);
else
    myLFES.indBuffers.names=cell(0);
end

%% Setup Transporters
if ismember('Transporter',fieldnames(S.LFES))
    myLFES = setupTransporters(myLFES, S);
else
    myLFES.transporters.names=cell(0);
end

%% Setup Controllers
if ismember('Controller',fieldnames(S.LFES))
    myLFES = setupControllers(myLFES, S);
else
    myLFES.controllers.names=cell(0);
end

%% Setup Services
if ismember('Service',fieldnames(S.LFES))
    myLFES = setupServices(myLFES, S);
else
    myLFES.services.names=cell(0);
end

%% Setup Abstract Transportation Methods
if ismember('Abstractions',fieldnames(S.LFES))
    myLFES = setupAbstractTransportationMethods(myLFES, S);
end

%% Setup Transportation Process Abstractions
disp(['I am leaving  ' 'XML2LFES.m']);