# QBUSMQTT

Exposes states and events of the Qbus Home Automation system to an MQTT broker, and allows you to control it through MQTT. The API at https://github.com/Qbus-iot/qbusmqttapi is an ideal match for this.

QBUSMQTT is also available as a Home Assistant app: https://github.com/thomasddn/home-assistant-addons.

[![GitHub release (with filter)][releases-shield]][releases]

![Supports amd64 Architecture][amd64-shield]
![Supports arm Architecture][arm-shield]
![Supports arm64 Architecture][arm64-shield]
![Supports i386 Architecture][i386-shield]

## 🥤 Snack-fueled coding 

You know what goes great with open-source coding? Snacks! If my project helped you out, maybe throw a little something my way so my potato chips and Coca-Cola stash doesn't run out!

[![ko-fi sponsor][kofi-sponsor-shield]][kofi-sponsor]
[![github sponsor][github-sponsor-shield]][github-sponsor]

## 🛠️ Setup

### Prerequisites

- Qbus home automation system (hardware)
- MQTT broker (e.g. https://hub.docker.com/_/eclipse-mosquitto)

> [!IMPORTANT]  
> QBUSMQTT and the controller(s) must be in the same subnet.

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
    volumes:
      - './data:/opt/qbusmqttgw/data'
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

## 🏠 Home Assistant

QBUSMQTT is commonly used as the bridge between a Qbus controller and Home Assistant through MQTT.
In this setup, the gateway publishes Qbus states and events to MQTT topics and listens for MQTT commands, so Home Assistant can both monitor and control your Qbus installation using its MQTT and Qbus integrations.

Data flow is bidirectional end-to-end:

- Qbus events and state changes flow from the controller to the gateway, then to the MQTT broker, and finally to Home Assistant.
- Commands from Home Assistant flow back through MQTT to the gateway, which forwards them to the Qbus Controller.

> [!NOTE]  
> If you are running Home Assistant OS (HAOS), use the [Home Assistant app](https://github.com/thomasddn/home-assistant-addons) instead.

![ha-docker-architecture](https://github.com/thomasddn/qbusmqtt/raw/main/docs/architecture-docker.drawio.svg)

## 🗣️ Remarks
:warning: This is **not** officially supported by Qbus.



[releases-shield]: https://img.shields.io/github/v/release/thomasddn/qbusmqtt?style=flat-square
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg?style=flat-square
[arm-shield]: https://img.shields.io/badge/arm-yes-green.svg?style=flat-square
[arm64-shield]: https://img.shields.io/badge/arm64-yes-green.svg?style=flat-square
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg?style=flat-square
[releases]: https://github.com/thomasddn/qbusmqtt/releases
[kofi-sponsor-shield]: https://img.shields.io/badge/Support_me_on_Ko--fi-%E2%9D%A4-fe8e86?style=for-the-badge&logo=kofi&logoColor=ffffff
[kofi-sponsor]: https://ko-fi.com/N4N7UZ6KN
[github-sponsor-shield]: https://img.shields.io/badge/Support_me_on_GitHub-%E2%9D%A4-fe8e86?style=for-the-badge&logo=github&color=fe8e86
[github-sponsor]: https://github.com/sponsors/thomasddn
