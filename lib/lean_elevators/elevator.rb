module LeanElevators
  class Elevator
    attr_accessor :floor_number, :people
    attr_reader :capacity, :statistics, :errors

    def initialize(decider)
      @capacity = 6
      @decider = decider
      @floor_number = 0
      @people = []
      @statistics = 0
      @errors = []
    end

    def full?
      @people.count >= @capacity
    end

    def move!(floor_panels)
      # TODO: this probably doesn't belong into the elevator
      floor_candidate = Timeout.timeout(::LeanElevators.configuration.decider_timeout) do
        @decider.calculate_level(decider_dto(floor_panels))
      end

      raise InvalidFloor, "Floor #{floor_candidate} is invalid" if floor_panels[floor_candidate].nil?

      @floor_number = floor_candidate
    rescue Deciders::Net::LevelCalculationException, Timeout::Error, InvalidFloor => e
      @errors << e
    end

    def load(person)
      @people << person
    end

    def unload
      pre_count = @people.count

      @people.reject! do |person|
        person.target_floor_number == floor_number
      end

      @statistics += pre_count - people.count
    end

    private

    # :nocov:
    def decider_dto(floor_panels)
      DeciderDto.new(self, floor_panels)
    end
    # :nocov:

    class InvalidFloor < StandardError; end
  end
end
