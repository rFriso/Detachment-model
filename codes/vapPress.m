function ps = vapPress(T)

% Function for calculating the vapour pressure for humid air
%
% Input:
% - T, local wall temperature [K]

if T<100
    A = 8.07131;
    B = 1730.63;
    C = 233.426;
    ps = 10^(A-B/(C+T))*133.3;
else
    A = 8.14019;
    B = 1810.94;
    C = 244.485;
    ps = 10^(A-B/(C+T))*133.3;
end
