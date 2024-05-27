%% Inverse Kinematics
clc;
clear;

%roslaunch rdkdc ur5_simulation.launch

%initializes object to interface with UR5
ur5 = ur5_interface();

ur5.move_joints(ur5.home,10); %default position in RVIZ
pause(6);

%for teaching
%move to start position
startprompt = "Moved to start position Y/N?";
startpos = input(startprompt,"s");
if startpos == 'Y'
    gst1 = ur5.get_current_transformation('base_link','tool0');
end
 
%move to target position
startprompt = "Moved to target position Y/N?";
startpos = input(startprompt,"s");
if startpos == 'Y'
   gst2 = ur5.get_current_transformation('base_link','tool0');
end

%example start and target for testing 
% gst1 = [0 -1 0 0.3; -1 0 0 -0.4; 0 0 -1 0.22; 0 0 0 1];
% gst2 = [0 -1 0 0.30; -1 0 0 0.39; 0 0 -1 0.22; 0 0 0 1];

%calculate positions 7.5cm above start and target positions
gst1_above = gst1;
gst1_above(3,4) = gst1(3,4) + 0.075;

gst2_above = gst2;
gst2_above(3,4) = gst2(3,4) + 0.075;

%for testing, create frames at start/target, above start/target
tf_frame('base_link','start_IK', gst1);
tf_frame('base_link','target_IK', gst2);
% tf_frame('base_link','above start', gst1_above);
% tf_frame('base_link','above target', gst2_above);

%run given inverse kinematics function to return 6x8 matrix of poss joint
%angles for four positions 
q1 = ur5InvKin(gst1);
q1_above = ur5InvKin(gst1_above);
q2 = ur5InvKin(gst2);
q2_above = ur5InvKin(gst2_above);

%for no collision: joint 2 = [0, -pi] (at most parallel to table)

%initialize array for selected above start joint angles
q1_abovestart = zeros(6,1);

num = 1;
for i = 1:length(q1_above)
    q1_col = q1_above(:,i);
   
    %ensure that 2nd joint is within range where first link does not hit table 
    if q1_col(2) < 0 && q1_col(2) > -pi
        
        %calculate HTM of joint4 using modified fwdkin function
        
        g_joint4 = ur5FwdKin_joint4(q1_col - ur5.home);
        
        %chose joint vectors where joint 4 is at least 25cm above table
        if g_joint4(3,4) > 0.25
            q1_abovestart(:,num) = q1_col;
            num = num +1;
        end
    end
end

%from here need code to find column of joint angles that is closest to
%home using norm
for i = 1:size(q1_abovestart,2)
    norm_starthome(i) = norm(q1_abovestart(:,i) - ur5.home);
end

[row,index] = min(norm_starthome);
q1_abovestart = q1_abovestart(:,index);

%then need to repeat same joint elimination criteria and norm for above target, except this
%time using norm to find closest to selected start pos 

%initialize array for selected above target joint angles
q2_abovetarget = zeros(6,1);

num = 1;
for i = 1:length(q2_above)
    q2_col = q2_above(:,i);
   
    %ensure that 2nd joint is within range where first link does not hit table 
    if q2_col(2) < 0 && q2_col(2) > -pi
        
        %calculate HTM of joint4 using modified fwdkin function
        
        g_joint4 = ur5FwdKin_joint4(q2_col - ur5.home);
        
        %chose joint vectors where joint 4 is at least 25cm above table
        if g_joint4(3,4) > 0.25
            q2_abovetarget(:,num) = q2_col;
            num = num +1;
        end
    end
end

%from here need code to find column of joint angles that is closest to
%above start using norm
for i = 1:size(q2_abovetarget,2)
    norm_targetstart(i) = norm(q2_abovetarget(:,i) - ur5.home);
end

[row,index] = min(norm_targetstart);
q2_abovetarget = q2_abovetarget(:,index);

%repeat norm procedure to find angles for for start and target closest to
%above start and above target respectively 

