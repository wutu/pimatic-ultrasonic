pimatic-ultrasonic
================

<a href="https://pimatic.org">Pimatic</a> support for the HC-SR04 ultrasonic sensor.

<a href="https://github.com/mochman/mmm-usonic#example">Example wiring</a>

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
  "interval": 60000
}
```
You can also select the unit:

example: "displayUnit": "cm"

### Credits

<a href="https://github.com/mochman">Luke</a> for <a href="https://github.com/mochman/mmm-usonic">mmm-usonic</a>

### License

<a href="https://github.com/wutu/pimatic-ultrasonic/blob/development/LICENSE"> AGPL-3.0 </a>
