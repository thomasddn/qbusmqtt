#!/usr/bin/env bash

# Set default env variables
: "${MQTT_PORT:=1883}"

# echo $MQTT_HOST
# echo $MQTT_PORT
# echo $MQTT_USER
# echo $MQTT_PWD

# Start gateway
echo "Starting Qbus MQTT gateway."
echo "Connecting to MQTT broker '$MQTT_HOST:$MQTT_PORT' with user '$MQTT_USER'."
/usr/bin/qbus/qbusMqttGw -serial QBUSMQTTGW -logbuflevel -1 -logtostderr true -storagedir /opt/qbus -mqttbroker "tcp://$MQTT_HOST:$MQTT_PORT" -mqttuser "$MQTT_USER" -mqttpassword "$MQTT_PWD"
