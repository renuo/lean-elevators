class Elevator
  attr_accessor :floor_number, :persons
  attr_reader :capacity

  def initialize(decider)
    @floor_number = 0
    @capacity = 6
    @persons = []
    @decider = decider
  end

  def full?
    @persons.count >= @capacity
  end

  def move!(floor_panels)
    @floor_number = @decider.calculate_level(self, floor_panels)
  end
end
