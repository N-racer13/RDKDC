tfunction[xi] = getXi(g)
    syms l1 l2 l3 l4 l5
    xi = zeros(6, 1);
    R = g(1:3, 1:3);
    p = g(1:3, 4);
    theta = acos((trace(R)-1)/2)
    
    r = zeros(3, 1)
    Ra = R - transpose(R);
    r(1) = Ra(3, 2);
    r(2) = Ra(1, 3);
    r(3) = Ra(2, 1);

    w = 1/(2*sin(theta))*r;
    A = eye(3)*theta + (1-cos(theta))*SKEW3(w) + (theta-sin(theta))*SKEW3(w)*SKEW3(w);
    v = A\p;

    xi(1:3) = v;
    xi(4:6) = w;
end
