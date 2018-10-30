function [stat, txt] = mqtt_sub (host, topic)
% Receive 1 MQTT message
% Example: [stat, txt] = mqtt_sub ('iot.hs-merseburg.de', 'Uhrzeit')
% 01.12.2017, Manfred Lohöfener, HoMe

  cmd = ['mosquitto_sub -h "' host '" -C 1 -t "' topic '"'];
  [stat, txt] = unix (cmd);
end
