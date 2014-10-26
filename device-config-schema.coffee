module.exports = {
  title: "pimatic-ultrasonic device config schemas"
  Ultrasonic: {
    title: "Ultrasonic config options"
    type: "object"
    extensions: ["xLink"]
    properties:
      echo:
        description: "Echo pin"
        type: "number"
      trigger:
        description: "Trigger pin"
        type: "number"
      timeout:
        interval: "Measurement timeout in µs"
        type: "number"
        default: 750
      delay:
        interval: "Measurement delay in ms"
        type: "number"
        default: 60
      sample:
        interval: "Measurements per sample"
        type: "number"
        default: 5
      interval:
        interval: "Interval in ms so read the sensor"
        type: "integer"
        default: 60000
  }
}
