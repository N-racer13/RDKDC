clc
clear

%test whether ROTX really causes a rotation around the X-axis

%since the vector is homogenous (4x1) we need to adjust the matrix result
%from ROTX to 4x4 by adding a 3x3 zero row and a [0 0 0 1] column to it.
%This can easily be done by the build in matlab command rotm2tform()

%Again, rotating the point should not change its X-coordinate and the
%distance to the origin.

Rot = rotm2tform(ROTX(pi/4))

figure(1)
p1 = [1; 1; 1; 0];
plotp4(p1, 'r*')
hold on
Rp1 = rotm2tform(ROTX(pi/3))*p1;
plotp4(Rp1, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP4: Fig 1','Rotate red to blue','60 degree rotation,','Observe same X-coordinate,','Distance to origin is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
p2 = [0.5; 0.5; 0.5; 0];
plotp4(p2, 'r*')
hold on
Rp2 = rotm2tform(ROTX(pi/4))*p2;
plotp4(Rp2, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP4: Fig 2','45 degree rotation,','Observe same X-coordinate,','Distance to origin is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(3)
p3 = [0.4; 0.7; 0.3; 0];
plotp4(p3, 'r*')
hold on
Rp3 = rotm2tform(ROTX(pi/2))*p3;
plotp4(Rp3, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP4: Fig 3','90 degree rotation,','Observe same X-coordinate,','Distance to origin is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
p4 = [0.6; 0; 0; 0];
plotp4(p4, 'r*')
hold on
Rp4 = rotm2tform(ROTX(pi/6))*p4;
plotp4(Rp4, 'b*')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTP4: Fig 4','30 degree rotation,','Point on X-axis does not rotate'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%p1 = [1; 1; 1; 0];
%plotp4(p1)
%hold on
%Rp1 = rotm2tform(ROTY(pi/3))*p1;
%plotp4(Rp1)