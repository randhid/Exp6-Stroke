%% clear

clc;
clear;
close all;
addpath(pwd);


%% Ankle ROM and Plots for one subject:

[ogROM, tmROM] =AnkleAnalysis('*000', 1);

%% AnkleROM and PLots of all subjects

Subject_List = ["sub000", "sub001", "sub002", "sub003", "sub004", ...
    "sub005", "sub006", "sub007"];

allogROM = []; alltmROM = [];

for i  = 1:length(Subject_List)
    [allogROM, alltmROM] =AnkleAnalysis( char( Subject_List(i) ) );
    %allogROM = [allogROM, ogROM];
    %alltmROM = [alltmROM, tmROM];
end