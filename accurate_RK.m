function [t, x, y, z] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, Cd, CL, phi_spin, phi_mag, theta, g, K, dt, t_final)
    % Time parameters
    t_span = 0:dt:t_final;
    n = length(t_span);

    % Initialize solution arrays
    sol = zeros(6, n);
    sol(:,1) = [x0; y0; z0; vx0; vy0; vz0];
    
    % Convert spin parameters
    omega = phi_mag * (2*pi/60);  % Convert RPM to rad/s
    
    % Air density (standard conditions)
    rho = 1.225;  % kg/m^3
    
    % Baseball parameters
    r = 0.037338;  % radius in meters (2.94 inches)
    m = 0.145;     % mass in kg (5.11 oz)
    
    % RK4 integration
    for i = 1:n-1
        k1 = derivatives(sol(:,i), Cd, CL, phi_spin, omega, theta, g, K, rho, r, m);
        k2 = derivatives(sol(:,i) + dt*k1/2, Cd, CL, phi_spin, omega, theta, g, K, rho, r, m);
        k3 = derivatives(sol(:,i) + dt*k2/2, Cd, CL, phi_spin, omega, theta, g, K, rho, r, m);
        k4 = derivatives(sol(:,i) + dt*k3, Cd, CL, phi_spin, omega, theta, g, K, rho, r, m);
        
        sol(:,i+1) = sol(:,i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    % Output results
    t = t_span;
    x = sol(1,:);
    y = sol(2,:);
    z = sol(3,:);
end

function dydt = derivatives(y, Cd, CL, phi_spin, omega, theta, g, K, rho, r, m)
    % Extract current state
    vx = y(4);
    vy = y(5);
    vz = y(6);
    
    % Calculate velocity magnitude
    v = sqrt(vx^2 + vy^2 + vz^2);
    
    % Unit vectors
    if v > 0
        ev = [vx; vy; vz]/v;  % Velocity direction
    else
        ev = [0; 0; 0];
    end
    
    % Spin axis unit vector (using phi_spin and theta)
    es = [cos(theta)*cos(phi_spin);
          cos(theta)*sin(phi_spin);
          sin(theta)];
    
    % Calculate forces
    % Drag force
    Fd = K * v^2;  % Drag force magnitude
    F_drag = -Fd * ev;
    
    % Magnus force (spin effect)
    S = (r * omega)/(v + eps);  % Spin parameter (eps prevents division by zero)
    Cm = 1/(2 + S);  % Magnus coefficient
    F_magnus = 0.5 * rho * (pi*r^2) * v^2 * Cm * cross(es, ev);
    
    % Lift force
    FL = (CL/Cd) * Fd;
    lift_dir = cross(ev, cross(es, ev));  % Lift direction
    norm_lift = norm(lift_dir);
    if norm_lift > 0
        lift_dir = lift_dir/norm_lift;
    end
    F_lift = FL * lift_dir;
    
    % Sum all forces and calculate acceleration
    F_total = F_drag + F_magnus + F_lift + [0; 0; -m*g];
    acc = F_total/m;
    
    % Return derivatives
    dydt = [vx; vy; vz; acc(1); acc(2); acc(3)];
end 