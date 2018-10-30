function ret = mqtt_pub (host, topic, testMessage)
% Send a MQTT message
% Example: mqtt_pub ('iot.hs-merseburg.de', 'Uhrzeit', '03.07.2018 11:15:22')
% 01.12.2017, Manfred Lohöfener, HoMe

  cmd = ['mosquitto_pub -h "' host '" -t "' topic '" -m "' testMessage '"'];
  ret = unix (cmd);
end
