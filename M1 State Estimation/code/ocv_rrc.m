clc; clear; close all;

%% Load the Driving Cycle Current Data
Batt = readtable("../data/driving_profile-1.csv","VariableNamingRule","preserve");
soc_ocv = readtable("../data/soc_ocv_profile-3.csv","VariableNamingRule","preserve");
Current = Batt(1:500,"Current (A)");
T = Batt(:,"Time (s)");

%% Call Function
[Voltage, SoC] = OCVRRC_SS(Current);

%% Plot 
subplot(3,1,1)
plot(Voltage)
title("Voltage")

subplot(3,1,2)
plot(SoC)
title("State of Charge (SoC)")

subplot(3,1,3)
plot(Current.Variables)
title("Current")
