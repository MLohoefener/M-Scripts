% Einrad.m, M-Skript für GNU Octave
% Max Mustermann, HS Merseburg, 24.05.2018
clear; close all  % sicher ist sicher
pkg load control

% Beispielparameter, zum Experimentieren
k_a = 32500;      % [N/m]
d_a = 10000;      % [N.s/m]
m_a = 1300;       % [kg]
k_r = 50000;      % [N/m]
m_r = 20.0;       % [kg]

% Übertragungsfunktionen
s    = tf ('s');                        % Laplace-Op
G_sr = k_r / (m_r*s^2 + d_a*s + k_r+k_a);
G_ar = (d_a*s+k_a) / (m_r*s^2 + d_a*s + k_r+k_a);
G_ra = (d_a*s+k_a) / (m_a*s^2 + d_a*s + k_a);

% Systeme
G_r = minreal (G_sr / (1 - G_ra*G_ar)); % Radbewegung
G_a = minreal (G_r * G_ra);             % Aufbaubewegung

% Präsentation
step (G_r, G_a)
title ('Einrad', 'fontsize', 18)
xlabel ('Zeit t [s]', 'fontsize', 16)
ylabel ('Positionen x(t)', 'fontsize', 16)
legend ('x_R(t) Rad', 'x_A(t) Aufbau  ')
legend boxoff
