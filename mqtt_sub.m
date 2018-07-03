function [stat, txt] = mqtt_sub (host, topic)
% Eine MQTT-Nachrichten empfangen
% Bsp.: [stat, txt] = mqtt_sub ('iot.hs-merseburg.de', 'Uhrzeit')
% Voraussetzungen:
% 1. Linux installieren
% 2. Paket mosquitto clients installieren
% 3. Octave oder MATLAB installieren.
% 01.12.2017, Manfred Lohöfener, HoMe

  cmd = ['mosquitto_sub -h ' host ' -C 1 -t "' topic '"'];
  [stat, txt] = unix (cmd);
end
