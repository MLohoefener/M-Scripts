% Test_MQTT_sub.m - Script for testing MQTT
% Prerequisites:
% 1. Boot Linux
% 2. Install mosquitto-clients
% 3. Install GNU Octave or MATLAB
% 01.12.2017, Manfred Lohöfener, HoMe
% Default TCP-Port: 1883
% http://www.mqtt-dashboard.com/

clear

%host = '192.168.1.122';
%host = 'localhost';
%host = '10.42.0.1';                        % my_free_wifi
%host = 'test.mosquitto.org';
host = 'broker.hivemq.com';
%host = 'iot.hs-merseburg.de';

%topic = 'Uhrzeit';
topic = 'HoMe18';
%topic = 'Advantech/00D0C9FAD5D3/data';     % WISE-4012 Development Kit
%topic = 'Advantech/#';

puf = {0};                                  % Message-Puffer

for c = 1:20                                % Counter
    [stat, txt] = mqtt_sub (host, topic);   % receive message
    testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');
    puf (c) = {[testMessage ' : ' txt]};    % timestamps of receive and send
end

disp (puf');                                % on command window
fid = fopen ('puf.txt', 'w');
fprintf (fid, '%s\n', '      Received      :       Sent   ');
fprintf (fid, '%s', puf{:});                % and in file
fclose (fid);
