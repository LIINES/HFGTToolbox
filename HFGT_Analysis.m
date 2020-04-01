close all
clear all
clc 

XMLFile='Example_Network.xml';
% XMLFile='Trimetrica-3layer-Data-v9.xml';
%% Section:  Construct myLFES "raw" Structure
[myLFES,S]=XML2LFES(XMLFile)

%% Section:  Make myLFES "full"
myLFES=raw2FullLFES(myLFES)