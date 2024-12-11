% Initialize parameters for Pitch #1
x0 = -2.509; y0 = 50; z0 = 5.928;
vx0 = 9.182; vy0 = -132.785; vz0 = -10.967;
Cd = 0.3926485; CL = 0.255819;
phi = 236.0038*pi/180;
g = 32.174;
K = 0.005152949;

% Simulation parameters
dt = 0.001;  % Time step
t_final = 1;  % Final time

% Run simulation
[x, y, z] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, dt, t_final, K, Cd, CL, phi);


% Plot results
plot3(x, y, z)
grid on
xlabel('X'); ylabel('Y'); zlabel('Z')
title('Baseball Trajectory - Pitch #1')