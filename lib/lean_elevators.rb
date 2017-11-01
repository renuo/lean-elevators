require_relative 'lean_elevators/building'
require_relative 'lean_elevators/decider_dto'
require_relative 'lean_elevators/elevator'
require_relative 'lean_elevators/floor'
require_relative 'lean_elevators/panel'
require_relative 'lean_elevators/person'
require_relative 'lean_elevators/populator'

require_relative 'lean_elevators/deciders/net'

module LeanElevators
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :deciders, :net_deciders, :ticks, :decider_timeout, :round_delay

    def initialize
      @deciders = []
      @net_deciders = []
      @ticks = 100
      @decider_timeout = 0.1
      @round_delay = 0.1
    end
  end

  def self.run
    elevators = configuration.deciders.map { |decider| Elevator.new(decider) }
    elevators += configuration.net_deciders.map { |uri| Elevator.new(Deciders::Net.new(uri)) }

    raise 'no elevators have been configured' if elevators.empty?

    building = Building.new(elevators)

    configuration.ticks.times do
      populator = Populator.new(building.floors)
      populator.populate
      building.tick

      yield(building)

      sleep(configuration.round_delay)
    end
  end
end

