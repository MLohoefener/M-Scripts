% Script zur Darstellung von Signalen: Signale.m
% 08.03.2019, Manfred Lohoefener, Leipzig
% color
%    ‘k’	blacK
%    ‘r’	Red
%    ‘g’	Green
%    ‘b’	Blue
%    ‘y’	Yellow
%    ‘m’	Magenta
%    ‘c’	Cyan
%    ‘w’	White

clear; close all

T_E = 1;          % [s]
T_D = 0.001;      % [s]
tmin = -0.1;
tmax = 1.1;
ymin = -0.1;
ymax = 1.6;

x_t = 0:T_D:T_E;  % [s] Zeitachse

% Deterministisch
sigma = round (x_t*0.9);
dirac = zeros (1, length(x_t));
dirac (1, T_E/T_D/4-1:T_E/T_D/4+1) = 1.2;
sinus = sin (x_t*15)*0.8;
kosinus = cos (x_t*10)*0.5;
rechteck = sign (kosinus)*0.4+0.5;

% Stochastisch
PRBS = [1 1 1 -1 1 -1 -1];
x_PRBS = 0:T_E/6:T_E;
%xi = rand (1, 101)-0.5;
%x_xi = 0:T_E/100:T_E;
xi = randn (1, T_E/T_D+1)*0.5;
x_xi = x_t;
xi_f = zeros (1, length(xi));
for i = 2:length(xi)-1
  xi_f (i) = (xi_f(i-1)*0.99 + xi(i)*0.05);
end
gemisch = x_t + xi_f*0.2;

figure ('Name', 'Determiniert', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  plot (x_t, sigma, 'b', 'LineWidth', 1)
  stairs (x_t, dirac, 'r', 'LineWidth', 1)
  plot ([0 T_E], [0 1.5], 'g', 'LineWidth', 1)  % Rampe
  plot (x_t, sinus, 'm', 'LineWidth', 1)
  plot (x_t, rechteck, 'k', 'LineWidth', 1)
  axis ([tmin tmax ymin ymax])
  title ('Determinierte Signale', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Signale')
  legend ('Sprung \sigma(t)', 'Impuls \delta(t)', 'Rampe a(t)', 'Sinus(t)', 'Rechteck(t)', 'location', 'east')
  legend boxoff
  printgcf (mfilename, 0)

figure ('Name', 'Stochastisch', 'NumberTitle', 'off', 'Position', [200 0 800 600])
  set (gca, 'FontSize', 18); hold on
  stairs (x_PRBS, PRBS, 'b', 'LineWidth', 1)
  plot (x_xi, xi, 'c', 'LineWidth', 1)
  plot (x_xi, xi_f, 'r', 'LineWidth', 1)
  plot (x_t, gemisch, 'g', 'LineWidth', 1)
  axis ([tmin tmax -ymax ymax])
  title ('Stochastische Signale', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Signale')
  legend ('PRBS(t)', 'weißes Rauschen \xi(t)', 'rosa Rauschen \xi_f(t)', 'Signalgemisch', 'location', 'east')
  legend boxoff
  printgcf (mfilename, 0)
