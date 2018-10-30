% MQTT_Test.m - publish messages with MATLAB MQTT-Toolbox
% https://de.mathworks.com/matlabcentral/fileexchange/64303-mqtt-in-matlab
% http://www.mqtt-dashboard.com/
% Manfred Lohöfener, HoMe, 25.05.2018
% Default TCP-Port: 1883

clear

%host = 'tcp://192.168.1.122';
%host = 'tcp://localhost';
%host = 'tcp://10.42.0.1';              % my_free_wifi
%host = 'tcp://test.mosquitto.org';
host = 'tcp://broker.hivemq.com';
%host = 'tcp://iot.hs-merseburg.de';

%topic = 'Uhrzeit';
topic = 'HoMe18';
%topic = 'Advantech/00D0C9FAD5D3/data'; % WISE-4012 Development Kit
%topic = 'Advantech/#';

myMQTT = mqtt (host);                   % new MQTT link

for c = 1:20                            % Counter
    testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');  % timestamp
    publish (myMQTT, topic, testMessage)    % function of MATLAB MQTT-Toolbox
    pause (2)                           % 2 s break
end

% mySub = subscribe (myMQTT,topic);     % quite unclear
