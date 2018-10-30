% Test_MQTT_pub.m - Script for testing MQTT
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
host = 'test.mosquitto.org';
%host = 'broker.hivemq.com';
%host = 'iot.hs-merseburg.de';

%topic = 'Uhrzeit';
topic = 'HoMe18';
%topic = 'Advantech/00D0C9FAD5D3/data';     % WISE-4012 Development Kit
%topic = 'Advantech/#';

for c = 1:20                                % Counter
  testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');
  mqtt_pub (host, topic, testMessage);
  pause (2)                                 % 2 s break
end
