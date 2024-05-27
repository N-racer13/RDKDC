ur5=ur5_interface()

ksi = [1; 0; 1/(2*pi); 0; 0; 1];
omega = ksi(1:3);
v = ksi(4:6);
for i = 1:100
    theta = 2*pi/100*i
    R = EXPCR(omega*theta);
    p = (eye(3) - EXPCR(omega*theta))*(cross(omega, v)) + omega*transpose(omega)*v*theta;
    g0i = rotm2tform(R);
    g0i(1:3, 4) = p;
    
    Frame_i = tf_frame('base_link', sprintf('Frame_%d', i), g0i);
    pause(0.3)
end