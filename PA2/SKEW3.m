function[skew] = SKEW3(a)
    skew = zeros(3);
    skew(1, 2) = -a(3);
    skew(1, 3) = a(2);
    skew(2, 1) = a(3);
    skew(2, 3) = -a(1);
    skew(3, 1) = -a(2);
    skew(3, 2) = a(1);
end
