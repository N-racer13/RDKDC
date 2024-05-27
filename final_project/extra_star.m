clear;
clc;

ur5 = ur5_interface();
home = [0; -9*pi/20; -pi/20; -11*pi/20; pi/20; 0];
r = 0.05;
pause_short = 2.2;
para = [0.5 0.1 2];

input_mode = 0;

if input_mode == 0
    gst_target = [-0.8381   -0.5444    0.0364    0.1403; -0.5455    0.8372   -0.0385    0.5781;  -0.0095   -0.0521   -0.9986    0.3525; 0 0 0 1];
    
    inv_target = ur5InvKin(gst_target);
    
    norm_q_target = [0 0 0 0 0 0 0 0];

    for i = 1:8
        norm_q_target(i) = norm(inv_target(i));
    end
    [~, j] = min(norm_q_target);
    q2 = inv_target(:,i);

end

gst_1 = [ 0.8961   -0.4355    0.0860    0.1277;  -0.4396   -0.8976    0.0343    0.3996; 0.0622   -0.0685   -0.9957    0.3525;0 0 0 1];
gst_2 = [0.8961   -0.4355    0.0860   0.1155; -0.4396   -0.8976    0.0343   0.4259;0.0622   -0.0685   -0.9957    0.3525;0 0 0 1];
gst_3 = [0.8961   -0.4355    0.0860    0.1105; -0.4396   -0.8976    0.0343    0.3997;  0.0622   -0.0685   -0.9957    0.3525; 0  0 0 1];
gst_4 = [ 0.8961   -0.4355    0.0860   0.1333;-0.4396   -0.8976    0.0343    0.4168;0.0622   -0.0685   -0.9957   0.3525;0 0 0 1];
gst_5 =  [ 0.8961   -0.4355    0.0860   0.0868;-0.4396   -0.8976    0.0343    0.4161; 0.0622   -0.0685   -0.9957    0.3525;0 0 0 1 ];

ur5.move_joints(ur5.home, 8)
pause(8.8)

ur5.move_joints(home, 2);
pause(pause_short)

disp('move to gst_1')
ur5.move_joints(ur5InvKin(gst_1), 5);
pause(5)

disp('move to gst_2')
traj = lineGen(gst_1, gst_2);
if(mymove(traj, 1, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short);


disp('move to gst_3')
traj = lineGen(gst_2, gst_3);
if(mymove(traj, 1, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short);

disp('move to gst_4')
traj = lineGen(gst_3, gst_4);
if(mymove(traj, 1, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short);

disp('move to gst_5')
traj = lineGen(gst_4, gst_5);
if(mymove(traj, 1, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short);


disp('move to gst_1')
traj = lineGen(gst_5, gst_1);
if(mymove(traj, 1, para, ur5)==-1)
    rosshutdown
    return
end


pause(pause_short);

