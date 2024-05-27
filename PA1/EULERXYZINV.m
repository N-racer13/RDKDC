%Be carefulof gimball lock! Occurs when second rotation is 90 degrees. At
%this point there is no telling apart the roll from the yaw which can cause
%errors. 

function [x] = EULERXYZINV(Rot)
    x = [0 0 0]
    x(1) = atan(-Rot(2, 3)/Rot(3,3));
    x(2) = atan(Rot(1, 3)/sqrt(Rot(2, 3)^2 + Rot(3, 3)^2));
    x(3) = atan(-Rot(1, 2)/Rot(1, 1));
    if abs(x(2)-pi/2) < 0.001
        error('Gimball lock detected, choose different rotations!')
    end
end
