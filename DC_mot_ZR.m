% DC_mot_ZR.m – tested with MATLAB + CST and GNU Octave + Control
% Manfred Lohöfener, HS Merseburg, 25.10.2016

% Parameters
V_nom = 30;      % V
T_nom = 0.0972;  % N.m 
K_m   = 0.0389;  % N.m/A
K_b   = 0.0388;  % V.s
K_f   = 6.33e-6; % N.m.s
R     = 1.2;     % Ohm
L     = 0.34e-3; % H
J     = 6.81e-6; % N.m.s²

% State Space Matrices
A = [-R/L -K_b/L    % System matrix
     K_m/J -K_f/J];
B = [V_nom/L 0      % Input matrix
     0 -T_nom/J];
C = [1 0            % Output matrix
     0 1];
D = [0 0            % Transfer matrix
     0 0];

DC_mot = ss (A, B, C, D);
step (DC_mot);

subplot (2, 2, 1)
title ('DC Motor - Step V_{nom}')
xlabel ('Time [s]')
ylabel ('i(t) [A]')

subplot (2, 2, 2)
title ('DC Motor - Step T_{nom}')
xlabel ('Time [s]')
ylabel ('i(t) [A]')

subplot (2, 2, 3)
title ('DC Motor - Step V_{nom}')
xlabel ('Time [s]')
ylabel ('w(t) [rad/s]')

subplot (2, 2, 4)
title ('DC Motor - Step T_{nom}')
xlabel ('Time [s]')
ylabel ('w(t) [rad/s]')

grid ('on')
