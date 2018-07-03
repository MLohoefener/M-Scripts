function ret = mqtt_pub (host, topic, testMessage)
% MQTT-Nachrichten senden
% Bsp.: mqtt_pub ('iot.hs-merseburg.de', 'Uhrzeit', '03.07.2018 11:15:22')
% Voraussetzungen:
% 1. Linux installieren
% 2. Paket mosquitto clients installieren
% 3. Octave oder MATLAB installieren.
% 01.12.2017, Manfred Lohöfener, HoMe

  cmd = ['mosquitto_pub -h ' host ' -t "' topic '" -m "' testMessage '"'];
  ret = unix (cmd);
end
