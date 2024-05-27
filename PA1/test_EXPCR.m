%test PLOTR() for different matrices created by EXPCR()
%-------------------------------------------------------
figure(1)
x = [pi/2, pi/6,pi/10];
R = EXPCR(x);
plotr(R);
dim = [0.2 0.7 0.3 0.3];
str = {'EXPCR plotr: Fig 1','rotation axis:','x = [pi/2, pi/6,pi/10]/norm(x)','theta:','norm(x)'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(2)
x = [pi/4, 0 ,pi/5];
R = EXPCR(x);
plotr(R);
dim = [0.2 0.7 0.3 0.3];
str = {'EXPCR plotr: Fig 2','rotation axis:','x = [pi/4, 0 ,pi/5]/norm(x)','theta:','norm(x)'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%test PLOTV3() for different matrices created by EXPCR()
%-------------------------------------------------------
figure(3)
x = [pi/2, pi/6,pi/10];
R = EXPCR(x);
p1 = [1; 1; 1];
p2 = [0.5; 0.5; 0.5];
plotv3(p1,p2,'r')
hold on
Rp1 = R*p1;
Rp2 = R*p2;
plotv3(Rp1,Rp2,'b')
dim = [0.2 0.7 0.3 0.3];
str = {'EXPCR plotv3: Fig 1','original vector in red','Rotated vector in blue'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
figure(4)
x = [pi/4, 0 ,pi/5];
R = EXPCR(x);
p1 = [1.5; 0.1; 0.1];
p2 = [0; 0.3; 0.2];
plotv3(p1,p2,'r')
hold on
Rp1 = R*p1;
Rp2 = R*p2;
plotv3(Rp1,Rp2,'b')
dim = [0.2 0.7 0.3 0.3];
str = {'EXPCR plotv3: Fig 2','original vector in red','Rotated vector in blue'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');