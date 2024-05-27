clc
clear

%test whether ROTX really causes a rotation around the X-axis

%We transform the base frame I(3) but do not plot it (it is obvious from 
%the figure), instead we just show R*I or just R for short.
%The new frame, the vectors plotted, should still be orthogonal meaning 
%norm = 1 and perpendicular to each other. Also note that the x-axis 
%should not move for any value of theta since it is the rotation axis

figure(1)
Rx1 = ROTX(0);
plotr(Rx1);
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTR: Fig 1','0 degree rotation around X,','Z and Y should end at +1'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
Rx2 = ROTX(pi/3);
plotr(Rx2);
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTR: Fig 2','60 degree rotation around X,','Observe orthogonality after rotation'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(3)
Rx3 = ROTX(pi/4);
plotr(Rx3);
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTR: Fig 3','45 degree rotation around X,','Observe orthogonality after rotation'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
Rx4 = ROTX(pi);
plotr(Rx4);
dim = [0.2 0.2 0.3 0.3];
str = {'PLOTR: Fig 4','180 degree rotation around X,','Z and Y should end at -1'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%figure(5)
%Ry1 = ROTY(0);
%plotr(Ry1);