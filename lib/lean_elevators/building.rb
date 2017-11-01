module LeanElevators
  class Building
    attr_accessor :elevators, :floors, :panels

    def initialize(elevators)
      @elevators = elevators
      @floors = (1..10).map { Floor.new }
      @panels = @floors.map(&:panel)
    end

    def tick
      # TODO: fairness of choosing elevators
      @elevators.each do |elevator|
        elevator.move!(@panels)

        floor = @floors[elevator.floor_number]
        floor.unload_elevator(elevator)
        floor.load_elevator(elevator)
      end
    end

    def to_s
      @floors.map.with_index do |floor, level|
        chamber = @elevators.map do |elevator|
          if level == elevator.floor_number
            "[#{elevator.people.count}]"
          else
            '   '
          end
        end.join(' | ')

        waiting_people = '웃' * floor.people.count

        "  █ #{chamber} █ #{waiting_people}"
      end.join("\n")
    end
  end
end
