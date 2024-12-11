% Initialize parameters for Pitch #1
x0 = -2.509; y0 = 50; z0 = 5.928;
vx0 = 9.182; vy0 = -132.785; vz0 = -10.967;
ax = -19.268; ay = 30.713; az = -16.580;


Cd = 0.3926485; CL = 0.255819;
phi = 236.0038*pi/180;
g = 32.174;
K = 0.005152949;

% Simulation parameters
dt = 0.001;      % Time step
t_final = 0.5;   % Final time

% Get trajectories from both methods
[x1, y1, z1] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, dt, t_final, K, Cd, CL, phi);
[x2, y2, z2] = plotBaseballTrajectory(x0, y0, z0, vx0, vy0, vz0, ax, ay, az);

% Create plot
figure;
hold on;

% Plot both trajectories
plot3(x1, y1, z1, 'b-', 'LineWidth', 2, 'DisplayName', 'accurate\_RK');
plot3(x2, y2, z2, 'r--', 'LineWidth', 2, 'DisplayName', 'plotBaseballTrajectory');

% Customize plot
grid on;
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
zlabel('Z Position (ft)');
title('Baseball Trajectory Comparison - Pitch #1');
legend('Location', 'best');
view(45, 30);
axis equal;

% Display end points for comparison
fprintf('accurate_RK end point: (%.3f, %.3f, %.3f)\n', x1(end), y1(end), z1(end));
