# QBUSMQTT

Exposes states and events of the Qbus Home Automation system to a MQTT broker.

It is also available as a Home Assistant add-on: https://github.com/thomasddn/home-assistant-addons.

[![GitHub release (with filter)][releases-shield]][releases]

![Supports amd64 Architecture][amd64-shield]
![Supports arm Architecture][arm-shield]
![Supports arm64 Architecture][arm64-shield]
![Supports i386 Architecture][i386-shield]


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



[releases-shield]: https://img.shields.io/github/v/release/thomasddn/qbusmqtt?style=flat-square
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg?style=flat-square
[arm-shield]: https://img.shields.io/badge/arm-yes-green.svg?style=flat-square
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg?style=flat-square
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg?style=flat-square
[releases]: https://github.com/thomasddn/qbusmqtt/releases
