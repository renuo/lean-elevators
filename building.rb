class Panel
  def initialize
    @up = false
    @down = false
  end

  def up!; @up = true; end
  def up?; @up; end
  def down!; @down = true; end
  def down?; @down; end
end

class Floor
  attr_accessor :panel, :persons

  def initialize
    @panel = Panel.new
    @persons = []
  end

  def people_waiting?
    @persons.count > 0
  end

  # TODO: extract to loader/unloader service (PackingService?)
  def load_elevator(elevator)
    while people_waiting? && !elevator.full? do
      elevator.persons << @persons.pop
    end
  end

  def unload_elevator(elevator)
    elevator.persons = []
  end

  def populate
    @persons << Person.new # TODO: have a populating strategy
  end
end

class Elevator
  attr_accessor :floor_number, :persons
  attr_reader :capacity

  def initialize
    @floor_number = 0
    @capacity = 6
    @persons = []
  end

  def full?
    @persons.count >= @capacity
  end

  def move!(floor_panels)
    @floor_number = ElevatorLogic.calculate_level(self, floor_panels)
  end
end

class ElevatorLogic
  class << self
    def calculate_level(elevator, floor_panels)
      rand(0..floor_panels.count - 1)
    end
  end
end

class Person
  attr_reader :target_floor_number

  def initialize
    @target_floor_number = 5
  end
end

class Building
  def initialize
    @elevators = [Elevator.new, Elevator.new]
    @floors = [Floor.new, Floor.new, Floor.new, Floor.new, Floor.new, Floor.new]
  end

  def tick
    # TODO: fairness of choosing elevators
    @elevators.each do |elevator|
      elevator.move!(@floors.map(&:panel))

      floor = @floors[elevator.floor_number]
      floor.unload_elevator(elevator)
      floor.load_elevator(elevator)
    end
  end

  def populate_floors
    @floors.each { |floor| floor.populate }
  end

  def to_s
    @floors.map.with_index do |floor, level|
      chamber = @elevators.map do |elevator|
        if level == elevator.floor_number
          "[#{elevator.persons.count}]"
        else
          '   '
        end
      end.join(' | ')

      waiting_people = '웃' * floor.persons.count

      "█ #{chamber} █ #{waiting_people}"
    end
  end
end

building = Building.new

10_000.times do
  building.populate_floors
  building.tick
  puts building.to_s
  puts "\n---\n\n"
end


