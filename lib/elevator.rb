class Elevator
  attr_accessor :floor_number, :people, :statistics
  attr_reader :capacity

  def initialize(decider)
    @floor_number = 0
    @capacity = 6
    @people = []
    @decider = decider
    @statistics = 0
  end

  def full?
    @people.count >= @capacity
  end

  def move!(floor_panels)
    @floor_number = @decider.calculate_level(self, floor_panels)
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
end