%for start
for i = 1:size(q1,2)
    norm_start(i) = norm(q1(:,i) - ur5.home);
end

[row,index] = min(norm_start);
q1 = q1(:,index);

%for target
for i = 1:size(q2,2)
    norm_target(i) = norm(q2(:,i) - ur5.home);
end

[row,index] = min(norm_target);
q2 = q2(:,index);

%move ur5 through move and place 
ur5.move_joints(q1_abovestart,6); %move 7.5cm above start
pause(6);

ur5.move_joints(q1,6); %move straight down to start position
pause(6);

ur5.move_joints(q1_abovestart,6); %move 7.5cm above start
pause(6);

ur5.move_joints(q2_abovetarget,6); %move 7.5cm above target
pause(6);

ur5.move_joints(q2,6); %move straight down to target
pause(6);
%% Resolved Rate Control
clear all
clc

ur5 = ur5_interface();
% ur5.move_joints(ur5.home,10); %default position in RVIZ
% pause(10);

% teach start and target points
w = waitforbuttonpress;

if w == 1
    qk = ur5.get_current_joints;
    gst = ur5FwdKin(qk-ur5.home); % Initial g
    fprintf('teach start position\n')
end

w = waitforbuttonpress;

if w == 1
    target_q = ur5.get_current_joints;
    gdesired = ur5FwdKin(target_q-ur5.home); % target g
    fprintf('teach target position\n')
end

%for testing, create frames at start/target
tf_frame('base_link','start_RR', gst);
tf_frame('base_link','target_RR',gdesired);

%example start and target for simulation 
% gst = [0 -1 0 0.3; -1 0 0 -0.4; 0 0 -1 0.22; 0 0 0 1];
% gdesired = [0 -1 0 0.30; -1 0 0 0.39; 0 0 -1 0.22; 0 0 0 1];

%calculate positions 7.5cm above start and target positions
gst_above = gst;
gst_above(3,4) = gst(3,4) + 0.075;

gdesired_above = gdesired;
gdesired_above(3,4) = gdesired(3,4) + 0.075;

%run given inverse kinematics function to return 6x8 matrix of poss joint
%angles for four positions 
q1 = qk;
q1_above = ur5InvKin(gst_above);
q2 = target_q;
q2_above = ur5InvKin(gdesired_above);

%for no collision: joint 2 = [0, -pi] (at most parallel to table)

%initialize array for selected above start joint angles
q1_abovestart = zeros(6,1);

num = 1;
for i = 1:length(q1_above)
    q1_col = q1_above(:,i);
   
    %ensure that 2nd joint is within range where first link does not hit table 
    if q1_col(2) < 0 && q1_col(2) > -pi
        
        %calculate HTM of joint4 using modified fwdkin function
        
        g_joint4 = ur5FwdKin_joint4(q1_col - ur5.home);
        
        %chose joint vectors where joint 4 is at least 25cm above table
        if g_joint4(3,4) > 0.25
            q1_abovestart(:,num) = q1_col;
            num = num +1;
        end
    end
end

%from here need code to find column of joint angles that is closest to
%home using norm
for i = 1:size(q1_abovestart,2)
    norm_starthome(i) = norm(q1_abovestart(:,i) - ur5.home);
end

[row,index] = min(norm_starthome);
q1_abovestart = q1_abovestart(:,index);

%initialize array for selected above target joint angles
q2_abovetarget = zeros(6,1);

num = 1;
for i = 1:length(q2_above)
    q2_col = q2_above(:,i);
   
    %ensure that 2nd joint is within range where first link does not hit table 
    if q2_col(2) < 0 && q2_col(2) > -pi
        
        %calculate HTM of joint4 using modified fwdkin function
        
        g_joint4 = ur5FwdKin_joint4(q2_col - ur5.home);
        
        %chose joint vectors where joint 4 is at least 25cm above table
        if g_joint4(3,4) > 0.25
            q2_abovetarget(:,num) = q2_col;
            num = num +1;
        end
    end
end

