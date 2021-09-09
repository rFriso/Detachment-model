function Fd = dragForce(rhoF, u, dp, muF, CSF)

% Function for calculating the Drag force
%
% Input:
% - rhoF, Fluid density [kg/m^3]
% - u, friction velocity [m/s]
% - dp, particle diameter [m]
% - muF, fluid dynamic viscosity [mPa s]
% - CSF, mean particle shape factor
% - mp, particle mass [kg]
% - rhoP, particle density [kg/m^3]

CSF = normrnd(CSF, 0.1, size(u));
if CSF >= 1 CSF=1;
elseif CSF <= 0 CSF = 0;
end
Rep = rhoF .* u.^2 .* dp / muF;
Fst = CSF.^(-0.18);
Fne = sqrt(6)./CSF - 1;
Rep_star = Fne.*Rep./Fst;
CdShape = (24*Fne./Rep.*(1+0.1*Rep_star.^0.6))+0.3;
Fd = 0.5*pi*(dp/2)^2*CdShape.*rhoF.*u.^2;