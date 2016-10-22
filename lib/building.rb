class Building
  def initialize(elevators)
    @elevators = elevators
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

      "  █ #{chamber} █ #{waiting_people}"
    end
  end
end



