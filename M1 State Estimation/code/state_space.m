clc; clear; close all

%% Define Parameters in State Space model
c = 0.5;
k = 1;
m = 1;

%% Define the State-space model
A = [0 1; -k/m -c/m];
B = [0; 1/m];
C = [1 0];
D = [0];

%% Create State-space model
ss_model = ss(A,B,C,D)
step(ss_model)