# QBUSMQTT

Docker version for the Qbus MQTT part of https://github.com/QbusKoen/qbusMqtt. Binaries copied from that repository so it could be versioned for release purposes.

Current version: commit [2756323fa714f1c16fa2982d80defa7a4fc315a2](https://github.com/QbusKoen/qbusMqtt/tree/2756323fa714f1c16fa2982d80defa7a4fc315a2/qbusMqtt).

## Setup

### Prerequisites
- Qbus home automation system (hardware)
- MQTT broker (e.g. https://hub.docker.com/_/eclipse-mosquitto)

### Installation

1. Create docker-compose.yaml
1. Adjust [environment variables](#configuration) as needed
1. Start the container:  `docker compose up -d`

Example docker-compose.yaml:
```
version: '3.4'

services:
  qbusmqtt:
    image: thomasddn/qbusmqtt:latest
    container_name: qbusmqtt
    restart: unless-stopped
    network_mode: host          # Must be host so it can discover the controller
    environment:
      MQTT_HOST: 192.168.0.123
      MQTT_PORT: 1883
      MQTT_USER: user
      MQTT_PWD: secret
      TZ: Europe/Brussels       # Optional
```

### Configuration

| Key | Required | Default value | Description |
| --- | --- | --- | --- |
| MQTT_HOST | Y | \<empty> | The IP or host name of the MQTT broker. |
| MQTT_PORT | N | 1883 | The port of the MQTT broker. |
| MQTT_USER | N | \<empty> | The username to connect to the MQTT broker. |
| MQTT_PWD | N | \<empty> | The password to connect to the MQTT broker. |
