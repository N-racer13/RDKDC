%% Notations

% group work of Team 15

% choose the way of input start and target position by using input_mode

%% Initialization and input
clear; clc;
home = [1.14 -1.50 1.01 -1.86 -1.52 0.045]';
H = 0.1;
para = [5 0.1 0.1];

%switching mode, o -> auto, 1 -> manual
input_mode = 1;

%% pause short
pause_short = 2.5;

ur5 = ur5_interface();

wait_input = "\n Enter a value to select mode.\n" + ...
    ">>>>>>> press 1 to use inverse kinematics control \n" + ...
    ">>>>>>> press 2 to use RRcontrol \n" + ...
    ">>>>>>> press 3 for transpose Jacobian \n \n" + ...
    "Enter control mode : " ;
mode = input(wait_input);

%%  setting
% 0 is default, 1 is manual
if input_mode == 0
%     gst_start = [0 -1 0 0.31; -1 0 0 -0.12; 0 0 -1 0.22; 0 0 0 1];
    gst_start = [0 -1 0 0.23; -1 0 0 -0.23; 0 0 -1 0.21; 0 0 0 1];
%     gst_target = [0 -1 0 -0.21; -1 0 0 0.22; 0 0 -1 0.22; 0 0 0 1];
    gst_target = [0 -1 0 -0.42; -1 0 0 0.45; 0 0 -1 0.21; 0 0 0 1]
    
    inv_start = ur5InvKin(gst_start);
    inv_target = ur5InvKin(gst_target);
    
    norm_q_start = [0 0 0 0 0 0 0 0];
    norm_q_target = [0 0 0 0 0 0 0 0];

    for i = 1:8
        norm_q_start(i) = norm(inv_start(i));
        norm_q_target(i) = norm(inv_target(i));
    end

    [~, i] = min(norm_q_start);
    [~, j] = min(norm_q_target);

    q1 = inv_start(:,i);
    q2 = inv_target(:,i);

end

if input_mode == 1

    disp('Move to g_start, press any after you finish');
    waitforbuttonpress
    q1 = ur5.get_current_joints();
    gst_start = ur5FwdKin(q1);
    disp('done')

    pause(pause_short)

    disp('Move to g_start, press any after you finish');
    waitforbuttonpress 
    q2 = ur5.get_current_joints();
    gst_target = ur5FwdKin(q2); 
    disp('done')

end

gst_start_up = gst_start + [0 0 0 0; 0 0 0 0; 0 0 0 H; 0 0 0 0];
gst_target_up = gst_target + [0 0 0 0; 0 0 0 0; 0 0 0 H; 0 0 0 0];

%% Execution
% move to real home, home, upup, start_up, start, start_up, target_upup,
% target_up, target, target_up
ur5.move_joints(ur5.home,8)
pause(8.8)

% select a home
if (gst_start_up(1,4)>0) && (gst_start_up(2,4)>0)
    home = [-1.78,-1.76,-0.53,-2.39,1.46,0.01]';
end
if (gst_start_up(1,4)>0) && (gst_start_up(2,4)<0)
    home = [-3.51,-1.85,-0.53,-2.30,1.51,0.01]';
end
if (gst_start_up(1,4)<0) && (gst_start_up(2,4)>0)
    home = [-0.2,-1.85,-0.53,-2.30,1.51,0.01]';
end
if (gst_start_up(1,4)<0) && (gst_start_up(2,4)<0)
    home = [1.20,-1.88,-0.53,-2.23,1.51,0.01]';
end

ur5.move_joints(home, 4);
pause(2*pause_short)

% ur5.move_joints(q1, 5);
% pause(5)


disp('move to start up')
traj = trajGen(ur5FwdKin(ur5.get_current_joints()), gst_start_up );
if(mymove(traj, mode, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short);


disp(' ')
disp('move to start')
traj = trajGen(gst_start_up, gst_start);
if(mymove(traj, mode, para, ur5) == -1)
    rosshutdown
    return
end
pause(pause_short)
myError(ur5, gst_start);
disp(ur5.get_current_joints()*180/pi)


disp('move to start up')
traj = trajGen(gst_start, gst_start_up);
if(mymove(traj, mode, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short)
myError(ur5, gst_start_up); 
disp(ur5.get_current_joints()*180/pi)

% select a home
if (gst_target_up(1,4)>0) && (gst_target_up(2,4)>0)
    home = [-1.78,-1.76,-0.53,-2.39,1.46,0.01]';
end
if (gst_target_up(1,4)>0) && (gst_target_up(2,4)<0)
    home = [-3.51,-1.85,-0.53,-2.30,1.51,0.01]';
end
if (gst_target_up(1,4)<0) && (gst_target_up(2,4)>0)
    home = [-0.2,-1.85,-0.53,-2.30,1.51,0.01]';
end
if (gst_target_up(1,4)<0) && (gst_target_up(2,4)<0)
    home = [1.20,-1.88,-0.53,-2.23,1.51,0.01]';
end
ur5.move_joints(home,8)
pause(8.8)

disp('move to target up')
traj = trajGen(ur5FwdKin(ur5.get_current_joints()), gst_target_up);
if(mymove(traj, mode, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short)


disp('move to target')
traj = trajGen(gst_target_up, gst_target);
if(mymove(traj, mode, para, ur5)==-1)
    rosshutdown
    return
end
pause(pause_short)
myError(ur5, gst_target);
disp(ur5.get_current_joints()*180/pi)


disp('move to target up')
traj = trajGen(gst_target, gst_target_up);
if(mymove(traj, mode, para, ur5) == -1)
    rosshutdown
    return
end
pause(pause_short)
myError(ur5, gst_target_up);
disp(ur5.get_current_joints()*180/pi)

disp('done')