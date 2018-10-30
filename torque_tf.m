% torque_tf.m use with MATLAB and GNU Octave
% M. Lohöfener, HS Merseburg, 25/10/2016

clear

% Parameter
k   = 1;	% N.m/rad
c   = 1;	% N.m.s/rad
J_1 = 1;	% N.m.s²/rad
J_2 = 1;	% N.m.s²/rad
T   = 1;	% N.m
T_end = 5; % s

% Transfer functions
s = tf ('s');
G_Tphi1 = 1 / (J_1*s^2 + c*s + k);
G_phi2phi1 = (c*s + k) / (J_1*s^2 + c*s + k);
G_phi1phi2 = (c*s + k) / (J_2*s^2 + c*s + k);
G_0 = G_phi2phi1 * G_phi1phi2;

% System
phi_1 = G_Tphi1 / (1 - G_0);
phi_2 = G_Tphi1 * G_phi1phi2 / (1 - G_0);

% Presentation
step (phi_1, phi_2, T_end);
title ('Step answer h(t)');
xlabel ('Time [s]');
ylabel ('Angle [rad]');
legend ('phi_1(t)','phi_2(t)');
grid ('on');
