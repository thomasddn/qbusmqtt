# QBUSMQTT

Exposes states and events of the Qbus Home Automation system to a MQTT broker. This is the docker version for the Qbus MQTT part of https://github.com/QbusKoen/qbusMqtt.

[![GitHub release (with filter)][releases-shield]][releases]
![Supports amd64 Architecture][amd64-shield]
![Supports armv7 Architecture][armv7-shield]

## Setup

### Prerequisites
- Qbus home automation system (hardware)
- MQTT broker (e.g. https://hub.docker.com/_/eclipse-mosquitto)

### Installation

1. Create docker-compose.yaml
1. Adjust [environment variables](#configuration) as needed
1. Start the container:  `docker compose up -d`

Example docker-compose.yaml:

```yaml
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
      TZ: Europe/Brussels
```

### Configuration

| Key | Required | Default value | Description |
| --- | --- | --- | --- |
| MQTT_HOST | Y | \<empty> | The IP or host name of the MQTT broker. |
| MQTT_PORT | N | 1883 | The port of the MQTT broker. |
| MQTT_USER | N | \<empty> | The username to connect to the MQTT broker. |
| MQTT_PWD | N | \<empty> | The password to connect to the MQTT broker. |

## Remarks
:warning: This is **not** officially supported by Qbus.

Binaries from the [QbusKoen/qbusMqtt](https://github.com/QbusKoen/qbusMqtt) repository are included here to support multi arch docker images. Some files had to be renamed for simplicity. Current version: commit [2756323fa714f1c16fa2982d80defa7a4fc315a2](https://github.com/QbusKoen/qbusMqtt/tree/2756323fa714f1c16fa2982d80defa7a4fc315a2/qbusMqtt).



[releases-shield]: https://img.shields.io/github/v/release/thomasddn/qbusmqtt
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[releases]: https://github.com/thomasddn/qbusmqtt/releases
