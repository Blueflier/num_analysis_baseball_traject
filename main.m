% Initialize parameters for Pitch #1
x0 = -2.509; y0 = 50; z0 = 5.928;
vx0 = 9.182; vy0 = -132.785; vz0 = -10.967;
ax = -19.268; ay = 30.713; az = -16.580;


Cd = 0.3926485; CL = 0.255819;
% phi = 236.0038*pi/180;
phi = 4.119;
g = 32.174;
K = 0.005152949;

% Simulation parameters
dt = 0.01;      % Time step
t_final = 0.5;   % Final time adjusted for 98 MPH pitch

% Get trajectories from both methods
[x1, y1, z1] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, dt, t_final, K, Cd, CL, phi);
[x2, y2, z2] = plotBaseballTrajectory(x0, y0, z0, vx0, vy0, vz0, ax, ay, az, t_final,dt);

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

% Add a subplot or new figure for Pitch #2
figure;
hold on;

% Initialize parameters for Pitch #2
x0 = -2.43; y0 = 50; z0 = 6.46;
vx0 = 9.46; vy0 = -143.17; vz0 = -9.15;
ax = -23.08; ay = 34.2; az = -26.09;

Cd = 0.3512265; CL = 0.216346;
phi = 4.591151161;  % Already in radians
g = 32.174;
K = 0.005316103;

% Get trajectories from both methods for Pitch #2
[x1, y1, z1] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, dt, t_final, K, Cd, CL, phi);
[x2, y2, z2] = plotBaseballTrajectory(x0, y0, z0, vx0, vy0, vz0, ax, ay, az, t_final,dt);

% Plot both trajectories
plot3(x1, y1, z1, 'b-', 'LineWidth', 2, 'DisplayName', 'accurate\_RK');
plot3(x2, y2, z2, 'r--', 'LineWidth', 2, 'DisplayName', 'plotBaseballTrajectory');

% Customize plot
grid on;
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
zlabel('Z Position (ft)');
title('Baseball Trajectory Comparison - Pitch #2');
legend('Location', 'best');
view(45, 30);
axis equal;

% Display end points for comparison
fprintf('\nPitch #2:\n');
fprintf('accurate_RK end point: (%.3f, %.3f, %.3f)\n', x1(end), y1(end), z1(end));

% Find indices where y is closest to 0 and -5
[~, idx_home] = min(abs(y1));
[~, idx_behind] = min(abs(y1 - (-5)));

% Get x and z coordinates at these points
x_home = x1(idx_home);
z_home = z1(idx_home);
x_behind = x1(idx_behind);
z_behind = z1(idx_behind);

% Create strike zone plot
figure;
hold on;

% Set axis limits to match the example
xlim([-3 3]);
ylim([0 5]);

% Plot ball locations
scatter(x_home, z_home, 100, 'r', 'filled', 'DisplayName', 'At Home Plate');
% scatter(x_behind, z_behind, 100, 'b', 'filled', 'DisplayName', 'Behind Plate');

% Draw strike zone (approximate MLB strike zone)
strike_zone_left = -1;    % 17 inches = ~1.417 ft, centered at 0
strike_zone_right = 1;
strike_zone_bottom = 1.5;     % Approximate bottom of strike zone
strike_zone_top = 3.5;        % Approximate top of strike zone

% Draw strike zone with thinner gray lines to match example
rectangle('Position', [strike_zone_left, strike_zone_bottom, ...
    strike_zone_right-strike_zone_left, strike_zone_top-strike_zone_bottom], ...
    'EdgeColor', [0.7 0.7 0.7], 'LineWidth', 1);

% Customize plot
grid on;
xlabel('Horizontal Location (in Feet)');
ylabel('Vertical Location (in Feet)');
title('Strike Zone Plot');

% Adjust figure appearance
set(gca, 'GridColor', [0.9 0.9 0.9], 'GridAlpha', 0.5);
set(gca, 'Layer', 'top');  % Ensure grid is behind the data
box on;

% Print the coordinates
fprintf('\nPitch #2 Locations:\n');
fprintf('At home plate (y=0): x=%.3f ft, z=%.3f ft\n', x_home, z_home);
fprintf('Behind plate (y=-5): x=%.3f ft, z=%.3f ft\n', x_behind, z_behind);

% Create a third figure comparing both pitches
figure;
hold on;

