function [dx, dy, dz, t] = compare(x1, y1, z1, x2, y2, z2, dt)
    % compare - Calculates absolute differences between two trajectory methods
    %
    % Inputs:
    %   x1, y1, z1 - Position arrays from first method (accurate_RK)
    %   x2, y2, z2 - Position arrays from second method (plotBaseballTrajectory)
    %   dt         - Time step for creating time array
    %
    % Outputs:
    %   dx, dy, dz - Absolute differences in each dimension
    %   t          - Time array for plotting
    
    % Ensure arrays are row vectors
    x1 = x1(:)'; y1 = y1(:)'; z1 = z1(:)';
    x2 = x2(:)'; y2 = y2(:)'; z2 = z2(:)';
    
    % Get lengths of input arrays
    n1 = length(x1);
    n2 = length(x2);
    
    % If arrays have different lengths, interpolate the shorter one
    if n1 ~= n2
        if n1 > n2
            % Create time vectors
            t1 = linspace(0, 1, n1);
            t2 = linspace(0, 1, n2);
            
            % Interpolate method 2 to match method 1's points
            x2 = interp1(t2, x2, t1);
            y2 = interp1(t2, y2, t1);
            z2 = interp1(t2, z2, t1);
            
            % Use n1 for time array
            t = (0:n1-1) * dt;
        else
            % Create time vectors
            t1 = linspace(0, 1, n1);
            t2 = linspace(0, 1, n2);
            
            % Interpolate method 1 to match method 2's points
            x1 = interp1(t1, x1, t2);
            y1 = interp1(t1, y1, t2);
            z1 = interp1(t1, z1, t2);
            
            % Use n2 for time array
            t = (0:n2-1) * dt;
        end
    else
        % Arrays are same length, use n1 for time array
        t = (0:n1-1) * dt;
    end
    
    % Calculate absolute differences
    dx = abs(x1 - x2);
    dy = abs(y1 - y2);
    dz = abs(z1 - z2);
end 