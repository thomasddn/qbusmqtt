#!/usr/bin/env bash

# echo $MQTT_HOST
# echo $MQTT_PORT
# echo $MQTT_USER
# echo $MQTT_PWD

echo "MQTT: $MQTT_HOST:$MQTT_PORT with user '$MQTT_USER'."
echo "Starting Qbus MQTT gateway."
/usr/bin/qbus/qbusMqttGw -serial QBUSMQTTGW -logbuflevel -1 -logtostderr true -storagedir /opt/qbus -mqttbroker "tcp://$MQTT_HOST:$MQTT_PORT" -mqttuser "$MQTT_USER" -mqttpassword "$MQTT_PWD"
