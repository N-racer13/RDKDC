clc
clear

%test whether EULERXYZ really causes a rotation around the X, Y and Z in
%that order.

%We transform the base frame I(3) but do not plot it (it is obvious from 
%the figure), instead we just show R*I or just R for short.
%The new frame, the vectors plotted, should still be orthogonal meaning 
%norm = 1 and perpendicular to each other. Follow the figures to observe
%the finalrotation is correct.

figure(1)
a = [pi/2, 0, 0];
R = EULERXYZ(a);
plotr(R);
dim = [0.2 0.5 0.3 0.3];
str = {'90, 0, 0 degree rotation','along X, Y and Z respectively'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
a = [pi/2, pi/2, 0];
R = EULERXYZ(a);
plotr(R);
dim = [0.2 0.5 0.3 0.3];
str = {'90, 90, 0 degree rotation','along X, Y and Z respectively'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(3)
a = [pi/2, pi/2, pi/2];
R = EULERXYZ(a);
plotr(R);
dim = [0.2 0.5 0.3 0.3];
str = {'90, 90, 90 degree rotation','along X, Y and Z respectively'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');