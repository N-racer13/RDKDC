%insert the desired rotation angles and translation coordinates for the
%coordinate transforms
%g0a
rotation_angles_0a = [pi/3, 0, 0];
translation_coordinates_0a = [0.5; 0; 0];
%gab
rotation_angles_ab = [0, pi/3, 0];
translation_coordinates_ab = [0; 0.5; 0];
%gbc
rotation_angles_bc = [0, 0, pi/3];
translation_coordinates_bc = [0; 0; 0.5];

%-------------------------------------------------------------------------

%load ur5 robot in RViz
ur5=ur5_interface()

%create g0a
R0a = EULERXYZ(rotation_angles_0a);
g0a = rotm2tform(R0a);
g0a(1:3, 4) = translation_coordinates_0a;
%create gab
Rab = EULERXYZ(rotation_angles_ab);
gab = rotm2tform(Rab);
gab(1:3, 4) = translation_coordinates_ab;
%create gbc
Rbc = EULERXYZ(rotation_angles_bc);
gbc = rotm2tform(Rbc);
gbc(1:3, 4) = translation_coordinates_bc;

%create transformations
Frame_A = tf_frame('base_link', 'Frame_A', g0a)
pause(1)
Frame_B = tf_frame('Frame_A', 'Frame_B', gab)
pause(1)
Frame_C = tf_frame('base_link', 'Frame_C', eye(4))
pause(1)
Frame_C.move_frame('Frame_B', gbc)
pause(1)

%check if gac is equal to gacreal
gac = gab*gbc;
gacreal = Frame_C.read_frame('Frame_A');

%-------------------------------------------------------------------------
%SECOND SET OF FRAMES
%-------------------------------------------------------------------------

%insert the desired rotation angles and translation coordinates for the
%coordinate transforms
%g0a
rotation_angles_0a2 = [pi/3, pi/2, 0];
translation_coordinates_0a2 = [0.5; 0.6; 0];
%gab
rotation_angles_ab2 = [0, pi/3, pi/9];
translation_coordinates_ab2 = [0.1; 0.1; 0.1];
%gbc
rotation_angles_bc2 = [pi/5, pi/4, pi/3];
translation_coordinates_bc2 = [0.1; 0; 0.2];

%-------------------------------------------------------------------------

%create g0a2
R0a2 = EULERXYZ(rotation_angles_0a2);
g0a2 = rotm2tform(R0a2);
g0a2(1:3, 4) = translation_coordinates_0a2;
%create gab2
Rab2 = EULERXYZ(rotation_angles_ab2);
gab2 = rotm2tform(Rab2);
gab2(1:3, 4) = translation_coordinates_ab2;
%create gbc2
Rbc2 = EULERXYZ(rotation_angles_bc2);
gbc2 = rotm2tform(Rbc2);
gbc2(1:3, 4) = translation_coordinates_bc2;

%create transformations
Frame_A2 = tf_frame('base_link', 'Frame_A2', g0a2)
pause(1)
Frame_B2 = tf_frame('Frame_A2', 'Frame_B2', gab2)
pause(1)
Frame_C2 = tf_frame('base_link', 'Frame_C2', eye(4))
pause(1)
Frame_C2.move_frame('Frame_B2', gbc2)
pause(1)

%check if gac2 is equal to gacreal2
gac2 = gab2*gbc2;
gacreal2 = Frame_C2.read_frame('Frame_A2');
error2 = gacreal2 - gac2
error2 = gacreal2 - gac2