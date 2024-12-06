function [t, x, y, z] = rungaKutta(x0, y0, z0, vx0, vy0, vz0, Cd, CL, phi, g, K, dt, t_final)
    % Time parameters
    t_span = 0:dt:t_final;
    n = length(t_span);

    % Initialize solution arrays
    sol = zeros(6, n);
    sol(:,1) = [x0; y0; z0; vx0; vy0; vz0];
    
    % RK4 integration
    for i = 1:n-1
        k1 = derivatives(sol(:,i), Cd, CL, phi, g, K);
        k2 = derivatives(sol(:,i) + dt*k1/2, Cd, CL, phi, g, K);
        k3 = derivatives(sol(:,i) + dt*k2/2, Cd, CL, phi, g, K);
        k4 = derivatives(sol(:,i) + dt*k3, Cd, CL, phi, g, K);
        
        sol(:,i+1) = sol(:,i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    % Output results
    t = t_span;
    x = sol(1,:);
    y = sol(2,:);
    z = sol(3,:);
end

function dydt = derivatives(y, Cd, CL, phi, g, K)
    % Extract current state
    vx = y(4);
    vy = y(5);
    vz = y(6);
    
    % Calculate velocity magnitude
    v = sqrt(vx^2 + vy^2 + vz^2);
    
    % Calculate drag and lift forces
    Fd = K * v^2;  % Drag force magnitude
    FL = (CL/Cd) * Fd;  % Lift force magnitude
    
    % Calculate acceleration components
    ax = -Fd*vx/v;
    ay = -Fd*vy/v - FL*sin(phi);
    az = -Fd*vz/v - FL*cos(phi) - g;
    
    % Return derivatives
    dydt = [vx; vy; vz; ax; ay; az];
end
