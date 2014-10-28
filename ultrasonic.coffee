module.exports = (env) ->

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  usonic = require 'r-pi-usonic'
  Promise.promisifyAll(usonic)


  class UltrasonicPlugin extends env.plugins.Plugin
    init: (app, @framework, @config) =>
      deviceConfigDef = require("./device-config-schema")

      @framework.deviceManager.registerDeviceClass("Ultrasonic", {
        configDef: deviceConfigDef.Ultrasonic,
        createCallback: (config) ->
          device = new Ultrasonic(config)
          return device
      })


  class Ultrasonic extends env.devices.Device
    distance: null
    attributes:
      distance:
        description: "The messured distance"
        type: "number"
        unit: 'cm'

    constructor: (@config) ->
      @id = config.id
      @name = config.name
      @echo = config.echo
      @trigger = config.trigger
      @timeout = config.timeout
      @delay = config.delay
      @sample = config.sample
      @interval = config.interval
      super()

      @requestValue()
      setInterval( ( => @requestValue() ), @config.interval)

    requestValue: ->
      sensor = usonic.sensor(@echo, @trigger, @timeout, @delay, @sample)
      distance = parseInt(sensor().toFixed(2), 10)
      if distance < 0
          env.logger.error("Error reading #{@config.name} with id:#{@config.id}")
      else
          @emit "distance", distance

    getDistance: -> Promise.resolve(@distance)

  plugin = new UltrasonicPlugin

  return plugin
