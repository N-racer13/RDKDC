function[Finv] = FINV(F)
    R = F(1:3, 1:3);
    p = F(1:3, 4);
    if det(R) ~= 1
        error('Transformation does not contain proper rotation matrix');
    end
    Finv = zeros(4);
    Finv(1:3, 1:3) = R';
    Finv(1:3, 4) = -R'*p;
    end
