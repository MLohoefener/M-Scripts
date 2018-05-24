% Einrad_ZR.m – getestet mit MATLAB + CST sowie GNU Octave + Control
% Manfred Lohöfener, HS Merseburg, 27.10.2015
clear; close all  % sicher ist sicher
pkg load control

% Parameter
    ka = 32500;	% N/m
    da = 10000;	% Ns/m
    ma = 1300;	% kg
    kr = 50000;	% N/m
    mr = 20.0;	% kg
    
% Differenzialgleichungssystem
    M = [ma 0
         0 mr];   
    D = [da -da
         -da da];
    K = [ka -ka
         -ka kr+ka];
    Ke = [0
          kr];
    
% Transformation in Zustandsraum
    [nr, nc] = size (M);
    A = [zeros(nr, nc) eye(nr, nc)
         -inv(M)*K -inv(M)*D];       
    B = [zeros(nr, 1)
         inv(M)*Ke];       
    C=[eye(nr, nc) zeros(nr, nc)];

    Einrad_ss = ss (A, B, C)
    step (Einrad_ss)
    subplot (2, 1, 1)
      title ('Einrad – Aufbau', 'fontsize', 18)
      xlabel ('Zeit t [s]', 'fontsize', 16)
      ylabel ('Position x_A(t)', 'fontsize', 16)
      grid ('on')
    subplot (2, 1, 2)
      title ('Einrad – Rad', 'fontsize', 18)
      xlabel ('Zeit t [s]', 'fontsize', 16)
      ylabel ('Position x_R(t)', 'fontsize', 16)
      grid ('on')
