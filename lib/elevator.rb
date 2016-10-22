class Elevator
  attr_accessor :floor_number, :persons, :statistics
  attr_reader :capacity

  def initialize(decider)
    @floor_number = 0
    @capacity = 6
    @persons = []
    @decider = decider
    @statistics = 0
  end

  def full?
    @persons.count >= @capacity
  end

  def move!(floor_panels)
    @floor_number = @decider.calculate_level(self, floor_panels)
  end

  def load(person)
    @persons << person
  end

  def unload
    pre_count = @persons.count

    @persons.reject! do |person|
      person.target_floor_number == floor_number
    end

    @statistics += pre_count - persons.count
  end
end
