module.exports = (env) ->

  Promise = env.require 'bluebird'
  assert = env.require 'cassert'
  _ = env.require 'lodash'
  usonic = require 'mmm-usonic'


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

    usonic.init (error) ->
      if error
        env.logger.error("Error init HC-SR04 ultrasonic sensor")
        env.logger.error(error)
      else
        env.logger.info("Init HC-SR04 ultrasonic sensor")
      return

    constructor: (@config) ->
      @id = @config.id
      @name = @config.name
      @echo = @config.echo
      @trigger = @config.trigger
      @timeout = @config.timeout
      # @delay = @config.delay
      # @sample = @config.sample
      # @interval = @config.interval
      if @config.displayUnit?
        # only change the attributes for this device:
        @attributes = _.cloneDeep(@attributes)
        @attributes.distance.displayUnit = @config.displayUnit
      @sensor = usonic.createSensor(@echo, @trigger, @timeout)
      super()

      @requestValue()
      setInterval( ( => @requestValue() ), @config.interval)

    requestValue: ->
      @_distance = (@sensor() / 100)
      if @_distance < 0
        env.logger.error("Error reading #{@config.name} with id:#{@config.id}")
      else
        @emit "distance", @_distance

    getDistance: -> Promise.resolve(@_distance)

    destroy: () ->
      super()

  plugin = new UltrasonicPlugin

  return plugin
