module LeanElevators
  class Floor
    attr_accessor :panel, :people

    def initialize
      @panel = Panel.new
      @people = []
    end

    def people_waiting?
      @people.count.positive?
    end

    def load_elevator(elevator)
      elevator.load(@people.pop) while people_waiting? && !elevator.full?
      @panel.reset unless people_waiting?
    end

    def unload_elevator(elevator)
      elevator.unload
    end
  end
end
