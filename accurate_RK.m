function [x, y, z] = accurate_RK(x0, y0, z0, vx0, vy0, vz0, dt, t_final, K, Cd, CL, phi_spin)
    % accurate_RK - Calculates 3D baseball trajectory with aerodynamic effects
    % using 4th order Runge-Kutta integration
    %
    % Inputs:
    %   x0, y0, z0     - Initial positions (ft)
    %   vx0, vy0, vz0  - Initial velocities (ft/s)
    %   dt             - Time step (seconds)
    %   t_final        - Final time (seconds)
    %   K              - Drag coefficient parameter
    %   Cd             - Drag coefficient
    %   CL             - Lift coefficient
    %   phi_spin       - Spin angle (radians)
    %
    % Outputs:
    %   x, y, z        - Position arrays (ft)
    
    % Constants
    g = 32.174;        % Gravity acceleration (ft/s^2)
    
    % Time array
    t = 0:dt:t_final;
    n = length(t);
    
    % Initialize state vector [x1=x, x2=vx, x3=y, x4=vy, x5=z, x6=vz]
    state = zeros(6, n);
    state(:,1) = [x0; vx0; y0; vy0; z0; vz0];
    
    % RK4 integration
    for i = 1:n-1
        k1 = derivatives(state(:,i));
        k2 = derivatives(state(:,i) + dt*k1/2);
        k3 = derivatives(state(:,i) + dt*k2/2);
        k4 = derivatives(state(:,i) + dt*k3);
        
        state(:,i+1) = state(:,i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    % Extract positions for output
    x = state(1,:);
    y = state(3,:);
    z = state(5,:);

    function dstate = derivatives(x)
        % Helper function to compute derivatives for RK4
        % x = [x1=x, x2=vx, x3=y, x4=vy, x5=z, x6=vz]
        
        % Calculate velocity magnitude
        v = sqrt(x(2)^2 + x(4)^2 + x(6)^2);
        
        dstate = zeros(6,1);
        
        % Position derivatives
        dstate(1) = x(2);        % dx/dt = vx
        dstate(3) = x(4);        % dy/dt = vy
        dstate(5) = x(6);        % dz/dt = vz
        
        if v > 0
            % Velocity derivatives with aerodynamic effects
            % dvx/dt: X-acceleration
            dstate(2) = -K*Cd*v*x(2) - K*CL*v*x(4)*sin(phi_spin);
            
            % dvy/dt: Y-acceleration
            dstate(4) = -K*Cd*v*x(4) + K*CL*v*(x(2)*sin(phi_spin) - x(6)*cos(phi_spin));
            
            % dvz/dt: Z-acceleration
            dstate(6) = -K*Cd*v*x(6) + K*CL*v*x(4)*cos(phi_spin) - g;
        end
    end
end 