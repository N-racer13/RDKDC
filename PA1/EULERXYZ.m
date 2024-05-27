function[Rxyz] = EULERXYZ(x)
    %takes 3 angle in radians (3x1) and converts it to an equivalent rotation
    %matrix for rotations around the X-,Y-,Z-axis respectively (3x3).

    Rxyz = ROTX(x(1))*ROTY(x(2))*ROTZ(x(3));
end