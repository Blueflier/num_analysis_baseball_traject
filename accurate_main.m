% Initialize parameters for Pitch #1
x0 = -2.509; y0 = 50; z0 = 5.928;
vx0 = 9.182; vy0 = -132.785; vz0 = -10.967;
Cd = 0.3926485; CL = 0.255819;

% Spin-related parameters
phi_spin = 236.0038*pi/180;  % Spin direction angle in radians
phi_mag = 2388;              % Spin rate in RPM
theta = 3.9*pi/180;          % Release angle in radians

% Other parameters
g = 32.174;
K = 0.005152949;

% Simulation parameters
dt = 0.001;  % Time step
t_final = 1;  % Final time

% Run simulation
[t, x, y, z] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, Cd, CL, phi_spin, phi_mag, theta, g, K, dt, t_final);

% Plot results
figure;
plot3(x, y, z)
grid on
xlabel('X (ft)'); ylabel('Y (ft)'); zlabel('Z (ft)')
title('Baseball Trajectory - Pitch #1 (Accurate Model)')
axis equal

% Add velocity vectors at selected points
hold on
quiver3(x(1:20:end), y(1:20:end), z(1:20:end), ...
        gradient(x(1:20:end)), gradient(y(1:20:end)), gradient(z(1:20:end)), ...
        'r', 'AutoScale', 'on', 'AutoScaleFactor', 2)
hold off 