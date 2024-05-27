function[Rot] = EXPCR(x)
    theta = norm(x);
    n = x/norm(x);
    Rot = eye(3) + SKEW3(n)*sin(theta) + SKEW3(n)*SKEW3(n)*(1-cos(theta));
    %det(Rot);
    %expm(SKEW3(n)*theta)
end