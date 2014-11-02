pimatic-ultrasonic
================

Support for the HC-SR04 ultrasonic sensor.

### Example config

Add the plugin to the plugin section:

```json
{ 
  "plugin": "ultrasonic"
}
```

Then add a sensor for your device to the devices section:

```json
{
  "id": "ultrasonic",
  "name": "Ultrasonic HC-SR04",
  "class": "Ultrasonic",
  "echo": 22,
  "trigger": 18,
  "timeout": 750,
  "delay": 60,
  "sample": 5,
  "interval": 60000
}
```

Thank you <a href="https://github.com/clebert">Clemens Akens</a> for <a href="https://github.com/clebert/r-pi-usonic">r-pi-usonic</a> and <a href="https://github.com/sweetpi">sweet pi</a> for inspiration and his work on best automatization software <a href="http://pimatic.org/">Pimatic</a>.