% Test_MQTT_sub.m Script for testing MQTT
% Voraussetzungen:
% 1. Linux installieren
% 2. Paket mosquitto-clients installieren
% 3. GNU Octave oder MATLAB installieren.
% 01.12.2017, Manfred Lohöfener, HoMe
% TCP-Port: 1883

clear
%host = 'test.mosquitto.org';
%host = 'broker.hivemq.com';
host = 'iot.hs-merseburg.de';
topic = 'Uhrzeit';
puf = {0};                                  % Message-Puffer

for c = 1:20                                % Counter
    [stat, txt] = mqtt_sub (host, topic);   % Uhrzeit empfangen
    testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');
    puf (c) = {[testMessage ' : ' txt]};    % Empfangs- und Sendezeit
end

disp (puf');                                % auf Konsole
fid = fopen ('puf.txt', 'w');
fprintf (fid, '%s\n', '    Empfangszeit    :     Sendezeit');
fprintf (fid, '%s', puf{:});                % und in Datei
fclose (fid);
