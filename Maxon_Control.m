% Script Maxon_Control.m
% Manfred Lohöfener
% 06/11/2017, Brno, BUT, FME

clear
close all

%% Data of Maxon Motor RE 35 ∅35 mm, Graphite Brushes, 90 Watt
% Values at nominal voltage
u_nom = 30;               % [V] Nominal voltage
w_idl_r = 7280;           % [rpm] No load speed
w_idl = w_idl_r*2*pi/60;  % [rad/s]
i_idl = 0.0941;           % [A] No load current
w_nom_r = 6470;           % [rpm] Nominal speed
w_nom = w_nom_r*2*pi/60;  % [rad/s]
T_nom = 0.101;            % [N.m] Nominal torque
I_nom = 2.68;             % [A] Nominal current
T_max = 0.976;            % [N.m] Stall torque
I_max = 25.1;             % [A] Stall current
e_max = 0.87;             % Max. efficiency

% Characteristics
R_T = 1.2;                % [Ω], [Ohm] Terminal resistance
L_T = 0.00034;            % [H] Terminal inductance
K_m = 0.0389;             % [N.m/A] Torque constant
s_c = 246;                % [rpm/V] Speed constant
K_b = 60 / (s_c*2*pi);    % [V.s] Speed constant
w_g = 7.55;               % [rpm/mN.m] Speed/torque gradient
T_m = 0.00537;            % [s] Mechanical time constant
J_R_g = 67.9;             % [g.cm²] Rotor inertia
J_R = J_R_g/10^3/100^2;   % [kg.m²], [N.m.s²] Rotor inertia
K_f = K_m*i_idl/w_idl;    % [N.m.s] Friction

%% Transfer Functions TF of controlled system
% Simple TF of Maxon Motor
s = tf('s');
G_ui =    1 / (R_T + L_T*s);
G_wi = -K_b / (R_T + L_T*s);
G_iw =  K_m / (K_f + J_R*s);
G_Tw =   -1 / (K_f + J_R*s);

% System TF of Maxon Motor
Gs_uw = minreal (G_ui*G_iw / (1 - G_iw*G_wi));
Gs_Tw = minreal (     G_Tw / (1 - G_iw*G_wi));
Gs_ui = minreal (     G_ui / (1 - G_iw*G_wi));
Gs_Ti = minreal (G_Tw*G_wi / (1 - G_iw*G_wi));

% Gear TF
K_G = 1 / w_nom;                %  [m] Gear with 1 m/s for nominal speed
G_wy = K_G / s;                 % omega(t) -> y(t)
G_uy = minreal (Gs_uw * G_wy);  % System TF

figure ('Name', 'Step Answer omega(t)', 'NumberTitle', 'off', 'Position', [0 0 800 600]);
  set (gca, 'FontSize', 15); hold on
  step (Gs_uw*u_nom, Gs_Tw*T_nom, 0.05);
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 2);
  grid on
  title ('DC Motor - Speed')
  xlabel ('Time [s]')
  ylabel ('w(t) [rad/s]')
  legend ('w(t) u_{nom}', 'w(t) T_{nom}')
  legend boxoff
  
figure ('Name', 'Step Answer i(t)', 'NumberTitle', 'off', 'Position', [0 100 800 600]);
  set (gca, 'FontSize', 15); hold on
  step (Gs_ui*u_nom, Gs_Ti*T_nom, 0.05);
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 2);
  grid on
  title ('DC Motor - Current')
  xlabel ('Time [s]')
  ylabel ('i(t) [A]')
  legend ('i(t) u_{nom}', 'i(t) T_{nom}')
  legend boxoff

%% PID Controller

% Ziegler-Nichols Stability limit
%K_P = 93200;                          % Proportional gain, tested limit
%T_I = 9999;                           % [s] Integral time constant
%T_D = 0.0;                            % [s] Differential time constant

%K_crit = 93200;                     % through experiments
%T_crit = 0.0077;                    % [s]
%K_P = 0.6 * K_crit;                 % Ziegler-Nichols, 55920
%T_I = T_crit / 2;                   % [s] 0.0039
%T_D = T_crit / 8;                   % [s] 9.6250e-04

% Quarter-Damping Method
%K_P = 18000;                        % Proportional gain, 1/4 damping
%T_I = 9999;                         % [s] Integral time constant
%T_D = 0.0;                          % [s] Differential time constant

K_q = 18000;                        % Proportional gain
T_q = 0.017;                        % T_p = 17 ms, measured 1/4 damping
K_P = 1.2 * K_q;                    % Proportional gain
T_I = 0.6*T_q;                      % [s] Integral time constant
T_D = 0.15*T_q;                     % [s] Differential time constant

% Manual choice
%K_P = 500;                           % Proportional gain, manual choice
%T_I = 10;                            % [s] Integral time constant
%T_D = 0.001;                         % [s] Differential time constant

G_C = pidstd (K_P, T_I, T_D, 100);    % Choose parameters 

%% Control Circuit
G_ry = feedback (G_C*G_uy, 1);  % Feedback: r_set -> y_contr
G_ru = feedback (G_C, G_uy);    % Feedback: r_set -> u

figure ('Name', 'Control Circuit', 'NumberTitle', 'off', 'Position', [200 200 800 600]);
  set (gca, 'FontSize', 15); hold on
  time_x = 0:0.001:5;           % 5 s are of interest
  step (G_ry, G_ru, time_x)
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 2);
  grid on
  title ('Position Control')
  xlabel ('Time [s]')
  ylabel ('y(t) [m], u(t) [V]')
  legend (['y(t) with K_P = ', num2str(K_P)], 'u(t)', 'Location', 'East')
  legend boxoff
  axis ([0 1 -1 10])
%  axis ([0 0.2 -1 10])

% Poles of any feedback are equal to zeros of characteristic equation
format short eng
p_i_ry = pole (G_ry)';          % Example
p_i_ru = pole (G_ru)';
s_i = zero (1 + G_uy*G_C)';     % s_i == p_i, q.e.d.
disp ('Poles of TF ry and ru, and zeros of characteristic equation')
disp ([p_i_ry; p_i_ru; s_i])
