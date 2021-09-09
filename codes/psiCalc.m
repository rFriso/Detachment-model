function psi = psiCalc(RH)

% Function for calculating the filling angle
%
% Input:
% - RH, relative humidity

% Data assumed constant
R = 8.31446;                        % Gas costant               [J/(molK)]
T = 293.15;                         % Temperature               [K]
V = 1.8*10^-5;                      % Molar Volume              [m^3/mol]
gamma = 0.0735;                     % sup. tension              [N/m]
teta1 = (48*pi/180);                % 48° silicio 
teta2 = (80*pi/180);                % 80° acciaio inossidabile
D = 4*10^-10;                       % Contact distance          [m]
r = 0.5*10^-6;                       % Particle radius           [m]

% Filling angle estimation
psi = zeros(size(RH));
psi_angle = zeros(size(RH));
options = optimset('MaxIter',1000, 'MaxFunEvals',1000);

for i = 1:length(RH)
    eqn = @(x) abs((R*T*log(RH(i))/(V*gamma)) + ((cos(teta1+x)+cos(teta2))/(2*r*(1-cos(x)))) - (sin(teta1+x)/(2*r*sin(x))));
    psi(i) = fminsearch(eqn, 0.1, options);
    psi_angle(i) = rad2deg(psi(i));
end