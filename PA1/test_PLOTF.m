clc
clear

%test whether ROTX really causes a rotation around the X-axis

%Rotating the frame along the X-axis means both frames share the same
%X-axis. Also, the length of all vectors is preserved.

figure(1)
h1 = [1 0 1 0; 0 1 -1 0; 0 0 1 0; 0 0 0 1];
plotf(h1);
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTF: Fig 1','h1 frame'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
h2 = h1*rotm2tform(ROTX(pi/3))*h1;
plotf(h2);
dim = [0.2 0.7 0.3 0.3];
str = {'PLOTF: Fig 2','60 degree rotation around X,','Observe same X-axis as h1,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

figure(3)
h1 = [1 1 -1 0; 0 1 -1 0; 0 1 0 0; 0 0 0 1];
plotf(h1);
dim = [0.2 0.5 0.3 0.3];
str = {'PLOTF: Fig 3','h2 frame'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
h2 = h1*rotm2tform(ROTX(pi/2))*h1;
plotf(h2);
dim = [0.2 0.7 0.3 0.3];
str = {'PLOTF: Fig 4','90 degree rotation around X,','Observe same X-axis as h2,','Length is unchanged'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%figure(1)
%h1 = [1 0 1 0; 0 1 -1 0; 0 0 1 0; 0 0 0 1]
%plotf(h1);
%figure(2)
%h2 = h1*rotm2tform(ROTY(pi/3))*h1;
%plotf(h2);
%dim = [0.2 0.5 0.3 0.3];
%str = {'60 degree rotation,','Observe same X-axis as Figure 1,','Length is unchanged'};
%annotation('textbox',dim,'String',str,'FitBoxToText','on');