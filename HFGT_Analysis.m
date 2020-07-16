close all
clear all
clc 
addpath(genpath('raw2FullLFES'));
addpath(genpath('XML2LFES'));

XMLFile='Example_Network.xml';
% XMLFile='Trimetrica-3layer-Data-v9.xml';
%% Section:  Construct myLFES "raw" Structure
[myLFES,S]=XML2LFES(XMLFile)

%% Section:  Make myLFES "full"
myLFES=raw2FullLFES(myLFES)