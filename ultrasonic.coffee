module.exports = (env) ->

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'
  
  _ = env.require 'lodash'

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
        unit: 'm'

    constructor: (@config) ->
      @id = config.id
      @name = config.name
      @echo = config.echo
      @trigger = config.trigger
      @timeout = config.timeout
      @delay = config.delay
      @sample = config.sample
      @interval = config.interval
      if config.displayUnit?
        # only change the attributes for this device:
        @attributes = _.cloneDeep(@attributes)
        @attributes.distance.displayUnit = config.displayUnit
      super()

      @requestValue()
      setInterval( ( => @requestValue() ), @config.interval)

    requestValue: ->
      sensor = usonic.sensor(@echo, @trigger, @timeout, @delay, @sample)
      @_distance = (sensor() / 100)
      if @_distance < 0
        env.logger.error("Error reading #{@config.name} with id:#{@config.id}")
      else
        @emit "distance", @_distance

    getDistance: -> Promise.resolve(@_distance)

  plugin = new UltrasonicPlugin

  return plugin
