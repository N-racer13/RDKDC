function [Rot] = ROTY(theta)
    %takes an angle in radians (scalar) and converts it to an equivalent rotation
    %matrix for rotations around the Y-axis (3x3)

    
    Rot = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];
end
