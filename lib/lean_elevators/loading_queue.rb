module LeanElevators
  class LoadingQueue
    def initialize(elevators)
      @elevators = elevators
    end

    def elevators
      @elevators.sort_by { |elevator| [elevator.floor_number, elevator.people.count] }
    end
  end
end