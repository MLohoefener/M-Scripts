% MQTT_Test.m mit MATLAB und MQTT-Toolbox
% https://de.mathworks.com/matlabcentral/fileexchange/64303-mqtt-in-matlab
% http://www.mqtt-dashboard.com/
% Versenden von Nachrichten - publish
% Manfred Lohöfener, HoMe, 25.05.2018
% TCP-Port: 1883

clear
% host = 'tcp://test.mosquitto.org';	% oder alternativ
% host = 'tcp://broker.hivemq.com';
host = 'tcp://iot.hs-merseburg.de';
topic = 'Uhrzeit';
myMQTT = mqtt (host);                   % neue MQTT-Verbindung

for c = 1:20                            % Counter
    testMessage = datestr (now, 'dd.mm.yyyy HH:MM:SS');  % Uhrzeit
    publish (myMQTT, topic, testMessage)    
    pause (2)                           % 2 s Pause
end

% mySub = subscribe (myMQTT,topic);     % noch unklar