%from here need code to find column of joint angles that is closest to
%above start using norm
for i = 1:size(q2_abovetarget,2)
    norm_targetstart(i) = norm(q2_abovetarget(:,i) - ur5.home);
end

[row,index] = min(norm_targetstart);
q2_abovetarget = q2_abovetarget(:,index);

%move ur5 through move and place 
% ur5.move_joints(q1_abovestart,10); %move 7.5cm above start
% pause(10);
% 
% ur5.move_joints(q1,10); %move straight down to start position
% pause(10);

% Define parameters
v_threshold = 0.003; %m
w_threshold = 5*pi/180; %rad
Tstep= 0.01; %sec
K = 0.3; % gain

% Calculate errors & allocate appropriate dimensions of matrix
error_g = pinv(gdesired)*gst;
xi_k = getXi(error_g);
v = xi_k(1:3);
w = xi_k(4:6);

while norm(v) > v_threshold || norm(w) > w_threshold
    
    error_g = pinv(gdesired)*gst;
    xi_k = getXi(error_g);
    v = xi_k(1:3);
    w = xi_k(4:6);
    
    J = ur5BodyJacobian(qk);
    qk = qk-pinv(J)*xi_k*K*Tstep; % update joint configuration
    

    gst = ur5FwdKin(qk-ur5.home); % update gst
    finalerr = norm(gst(1:3,4))

     if abs(manipulability(J,'sigmamin')) <=0.0001 % test manipulability
        finalerr = -1;
        disp(finalerr)
        disp('ABORT singularity')
     end
end

%move ur5 through move and place 
% ur5.move_joints(q1_abovestart,10); %move 7.5cm above start
% pause(10);
% 
% ur5.move_joints(q2_abovetarget,10); %move 7.5cm above target
% pause(10);
% 
% ur5.move_joints(qk,20); %move straight down to target
% pause(10);

J = ur5BodyJacobian(qk);
gst_final = ur5FwdKin(qk-ur5.home); % final gst
finalerr = norm(gst_final(1:3,4))-norm(gdesired(1:3,4)); % normalize position vector of final homogeneous matrix since the finalerror is a scalar
V = K*inv(J)*xi_k; %Joint space velocity
disp(['Final error = ',num2str(finalerr)]) % display
% display the Joint space velocity
disp('Joint space  velocity = ');
disp(V);

%% Test Transpose Jacobian Control
clear all
clc

ur5 = ur5_interface();
ur5.move_joints(ur5.home,10); %default position in RVIZ
pause(10);

% teach start and target points

w = waitforbuttonpress;

if w == 1
    qk = ur5.get_current_joints;
    gst = ur5FwdKin(qk-ur5.home); % Initial g
    fprintf('teach start position\n')
end

w = waitforbuttonpress;

if w == 1
    target_q = ur5.get_current_joints;
    gdesired = ur5FwdKin(target_q-ur5.home); % target g
    fprintf('teach target position\n')
end

%for testing, create frames at start/target
tf_frame('base_link','start_tj', gst);
tf_frame('base_link','target_tj',gdesired);

%example start and target for simulation 
% gst = [0 -1 0 0.3; -1 0 0 -0.4; 0 0 -1 0.22; 0 0 0 1];
% gdesired = [0 -1 0 0.30; -1 0 0 0.39; 0 0 -1 0.22; 0 0 0 1];

%calculate positions 7.5cm above start and target positions
gst_above = gst;
gst_above(3,4) = gst(3,4) + 0.075;

gdesired_above = gdesired;
gdesired_above(3,4) = gdesired(3,4) + 0.075;

%run given inverse kinematics function to return 6x8 matrix of poss joint
%angles for four positions 
q1 = qk;
q1_above = ur5InvKin(gst_above);
q2 = target_q;
q2_above = ur5InvKin(gdesired_above);

%for no collision: joint 2 = [0, -pi] (at most parallel to table)

%initialize array for selected above start joint angles
q1_abovestart = zeros(6,1);

