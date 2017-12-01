module LeanElevators
  class Building
    attr_accessor :elevators, :floors, :panels

    def initialize(building_size, elevators)
      @elevators = elevators
      @floors = (1..building_size).map { Floor.new }
      @panels = @floors.map(&:panel)
    end

    def tick
      move_elevators
      transfer_people
    end

    def move_elevators
      # Parallelize the deciding mechanism of an elevator
      queued_elevators.map do |elevator|
        Thread.new { elevator.move!(@panels) }
      end.each(&:join)
    end

    def transfer_people
      queued_elevators.each do |elevator|
        floor = @floors[elevator.floor_number]
        floor.unload_elevator(elevator)
        floor.load_elevator(elevator)
      end
    end

    def queued_elevators
      LoadingQueue.new(@elevators).elevators_by_space # empty elevators first
    end

    def to_s
      @floors.map.with_index do |floor, level|
        floor_label = level.to_s.rjust(3)

        chamber = @elevators.map do |elevator|
          if level == elevator.floor_number
            "[#{elevator.people.count}]"
          else
            '   '
          end
        end.join(' | ')

        waiting_people = '웃' * floor.people.count

        "#{floor_label}  █ #{chamber} █ #{waiting_people}"
      end.reverse.join("\n")
    end
  end
end
