% Z-Transformation mit MATLAB / Octave cont2dis.m
% 07.04.2016, M. Lohöfener

clear; close all

% P-T_D1-T_2-Glied 
K_P = 1.5;  % Proportionalfaktor
T_D1= 1.0;  % [s] Vorhaltzeitkonstante
T   = 2.0;  % [s] Kennzeitkonsante
D   = 0.5;  % Kenndaempfung
T_0 = 0.5;  % [s] Abtastzeit
T_E = 20;   % [s] Simulationsende
t   = 0: 0.01: T_E;
td  = 0: T_0: T_E;

s   = tf ('s');     % Operator bauen
G_s = K_P*(T_D1*s + 1) / (T^2*s^2 + 2*T*D*s + 1)

% Transformation  
G_z = c2d (G_s, T_0)  % kontinuierlich zu diskret 
[b_i, a_i, T_0d] = tfdata (G_z, 'v');
% MATLAB-Octave-Kompatibilitaet
b_i = [zeros(1, length(a_i)-length(b_i)) b_i];

% Test
G_s2 = d2c (G_z)      % diskret zu kontinuierlich 

% Präsentation
figure ('Name', 'Sprungantwort', 'NumberTitle', 'off', 'Position', [0 100 800 600]);
set (gca, 'FontSize', 15); hold on
[y, t] = step (G_s, t);
[yd, td] = step (G_z, td);
plot (t, y, 'r')
ylim ([0 1.8])
hold on
stairs (td, yd)
set (findobj (gcf, 'type', 'line'), 'LineWidth', 1);
title ('P-T_{D1}-T_2-System', 'fontsize', 18)
xlabel ('Zeit t [s]')
ylabel ('Verlauf')
legend ('h(t) kontinuierlich    ', 'h(k) diskret', 'location', 'east')
legend boxoff
printgcf (mfilename, 0)

%  Octave Output
%  
%  Transfer function 'G_s' from input 'u1' to output ...
%  
%          1.5 s + 1.5
%   y1:  ---------------
%        4 s^2 + 2 s + 1
%  
%  Continuous-time model.
%  
%  Transfer function 'G_z' from input 'u1' to output ...
%  
%          0.2072 z - 0.1246
%   y1:  ----------------------
%        z^2 - 1.724 z + 0.7788
%  
%  Sampling time: 0.5 s
%  Discrete-time model.
%  
%  Transfer function 'G_s2' from input 'u1' to output ...
%  
%         0.375 s + 0.375
%   y1:  ------------------
%        s^2 + 0.5 s + 0.25
%  
%  Continuous-time model.
