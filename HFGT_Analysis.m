close all
clear all
clc 
addpath('1-XML2LFES/')
addpath('2-Raw2FullLFES/')
addpath('3-PetriNets/')
% ensure teh tensor_toolbox is in the working directory search path
% 'https://www.tensortoolbox.org'

XMLFile='Example_Network.xml';
%% Section:  Construct myLFES "raw" Structure
[myLFES,S]=XML2LFES(XMLFile)

%% Section:  Make myLFES "full"
myLFES=raw2FullLFES(myLFES)

%% Section: Call the HFGT GUI
% XMLFILE='Example_Network_PN.xml';
% EventList='exampleEventList_PN.csv';

HFGT_GUI
