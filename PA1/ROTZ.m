function [Rot] = ROTZ(theta)
    %takes an angle in radians (scalar) and converts it to an equivalent rotation
    %matrix for rotations around the Z-axis (3x3)

    
    Rot = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
end