% Store Pitch #1 parameters
x0_1 = -2.509; y0_1 = 50; z0_1 = 5.928;
vx0_1 = 9.182; vy0_1 = -132.785; vz0_1 = -10.967;
ax_1 = -19.268; ay_1 = 30.713; az_1 = -16.580;
Cd_1 = 0.3926485; CL_1 = 0.255819;
phi_1 = 236.0038*pi/180;
K_1 = 0.005152949;

% Store Pitch #2 parameters
x0_2 = -2.43; y0_2 = 50; z0_2 = 6.46;
vx0_2 = 9.46; vy0_2 = -143.17; vz0_2 = -9.15;
ax_2 = -23.08; ay_2 = 34.2; az_2 = -26.09;
Cd_2 = 0.3512265; CL_2 = 0.216346;
phi_2 = 4.591151161;
K_2 = 0.005316103;

% Calculate trajectories for both pitches
[x1_p1, y1_p1, z1_p1] = accurate_RK(x0_1, y0_1, z0_1, vx0_1, vy0_1, vz0_1, dt, t_final, K_1, Cd_1, CL_1, phi_1);
[x2_p1, y2_p1, z2_p1] = plotBaseballTrajectory(x0_1, y0_1, z0_1, vx0_1, vy0_1, vz0_1, ax_1, ay_1, az_1, t_final,dt);

[x1_p2, y1_p2, z1_p2] = accurate_RK(x0_2, y0_2, z0_2, vx0_2, vy0_2, vz0_2, dt, t_final, K_2, Cd_2, CL_2, phi_2);
[x2_p2, y2_p2, z2_p2] = plotBaseballTrajectory(x0_2, y0_2, z0_2, vx0_2, vy0_2, vz0_2, ax_2, ay_2, az_2, t_final,dt);

% Plot all trajectories
plot3(x1_p1, y1_p1, z1_p1, 'b-', 'LineWidth', 2, 'DisplayName', 'Pitch #1 accurate\_RK');
plot3(x2_p1, y2_p1, z2_p1, 'b--', 'LineWidth', 2, 'DisplayName', 'Pitch #1 plotBaseballTrajectory');
plot3(x1_p2, y1_p2, z1_p2, 'r-', 'LineWidth', 2, 'DisplayName', 'Pitch #2 accurate\_RK');
plot3(x2_p2, y2_p2, z2_p2, 'r--', 'LineWidth', 2, 'DisplayName', 'Pitch #2 plotBaseballTrajectory');

% Customize plot
grid on;
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
zlabel('Z Position (ft)');
title('Baseball Trajectory Comparison - Both Pitches');
legend('Location', 'best');
view(45, 30);
axis equal;

% Display end points for both pitches
fprintf('\nComparison of end points:\n');
fprintf('Pitch #1 accurate_RK end point: (%.3f, %.3f, %.3f)\n', x1_p1(end), y1_p1(end), z1_p1(end));
fprintf('Pitch #2 accurate_RK end point: (%.3f, %.3f, %.3f)\n', x1_p2(end), y1_p2(end), z1_p2(end));

% Calculate differences for Pitch #1
[dx1, dy1, dz1, t1] = compare(x1_p1, y1_p1, z1_p1, x2_p1, y2_p1, z2_p1, dt);

% Calculate differences for Pitch #2
[dx2, dy2, dz2, t2] = compare(x1_p2, y1_p2, z1_p2, x2_p2, y2_p2, z2_p2, dt);

% Create difference plots for Pitch #1
figure('Position', [100, 100, 800, 600]);
subplot(3,1,1);
plot(t1, dx1, 'b-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('X Difference (ft)');
title('Pitch #1 - Absolute Differences Between Methods');

subplot(3,1,2);
plot(t1, dy1, 'b-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Y Difference (ft)');

subplot(3,1,3);
plot(t1, dz1, 'b-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Z Difference (ft)');

% Create difference plots for Pitch #2
figure('Position', [100, 100, 800, 600]);
subplot(3,1,1);
plot(t2, dx2, 'r-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('X Difference (ft)');
title('Pitch #2 - Absolute Differences Between Methods');

subplot(3,1,2);
plot(t2, dy2, 'r-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Y Difference (ft)');

subplot(3,1,3);
plot(t2, dz2, 'r-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Z Difference (ft)');

% Print maximum differences
fprintf('\nMaximum differences for Pitch #1:\n');
fprintf('X: %.3f ft\nY: %.3f ft\nZ: %.3f ft\n', max(dx1), max(dy1), max(dz1));
fprintf('\nMaximum differences for Pitch #2:\n');
fprintf('X: %.3f ft\nY: %.3f ft\nZ: %.3f ft\n', max(dx2), max(dy2), max(dz2));
