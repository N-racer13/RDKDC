function[gst] = ur5FwdKin(x)
syms l1 l2 l3 l4 l5
% x is a list conatining the 6 joint varibles of the ur5 robot
    gst_0 = [1 0 0 l3+l5; 0 1 0 0; 0 0 1 l1+l2+l4; 0 0 0 1];
    % twists defined in hw6
    xi1 = [0 0 0 0 0 1];
    xi2 = [0 0 0 1 0 0];
    xi3 = [0 -l1 0 -1 0 0];
    xi4 = [0 l1+l2 0 1 0 0];
    xi5 = [0 -l3 0 0 0 1];
    xi6 = [0 l1+l2+l4 0 1 0 0];

    % create transformation matrix from twists
    g1 = sym(zeros(4));
    w1 = xi1(4:6)
    v1 = xi1(1:3)
    exp1 = EXPCR(w1, x(1));
    R1 = exp1;
    p1 = (eye(3) - exp1)*(SKEW3(w1)*transpose(v1))+transpose(w1)*w1*transpose(v1)*x(1);
    g1(1:3, 1:3) = R1;
    g1(1:3, 4) = p1

    g2 = sym(zeros(4));
    w2 = xi2(4:6)
    v2 = xi2(1:3)
    exp2 = EXPCR(w2, x(2));
    R2 = exp2;
    p2 = (eye(3) - exp2)*(SKEW3(w2)*transpose(v2))+transpose(w2)*w2*transpose(v2)*x(2);
    g2(1:3, 1:3) = R2;
    g2(1:3, 4) = p2

    g3 = sym(zeros(4));
    w3 = xi3(4:6)
    v3 = xi3(1:3)
    exp3 = EXPCR(w3, x(3));
    R3 = exp3;
    p3 = (eye(3) - exp3)*(SKEW3(w3)*transpose(v3))+transpose(w3)*w3*transpose(v3)*x(3);
    g3(1:3, 1:3) = R3;
    g3(1:3, 4) = p3

    g4 = sym(zeros(4));
    w4 = xi4(4:6)
    v4 = xi4(1:3)
    exp4 = EXPCR(w4, x(4));
    R4 = exp4;
    p4 = (eye(3) - exp4)*(SKEW3(w4)*transpose(v4))+transpose(w4)*w4*transpose(v4)*x(4);
    g4(1:3, 1:3) = R4;
    g4(1:3, 4) = p4

    g5 = sym(zeros(4));
    w5 = xi5(4:6)
    v5 = xi5(1:3)
    exp5 = EXPCR(w5, x(5));
    R5 = exp5;
    p5 = (eye(3) - exp5)*(SKEW3(w5)*transpose(v5))+transpose(w5)*w5*transpose(v5)*x(5);
    g5(1:3, 1:3) = R5;
    g5(1:3, 4) = p5

    g6 = sym(zeros(4));
    w6 = xi6(4:6)
    v6 = xi6(1:3)
    exp6 = EXPCR(w6, x(6));
    R6 = exp6;
    p6 = (eye(3) - exp6)*(SKEW3(w6)*transpose(v6))+transpose(w6)*w6*transpose(v6)*x(6);
    g6(1:3, 1:3) = R6;
    g6(1:3, 4) = p6

    % finaltransformation matrix gst
    gst = g1*g2*g3*g4*g5*g6*gst_0;
end
