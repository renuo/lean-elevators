module LeanElevators
  class LoadingQueue
    def initialize(elevators)
      @elevators = elevators
    end

    def elevators_by_space
      @elevators.sort_by { |elevator| elevator.people.count }
    end
  end
end