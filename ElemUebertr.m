% Elementare Übertragungsglieder ElemUebertr.m
% ÜbergangsfunkT_Ionen à la carte 
% 05.04.2016, M. Lohöfener

clear all
close all

K_P = 0.8; % Proportionalfaktor
T_I = 1.5;  % Integratonszeitkonstante in s
T_L = 1.8; % Laufzeit in s
T_1 = 2; % Verzögerung P-T_1-Glied in s
T_2 = 0.5; % Kennzeitkonstante P-T_2-Glied
T_D1 = 0.5;  % Vorhalt in s
T_D2 = 3;  % Vorhalt in s
T_0 = 0.5;  %Abtastzeit
tmin = -0.5;
tmax = 5;
ymin = -0.1;
ymax = 1.1;
s = tf ('s');  % Laplace-Operator
z = tf ('z', T_0);  % Verschiebe-Operator
t = 0:0.01:5; % Zeitachse
tz = 0:T_0:5;  

% P-Glied

figure ('Name', 'P-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([0 tmax], [K_P K_P], 'm', 'LineWidth', 1)
  axis ([tmin tmax ymin ymax])
  title ('P-Glied mit K_P = 0,8', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('\sigma(t)', 'h(t) = h(k)', 'location', 'east')
  legend boxoff
  printgcf (mfilename, 0)

% I-Glied

Gi = 1 / (T_I*s);
Giz = c2d (Gi, T_0);
figure ('Name', 'I-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  step (Gi, tmax, 'm'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (Giz, tmax, 'b'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([T_I T_I], [-0.05 1.05], 'g', 'LineWidth', 1)
  plot ([-0.05 1], [1/T_I 1/T_I], 'c', 'LineWidth', 1)
  plot ([0 0], [ymin 3.5], 'k', 'LineWidth', 1)
  axis ([tmin tmax ymin 3.5])
  title ('I-Glied mit T_I = 1,5 s und T_0 = 0,5 s', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('h(t)', 'h(k)', '\sigma(t)', 'T_I', 'K_I = 1/T_I', 'location', 'southeast');
  legend boxoff
  printgcf (mfilename, 0)

% P-T_L-Glied

figure ('Name', 'P-T_L-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([T_L T_L], [0 K_P], 'm', 'LineWidth', 1)
  plot ([2 2], [0 K_P], 'b', 'LineWidth', 1)
  plot([-0.05 T_L], [K_P K_P], 'c', 'LineWidth', 1)
  plot ([T_L T_L], [0 K_P], 'm', 'LineWidth', 1)
  plot ([T_L tmax], [K_P K_P], 'm', 'LineWidth', 1)
  plot ([2 tmax], [K_P K_P], 'b', 'LineWidth', 1)
  axis  ([tmin tmax ymin ymax])
  title ('P-T_L- Glied mit K_P = 0,8, T_L = 1,8 s und T_0 = 0,5 s', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('\sigma(t)', 'h(t)', 'h(k)', 'Asymptote K_P', 'location', 'east');
  legend boxoff
  printgcf (mfilename, 0)

% P-T_1-Glied

Gp = K_P/(1 + T_1*s);
Gpz = c2d (Gp, T_0);
figure ('Name', 'P-T_1-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  step (Gp, tmax, 'm');set(gca,'FontSize',16); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (Gpz, tmax, 'b'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([-0.05*T_1 1.05*T_1], [-0.05*K_P 1.05*K_P], 'g', 'LineWidth', 1)
  plot ([-0.05 tmax], [K_P K_P], 'c', 'LineWidth', 1)
  plot ([T_1 T_1], [-0.05 K_P*1.05], 'g', 'LineWidth', 1)
  axis ([tmin tmax ymin ymax])
  title ('P-T_1-Glied mit K_P = 0,8 , T_1 = 2 s und T_0 = 0,5 s', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('h(t)', 'h(k)', '\sigma(t)', 'Tangente bis T_1', 'Asymptote K_P', 'location', 'east');
  legend boxoff
  printgcf (mfilename, 0)

% P-T_2*-Glied mit Kenndämpfungen D
D1 = 1.5;	% aperiodisch
D2 = 1.0;	% aperiodischer Grenzfall
D3 = 1/sqrt(2);	% Resonanzgrenzfall D = 0.71
D4 = 0.3;	% periodisch
D5 = 0.0;	% ungedämpft
D6 = -0.3;	% ungedämpft

% f = 0.1: 0.01: 5;	% rad/s – Frequenzbereich

Gs1 = K_P / (T_2^2*s^2 + 2*D1*T_2*s + 1);
Gs2 = K_P / (T_2^2*s^2 + 2*D2*T_2*s + 1);
Gs3 = K_P / (T_2^2*s^2 + 2*D3*T_2*s + 1);
Gs4 = K_P / (T_2^2*s^2 + 2*D4*T_2*s + 1);
Gs4z = c2d (Gs4, T_0);
Gs5 = K_P / (T_2^2*s^2 + 2*D5*T_2*s + 1);
Gs6 = K_P / (T_2^2*s^2 + 2*D6*T_2*s + 1);

figure ('Name', 'P-T_2-System', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  plot(t, step(Gs1, t), 'LineWidth', 1)
  plot (t, step(Gs2, t), 'LineWidth', 1)
  plot (t, step(Gs3, t), 'LineWidth', 1)
  plot (t, step(Gs4, t), 'LineWidth', 1)
  plot (t, step(Gs5, t), 'LineWidth', 1)
  plot (t, step(Gs6, t), 'LineWidth', 1)
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (Gs4z, tmax, 'b'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([-0.05 tmax], [K_P K_P], 'g', 'LineWidth', 1)
  title('P-T_2*-System mit K_P = 0,8, T = 0,5 s und T_0 = 0,5 s', 'fontsize', 20)
  axis ([tmin tmax ymin 3])
  xlabel('Zeit t in s')
  ylabel('Ein- und Ausgangssignale')
  legend('D = 1.5', 'D = 1.0', 'D = 0.71', 'D = 0.3', 'D = 0.0', 'D = -0.3', ...
    'h(k) mit D = 0,3', '\sigma(t)', 'Asymptote K_P');
  legend boxoff
  printgcf (mfilename, 0)

% I-T_1-Glied

Git = 1/T_I/s/(1 + T_1*s);
Gitz = c2d (Git, T_0);
figure ('Name', 'I-T_1-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  step (Git, tmax, 'm');set(gca,'FontSize',16); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (Gitz, tmax, 'b'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([-0.05 3], [-0.05/T_I 3/T_I], 'g', 'LineWidth', 1)
  plot ([T_1-0.05 T_1+3], [-0.05/T_I 3/T_I], 'c', 'LineWidth', 1)
  plot ([T_I T_I], [-0.05 1.05], 'g', 'LineWidth', 1)
  axis ([tmin tmax ymin 2])
  title ('I-T_1-Glied mit T_I = 1,5 s , T_1 = 2 s und T_0 = 0,5 s', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('h(t)', 'h(k)', '\sigma(t)', 'Asymptote T_I', 'Asymptote T_1', 'location', 'west');
  legend boxoff
  printgcf (mfilename, 0)

% P-T_D1-T_1-Glied

Gdt = K_P*(1 + T_D1*s)/(1 + T_1*s);
Gdtz = c2d (Gdt, T_0);
GdT_2 = K_P*(1 + T_D2*s)/(1 + T_1*s);
GdT_2z = c2d (GdT_2, T_0);
figure ('Name', 'P-T_D1-T_1-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  step (Gdt, tmax, 'm'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (Gdtz, tmax, 'c'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (GdT_2, tmax, 'b'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  step (GdT_2z, tmax, 'k'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([-0.05 tmax], [K_P K_P], 'g', 'LineWidth', 1)
  axis ([tmin tmax ymin 1.5])
  title ({'P-T_{D1}-T_1-Glied mit K_P = 0,8, T_{D1} = 0.5 s bzw. 3 s,', ...
    'T_1 = 2 s und T_0 = 0,5 s', ''}, 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('h(t), T_{D1} < T_1', 'h(k), T_{D1} < T_1', 'h(t), T_{D1} > T_1', ...
    'h(k), T_{D1} > T_1', '\sigma(t)', 'Asymptote K_P', 'location', 'east');
  legend boxoff
  printgcf (mfilename, 0)

% D-Glied fuer Dirac-Impuls
x = -6 : 0.05 : 6;
y = double(x == 0);
figure ('Name', 'D-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  plot(x, y, 'LineWidth', 1)
  bar (T_0/2, 2*K_P, T_0/2); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  axis ([tmin tmax ymin 1.8])
  title ('D-Glied mit K_D = 0,8 s und T_0 = 0,5 s', 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('h(t)', 'h(k)', '\sigma(t)');
  legend boxoff
  printgcf (mfilename, 0)

% P-T_L-T_1-Glied

Gp = K_P/(1 + T_1*s);
Gpz = c2d (Gp, T_0);
x_T = 0: 0.05: tmax+T_L;

figure ('Name', 'P-T_L-T_1-Glied', 'NumberTitle', 'off', 'Position', [0 0 800 600])
  set (gca, 'FontSize', 18); hold on
  [ys ts] = step (Gp, x_T);
  tsn =[ts; zeros(T_L/0.05, 1)+6];
  ysn =[zeros(T_L/0.05, 1);ys];
  plot (tsn, ysn, 'm'); hold on
  step (Gpz*z^-4, tmax, 'b'); hold on
  set (findobj (gcf, 'type', 'line'), 'LineWidth', 1)
  plot ([0 tmax], [1 1], 'r', 'LineWidth', 1)
  plot ([-0.05*T_1+T_L 1.05*T_1+T_L], [-0.05*K_P 1.05*K_P], 'g', 'LineWidth', 1)
  plot ([-0.05 tmax], [K_P K_P], 'c', 'LineWidth', 1)
  plot ([T_1+T_L T_1+T_L], [-0.05 K_P*1.05], 'g', 'LineWidth', 1)
  plot ([T_L T_L], [-0.05 0.05], 'g', 'LineWidth', 1)
  axis ([tmin tmax ymin ymax])
  title ({'P-T_L-T_1-Glied mit K_P = 0,8 , T_L = 1,8 s ,', 'T_1 = 2 s und T_0 = 0,5 s', ''}, 'fontsize', 20)
  xlabel ('Zeit t in s')
  ylabel ('Ein- und Ausgangssignale')
  legend ('h(t)', 'h(k)', '\sigma(t)', 'Tangente T_L bis T_L+T_1', 'Asymptote K_P', 'location', 'west');
  legend boxoff
  printgcf (mfilename, 0)
