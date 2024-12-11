function [x, y, z] = plotBaseballTrajectory(x0, y0, z0, vx0, vy0, vz0, ax, ay, az)
    % plotBaseballTrajectory - Plots 3D baseball trajectory given initial conditions
    %
    % Inputs:
    %   x0, y0, z0     - Initial positions (ft)
    %   vx0, vy0, vz0  - Initial velocities (ft/s)
    %   ax, ay, az     - Accelerations (ft/s^2)
    %
    % Outputs:
    %   x, y, z        - Position arrays (ft)
    
    % Initialize parameters
    dt = 0.001;          % Time step (seconds)
    t = 0:dt:0.42;       % Time array adjusted for 98 MPH pitch
    
    % Initialize solution arrays
    n = length(t);
    x = zeros(1, n);
    y = zeros(1, n);
    z = zeros(1, n);
    
    % Set initial positions
    x(1) = x0;
    y(1) = y0;
    z(1) = z0;
    
    % Calculate trajectory using kinematic equations
    for i = 2:n
        % x(t) = x0 + v0*t + (1/2)a*t^2
        x(i) = x0 + vx0*t(i) + 0.5*ax*t(i)^2;
        y(i) = y0 + vy0*t(i) + 0.5*ay*t(i)^2;
        z(i) = z0 + vz0*t(i) + 0.5*az*t(i)^2;
    end
    
end