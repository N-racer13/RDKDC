clear; clc;

ur5 = ur5_interface();

q = [0;-90;0;45; 0;0];

q = q*pi/180;

ur5.move_joints(q,3);


 -180.0023
 -150.1054
  145.4915
  -83.4654
 -104.1189
 -179.9998


