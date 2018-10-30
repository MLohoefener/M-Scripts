% State feedback control design in Matlab through pole placement method
% © 2006, doc. RNDr. Ing. Tomáš Březina, CSc., BUT FME, http://www.fme.vutbr.cz

clear

% Parameter of Maxon RE 35 ∅35 mm, Graphite Brushes, 90 Watt
V_nom = 30;     % [V]
T_nom = 0.0972; % [N.m]
K_m = 0.0389;   % [N.m/A]
K_b = 0.0388;   % [V.s]
K_f = 6.33e-6;  % [N.m.s]
R = 1.2;        % [Ohm]
L = 0.34e-3;    % [H]
J = 6.81e-6;    % [kg.m²], [N.m.s²]

A = [0 K_m/J; -K_m/L -R/L];
B = [0 1/L]';
C = [1 0];
D = [0];
ss_Mot_2 = ss(A, B, C, D);

A = [0 1 0; 0 0 K_m/J; 0 -K_m/L -R/L];
B = [0 0 1/L]';
C = [1 0 0];
D = [0];
ss_Mot_3 = ss(A, B, C, D);

s = tf('s');
tf_Mot_2 = 1 / (L*J/K_m * s^2 + R*J/K_m * s + K_m);
tf_Mot_3 = 1 / (L*J/K_m * s^3 + R*J/K_m * s^2 + K_m * s);
step (tf_Mot_2*V_nom);