num = 1;
for i = 1:length(q1_above)
    q1_col = q1_above(:,i);
   
    %ensure that 2nd joint is within range where first link does not hit table 
    if q1_col(2) < 0 && q1_col(2) > -pi
        
        %calculate HTM of joint4 using modified fwdkin function
        
        g_joint4 = ur5FwdKin_joint4(q1_col - ur5.home);
        
        %chose joint vectors where joint 4 is at least 25cm above table
        if g_joint4(3,4) > 0.25
            q1_abovestart(:,num) = q1_col;
            num = num +1;
        end
    end
end

%from here need code to find column of joint angles that is closest to
%home using norm
for i = 1:size(q1_abovestart,2)
    norm_starthome(i) = norm(q1_abovestart(:,i) - ur5.home);
end

[row,index] = min(norm_starthome);
q1_abovestart = q1_abovestart(:,index);

%initialize array for selected above target joint angles
q2_abovetarget = zeros(6,1);

num = 1;
for i = 1:length(q2_above)
    q2_col = q2_above(:,i);
   
    %ensure that 2nd joint is within range where first link does not hit table 
    if q2_col(2) < 0 && q2_col(2) > -pi
        
        %calculate HTM of joint4 using modified fwdkin function
        
        g_joint4 = ur5FwdKin_joint4(q2_col - ur5.home);
        
        %chose joint vectors where joint 4 is at least 25cm above table
        if g_joint4(3,4) > 0.25
            q2_abovetarget(:,num) = q2_col;
            num = num +1;
        end
    end
end

%from here need code to find column of joint angles that is closest to
%above start using norm
for i = 1:size(q2_abovetarget,2)
    norm_targetstart(i) = norm(q2_abovetarget(:,i) - ur5.home);
end

[row,index] = min(norm_targetstart);
q2_abovetarget = q2_abovetarget(:,index);

%move ur5 through move and place 
ur5.move_joints(q1_abovestart,10); %move 7.5cm above start
pause(10);

ur5.move_joints(q1,10); %move straight down to start position
pause(10);

% Define parameters
v_threshold = 0.003; %m
w_threshold = 5*pi/180; %rad
Tstep= 0.1; %sec
K = 0.5; % gain

% Calculate errors & allocate appropriate dimensions of matrix
error_g = gdesired\gst;
xi_k = getXi(error_g);
v = xi_k(1:3);
w = xi_k(4:6);

while norm(v) > v_threshold || norm(w) > w_threshold
    
    error_g = gdesired\gst;
    xi_k = getXi(error_g);
    v = xi_k(1:3);
    w = xi_k(4:6);
    
    
    J = ur5BodyJacobian(qk);
    qk = qk-(transpose(J)*xi_k)*K*Tstep % update joint configuration
    
    qk = mod(qk,pi); % restrict range of qk between -pi and pi
%     if qk(2)>=0 && qk(2) <=-pi
%         finalerr = -1;
%         disp(finalerr)
%         disp('ABORT singularity')
%     end

    gst = ur5FwdKin(qk-ur5.home); % update gst
%     pause(1)

     if abs(manipulability(J,'sigmamin')) <=0.0001 % test manipulability
        finalerr = -1;
        disp(finalerr)
        disp('ABORT singularity')
        break
     end
end

%move ur5 through move and place 
ur5.move_joints(q1_abovestart,10); %move 7.5cm above start
pause(6);

ur5.move_joints(q2_abovetarget,20); %move 7.5cm above target
pause(6);

ur5.move_joints(qk,20); %move straight down to target
pause(6);

J = ur5BodyJacobian(qk);
gst_final = ur5FwdKin(qk-ur5.home); % final gst
finalerr = norm(gst_final(1:3,4))-norm(gdesired(1:3,4)); % normalize position vector of final homogeneous matrix since the finalerror is a scalar
V = K*transpose(J)*xi_k; %Joint space velocity
disp(['Final error = ',num2str(finalerr)]) % display
% display the Joint space velocity
disp('Joint space  velocity = ');
disp(V);