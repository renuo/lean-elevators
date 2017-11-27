require_relative 'lean_elevators/building'
require_relative 'lean_elevators/decider_dto'
require_relative 'lean_elevators/elevator'
require_relative 'lean_elevators/floor'
require_relative 'lean_elevators/loading_queue'
require_relative 'lean_elevators/panel'
require_relative 'lean_elevators/person'
require_relative 'lean_elevators/populator'

require_relative 'lean_elevators/deciders/net'

module LeanElevators
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :building_size, :deciders, :net_deciders, :tick_limit, :decider_timeout, :round_delay

    def initialize
      @building_size = 10
      @deciders = []
      @net_deciders = []
      @tick_limit = 100
      @decider_timeout = 0.1
      @round_delay = 0.1
    end
  end

  def self.run
    # TODO: I'm not happy yet with this differentiation. What would be a good solution which keeps configuration easy?
    elevators = configuration.deciders.map { |decider| Elevator.new(decider) }
    elevators += configuration.net_deciders.map { |uri| Elevator.new(Deciders::Net.new(uri)) }

    raise 'no elevators have been configured' if elevators.empty?

    building = Building.new(configuration.building_size, elevators)
    populator = Populator.new(building.floors)

    configuration.tick_limit.times do |tick|
      populator.populate
      building.tick

      yield(building, tick)

      sleep(configuration.round_delay)
    end
  end
end
