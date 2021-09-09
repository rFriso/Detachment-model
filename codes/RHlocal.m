function RH_loc = RHlocal(p, T)

% Function for calculating the local relative humidity
%
% Input:
% - p, local wall pressure [Pa]
% - T, local wall temperature [K]

%Assigned inlet data
RH_inlet = 0.5;     %inlet relative humidity
T_inlet = 293.15;   %Inlet temperature [K]
p_inlet = 101325;   %Inlet pressure [Pa]

%Vapour pressure calculation
ps_inlet = vapPress(T_inlet);

%Absolute humidity
x = 0.622*(RH_inlet*ps_inlet)/(p_inlet-RH_inlet*ps_inlet);

RH_loc = zeros(size(p));
for i = 1:length(p)
    ps_wall = vapPress(T(i));
    RH_loc(i) = x*p(i)/(0.622*ps_wall+x*ps_wall);
end




