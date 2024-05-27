clc
clear

%test whether ROTX really causes a rotation around the X-axis

%since we only rotate around X-axis, the newly transformed points should
%have the same X-coordinates. Also, the length of the vector that plotv3
%creates is the same before and after rotation

figure(1)
p1 = [1; 1; 1];
p2 = [0.5; 0.5; 0.5];
plotv3(p1,p2,'r')
hold on
Rp1 = ROTX(pi/3)*p1;
Rp2 = ROTX(pi/3)*p2;
plotv3(Rp1,Rp2,'b')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTV3: Fig 1','60 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
p1 = [1.5; 0.1; 0.1];
p2 = [0; 0.3; 0.2];
plotv3(p1,p2,'r')
hold on
Rp1 = ROTX(pi/6)*p1;
Rp2 = ROTX(pi/6)*p2;
plotv3(Rp1,Rp2,'b')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTV3: Fig 2','30 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(3)
p1 = [0; 0.7; 0.7];
p2 = [1; 0.7; 0.7];
plotv3(p1,p2,'r')
hold on
Rp1 = ROTX(pi/2)*p1;
Rp2 = ROTX(pi/2)*p2;
plotv3(Rp1,Rp2,'b')
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTV3: Fig 3','90 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
p1 = [0.5; 0.6; 0.9];
p2 = [0.5; 0.3; 0.1];
plotv3(p1,p2,'r')
hold on
Rp1 = ROTX(pi)*p1;
Rp2 = ROTX(pi)*p2;
plotv3(Rp1,Rp2,'b')
dim = [0.2 0.2 0.3 0.3];
str = {'PLOTV3: Fig 4','180 degree rotation,','Observe same X-coordinate,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%p1 = [1; 1; 1];
%p2 = [0.5; 0.5; 0.5]
%plotv3(p1,p2,'r')
%hold on
%Rp1 = ROTY(pi/3)*p1;
%Rp2 = ROTY(pi/3)*p2;
%plotv3(Rp1,Rp2,'b')