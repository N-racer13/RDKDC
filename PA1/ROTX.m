function [Rot] = ROTX(theta)
    %takes an angle in radians (scalar) and converts it to an equivalent rotation
    %matrix for rotations around the X-axis (3x3)


    Rot = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
end
