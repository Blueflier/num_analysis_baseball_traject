% Load the actual trajectory data
actual_data = [
    % Time    X        Y       Z
    
0	-2.5090	50	5.9280;
0.0100	-2.4183	48.6738	5.8175;
0.0200	-2.3297	47.3510	5.7054;
0.0300	-2.2433	46.0315	5.5917;
0.0400	-2.1591	44.7153	5.4764;
0.0500	-2.0770	43.4023	5.3594;
0.0600	-1.9970	42.0927	5.2408;
0.0700	-1.9191	40.7863	5.1206;
0.0800	-1.8433	39.4832	4.9988;
0.0900	-1.7695	38.1833	4.8753;
0.1000	-1.6978	36.8866	4.7502;
0.1100	-1.6282	35.5931	4.6234;
0.1200	-1.5606	34.3028	4.4950;
0.1300	-1.4949	33.0157	4.3650;
0.1400	-1.4313	31.7317	4.2333;
0.1500	-1.3697	30.4508	4.1000;
0.1600	-1.3100	29.1731	3.9650;
0.1700	-1.2522	27.8985	3.8283;
0.1800	-1.1965	26.6270	3.6900;
0.1900	-1.1426	25.3586	3.5500;
0.2000	-1.0906	24.0933	3.4084;
0.2100	-1.0406	22.8310	3.2651;
0.2200	-0.9924	21.5718	3.1202;
0.2300	-0.9461	20.3156	2.9735;
0.2400	-0.9016	19.0624	2.8252;
0.2500	-0.8590	17.8122	2.6753;
0.2600	-0.8182	16.5650	2.5236;
0.2700	-0.7792	15.3207	2.3703;
0.2800	-0.7421	14.0795	2.2153;
0.2900	-0.7067	12.8412	2.0586;
0.3000	-0.6731	11.6058	1.9003;
0.3100	-0.6413	10.3733	1.7402;
0.3200	-0.6112	9.1438	1.5785;
0.3300	-0.5829	7.9171	1.4151;
0.3400	-0.5563	6.6934	1.2500;
0.3500	-0.5314	5.4725	1.0832;
0.3600	-0.5083	4.2544	0.9147;
0.3700	-0.4868	3.0393	0.7445;
0.3800	-0.4670	1.8269	0.5726;
0.3900	-0.4489	0.6174	0.3991;
0.4000	-0.4324	-0.5893	0.2238;
0.4100	-0.4176	-1.7933	0.0468;
0.4200	-0.4044	-2.9944	-0.1319;
0.4300	-0.3929	-4.1928	-0.3122;
0.4400	-0.3829	-5.3884	-0.4943;
0.4500	-0.3746	-6.5812	-0.6781;
0.4600	-0.3679	-7.7713	-0.8636;
0.4700	-0.3627	-8.9587	-1.0508;
0.4800	-0.3592	-10.1434	-1.2397;
0.4900	-0.3571	-11.3253	-1.4303;
0.5000	-0.3567	-12.5046	-1.6227;
];

% Extract data columns
t_actual = actual_data(:,1);
x_actual = actual_data(:,2);
y_actual = actual_data(:,3);
z_actual = actual_data(:,4);

% Initial conditions (from your first pitch)
x0 = -2.509; y0 = 50; z0 = 5.928;
vx0 = 9.182; vy0 = -132.785; vz0 = -10.967;
Cd = 0.3806; CL = 0.2480;

phi = 236.0038*180/pi;
K = 0.0053;

% Simulation parameters
dt = 0.01;      % Time step
t_final = 0.5;  % Final time

% Get trajectory from accurate_RK
[x_rk, y_rk, z_rk] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, dt, t_final, K, Cd, CL, phi);
[x_pbt, y_pbt, z_pbt] = plotBaseballTrajectory(x0, y0, z0, vx0, vy0, vz0, ax, ay, az, t_final, dt);

% 3D trajectory comparison
plot3(x_actual, y_actual, z_actual, 'k-', 'LineWidth', 2, 'DisplayName', 'Actual');
hold on;
plot3(x_rk, y_rk, z_rk, 'b--', 'LineWidth', 2, 'DisplayName', 'accurate\_RK');
plot3(x_pbt, y_pbt, z_pbt, 'r:', 'LineWidth', 2, 'DisplayName', 'plotBaseballTrajectory');
grid on;
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
zlabel('Z Position (ft)');
title('3D Trajectory Comparison');
legend('Location', 'best');
view(45, 30);

% Calculate differences
t_rk = (0:dt:t_final)';
dx_rk = x_rk - x_actual;
dy_rk = y_rk - y_actual;
dz_rk = z_rk - z_actual;

dx_pbt = x_pbt - x_actual;
dy_pbt = y_pbt - y_actual;
dz_pbt = z_pbt - z_actual;



% Calculate and display RMS errors
rms_x_rk = sqrt(mean(dx_rk.^2));
rms_y_rk = sqrt(mean(dy_rk.^2));
rms_z_rk = sqrt(mean(dz_rk.^2));

rms_x_pbt = sqrt(mean(dx_pbt.^2));
rms_y_pbt = sqrt(mean(dy_pbt.^2));
rms_z_pbt = sqrt(mean(dz_pbt.^2));

fprintf('RMS Errors:\n');
fprintf('\naccurate_RK:\n');
fprintf('X: %.6f ft\n', rms_x_rk);
fprintf('Y: %.6f ft\n', rms_y_rk);
fprintf('Z: %.6f ft\n', rms_z_rk);

fprintf('\nplotBaseballTrajectory:\n');
fprintf('X: %.6f ft\n', rms_x_pbt);
fprintf('Y: %.6f ft\n', rms_y_pbt);
fprintf('Z: %.6f ft\n', rms_z_pbt);

% Calculate maximum absolute errors
max_error_rk = max([max(abs(dx_rk)), max(abs(dy_rk)), max(abs(dz_rk))]);
max_error_pbt = max([max(abs(dx_pbt)), max(abs(dy_pbt)), max(abs(dz_pbt))]);

fprintf('\nMaximum Absolute Errors:\n');
fprintf('accurate_RK: %.6f ft\n', max_error_rk);
fprintf('plotBaseballTrajectory: %.6f ft\n', max_error_pbt);