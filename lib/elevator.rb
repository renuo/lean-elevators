class Elevator
  attr_accessor :floor_number, :people
  attr_reader :capacity, :statistics

  def initialize(decider)
    @capacity = 6
    @decider = decider
    @floor_number = 0
    @people = []
    @statistics = 0
  end

  def full?
    @people.count >= @capacity
  end

  def move!(floor_panels)
    @floor_number = @decider.calculate_level(dto, floor_panels)
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

  def dto
    OpenStruct.new({
        capacity: @capacity,
        current_location: @floor_number,
        target_locations: @people.map(&:target_floor_number),
        statistics: @statistics
    })
  end
end
