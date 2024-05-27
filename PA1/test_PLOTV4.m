clc
clear

%test whether ROTX really causes a rotation around the X-axis

%since the vector is homogenous (4x1) we need to adjust the matrix result
%from ROTX to 4x4 by adding a 3x3 zero row and a [0 0 0 1] column to it.
%This can easily be done by the build in matlab command rotm2tform()

%Again, rotating the vector should not change the X-coordinates of the 
%points that make them and the length remains unchanged.

figure(1)
p1 = [1; 1; 1; 0];
p2 = [0.5; 0.5; 0.5; 0];
plotv4(p1,p2,'r')
hold on
Rp1 = rotm2tform(ROTX(pi/3))*p1;
Rp2 = rotm2tform(ROTX(pi/3))*p2;
plotv4(Rp1,Rp2,'b')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTV4: Fig 1','60 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
p1 = [1.5; 0.1; 0.1; 0];
p2 = [0; 0.3; 0.2; 0];
plotv4(p1,p2,'r')
hold on
Rp1 = rotm2tform(ROTX(pi/6))*p1;
Rp2 = rotm2tform(ROTX(pi/6))*p2;
plotv4(Rp1,Rp2,'b')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTV4: Fig 2','30 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(3)
p1 = [0; 0.7; 0.7; 0];
p2 = [1; 0.7; 0.7; 0];
plotv4(p1,p2,'r')
hold on
Rp1 = rotm2tform(ROTX(pi/2))*p1;
Rp2 = rotm2tform(ROTX(pi/2))*p2;
plotv4(Rp1,Rp2,'b')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTV4: Fig 3','90 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
p1 = [0.5; 0.6; 0.9; 0];
p2 = [0.5; 0.3; 0.1; 0];
plotv4(p1,p2,'r')
hold on
Rp1 = rotm2tform(ROTX(pi))*p1;
Rp2 = rotm2tform(ROTX(pi))*p2;
plotv4(Rp1,Rp2,'b')
dim = [0.2 0.2 0.3 0.3];
str = {'PLOTV4: Fig 4','180 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%p1 = [1; 1; 1; 0];
%p2 = [0.5; 0.5; 0.5; 0];
%plotv4(p1,p2,'r')
%hold on
%Rp1 = rotm2tform(ROTY(pi/3))*p1;
%Rp2 = rotm2tform(ROTY(pi/3))*p2;
%plotv4(Rp1,Rp2,'b')