% m_b_k_tf.m use with MATLAB and GNU Octave
% M. Lohöfener, HS Merseburg, 24/10/2016

clear 

% Parameter
m = 0.141;	% kg
k = 20;	    % N/m
b = 0.5;	  % Ns/m
F = 1;	    % N

% Transfer functions
s = tf('s');
G = 1 / (m*s^2 + b*s + k);

% Presentation
step(G*F);
title('Step answer h(t)');
xlabel('Time [s]');
ylabel('Deflection [m]');
legend('y(t)');
grid('on');
