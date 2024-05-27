clc
clear

%test whether ROTX really causes a rotation around the X-axis

%since we only rotate around X-axis, the newly transformed point should
%have the same X-coordinate. Also, the distance to the origin should remain
%unchanged
figure(1)
p1 = [1; 1; 1];
plotp3(p1, 'r*')
hold on
Rp1 = ROTX(pi/3)*p1;
plotp3(Rp1, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP3: Fig 1','Rotate red to blue','60 degree rotation,','Observe same X-coordinate,','Distance to origin is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
p2 = [0.5; 0.5; 0.5];
plotp3(p2, 'r*')
hold on
Rp2 = ROTX(pi/4)*p2;
plotp3(Rp2, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP3: Fig 2','45 degree rotation,','Observe same X-coordinate,','Distance to origin is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(3)
p3 = [0.4; 0.7; 0.3];
plotp3(p3, 'r*')
hold on
Rp3 = ROTX(pi/2)*p3;
plotp3(Rp3, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP3: Fig 3','90 degree rotation,','Observe same X-coordinate,','Distance to origin is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
p4 = [0.6; 0; 0];
plotp3(p4, 'r*')
hold on
Rp4 = ROTX(pi/6)*p4;
plotp3(Rp4, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP3: Fig 4','30 degree rotation,','Point on X-axis does not rotate'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%p1 = [1; 1; 1];
%plotp3(p1)
%hold on
%Rp1 = ROTY(pi/3)*p1;
%plotp3(Rp1)