%%%%%%%%%%%%%%%%%%%%%%%%%% UNIVERSITY OF FERRARA %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% DEPARTMENT OF ENGINEERING %%%%%%%%%%%%%%%%%%%%%%%%

% Written by: Friso Riccardo, PhD candidate

% Reference: ................

%%

if exist('rho_air')==0
    rho_air = 1.185;
end

%% ADHESION

%Local relative humidity calculation
if exist('RHlocal')~=1
    RH_loc = RHlocal(p, T);
else
    RH_loc = RHlocal;
end

%Local filling angle calculation
psi = psiCalc(RH_loc);

% Hamaker constants
A11 = 5*10^-19;             % sand
A22 = 2.12*10^-19;          % steel
A33 = 3.5*10^-19;           % water

%Composite Hamaker constants
A12 = sqrt(A11*A22);
A23 = sqrt(A22*A33);
A13 = sqrt(A11*A33);

%Total Hamaker constant
A = 1.6*(A12+A33-A23-A13);

% FORCES

% VdW
Fvdw = zeros(size(tauWall));
Fvdw(:,1) = 2*A*r/(12*D^2);

% Capillarity
d = 2*r*sin(psi/2);
r_men = r*sin(psi).*sin(psi+teta1)./sin(110*pi/180);    % Meniscus radius
Fcap = -2*pi*r*gamma*((cos(teta1)+cos(teta2))./(1+D./d) + sin(psi).* ...
    sin(psi+teta1));

% TORQUES
% Capillarity torque
Tlap = Fcap.*r; %r_men;

% VdW torque
Tvdw = Fvdw.*r; %r_men;

% Adhesion torque
Tades = Tlap + Tvdw;
Ta = ones(length(x), length(y))*abs(mean(Tades));

%% DETACHMENT

%System rotation
angle = deg2rad(angleDeg);
if angle~=0
    tauW_x = tWz.*sin(angle) + tWx.*cos(angle);
    tauW_y = tWy;
end

%Friction velocities
uTauX = sqrt(abs(tauW_x)./rho_air);
uTauY = sqrt(abs(tauW_y)./rho_air);

%Drag friction forces
FdX = dragForce(rho_air, uTauX, dp, muF, CSF);
FdY = dragForce(rho_air, uTauY, dp, muF, CSF);

for i = 1:length(x)
    % Thickness calculation
    th = (thMin-thMax)/0.02*x(i)+(thMax+thMin)/2;
    
    % Drag torque
    Md_x (i) = FdX(i)*th;
    Md_y (i) = FdY(i)*th;
    
    % Weigth torque
    Mp (i) = (4/3*pi*r^3*rhoP*th^2*(L/2-y(i))/(2*dp^2));

    My (i) = Md_y(i) + Mp(i);
    Md (i) = sqrt(Md_x(i)^2+Md_y(i)^2);
    
    % Total detachment torque
    Mtot(i) = sqrt(My(i)^2+Md_x(i)^2);
end

%% Plot results
figure('Position', [300 100 900 600])
title('Adhesion and detachment torques')
scatter3(x, y, Mtot, 'MarkerEdgeColor','k', 'MarkerFaceColor', 'r',...
    'LineWidth',0.5);
hold on
surf(x, y, Ta, 'FaceColor',[0.5 0.5 0.5], 'EdgeColor', 'none');
legend({'Adhesion torque','Detachment torque'})
xlabel('x [m]')
ylabel('y [m]')
zlabel('M_{tot} [Nm]')