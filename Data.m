%% Insert Data

clear
close all
clc

ro_sand = 2700;                     % Density of ARD            [kg/m^3]
T = 293.15;                         % Temperature               [K]
R = 8.31446;                        % Gas costant               [J/(molK)]
RH = 0.5;                           % Relative Humidity         
D = 4*10^-10;                       % Contact distance          [m]
V = 1.8*10^-5;                      % Molar Volume              [m^3/mol]
gamma = 0.0735;                     % sup. tension              [N/m]
f = 1.7;                            % Drag correction factor
Kn = 0.1302;                        % Knudsen
Cu = 1+Kn*(1.257+0.4*exp(-1.1/Kn)); % Cunningham
r = 0.5e-6;                         % Particle radius           [m]
teta1 = (48*pi/180);                % 48° silicon 
teta2 = (80*pi/180);                % 80° stainless steel
k = R*T*log(RH)/(V*gamma);          % Curvature of the meniscus [1/m]
rk = 1/k;                           % Curvature radius of the meniscus [m]
thMax = 0.00015;                  % Maximum value of thickness [m]
thMin = 0.000;                  % Minimum value of thickness [m]
dp = 2*r;                           % Particle diameter [m]
muF = 1.2e-5;                       % Fluid dynamic viscosity [mPa s]
CSF = 0.55;                         % Particle shape factor
rhoP = 2700;                        % Particle density [kg/m^3]
mP = rhoP*4/3*pi*r^3;               % Particle mass [kg]
L = 0.02;                           % Target length [m]

%Load CFD data
load("data/CFDdata40.mat");

%%
run('codes/main.m')