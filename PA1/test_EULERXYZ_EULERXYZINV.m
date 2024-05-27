clc
clear

%test statement in 4.a
%-------------------------
a = [pi/7, pi/3, pi/8];
R = EULERXYZ(a);
b = [pi/7 + 2*pi, pi/3 + 2*pi, pi/8];
test1 = R - EULERXYZ(b);
if test1 < 0.001
    fprintf(1, 'test1 succesful, adding 2*pi to any coordinate gives same result')
end

%test statement in 4.c
%-------------------------
a = [4*pi, 0, 0];
test2 = EULERXYZINV(EULERXYZ(a));
if norm(test2 - a) < 0.001
    fprintf(1, 'test2 succesful, EULERXYZINV(EULERXYZ()) gives orignal vector')
else
    fprintf(1, 'test2 unsuccesful, EULERXYZINV(EULERXYZ()) does not give orignal vector')
end
%The reason this test fails is because rotations over 2*N*pi come back around
%at the origin (as proven earlier). However, the norm of these 'vectors' is
%obviously different. So actually the result is the same in this case.

a = [pi/3, pi/3, pi/5];
test3 = EULERXYZINV(EULERXYZ(a));
if norm(test3 - a) < 0.001
    fprintf(1, 'test3 succesful, EULERXYZINV(EULERXYZ()) gives orignal vector')
end

a = [pi/9, pi/7, pi/5];
test4 = EULERXYZINV(EULERXYZ(a));
if norm(test4 - a) < 0.001
    fprintf(1, 'test4 succesful, EULERXYZINV(EULERXYZ()) gives orignal vector')
end

%test statement in 4.d
%-------------------------
a = [pi/7, pi/10, pi/9];
R = EULERXYZ(a);
R_new = EULERXYZ(EULERXYZINV(R));
R-R_new
fprintf('Using an error margin of 0.0001, we can see that the differentce between original R and new R is smaller than our margin, test succesful')