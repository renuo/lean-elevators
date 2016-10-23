require 'panel'

class Floor
  attr_accessor :panel, :people

  def initialize
    @panel = Panel.new
    @people = []
  end

  def people_waiting?
    @people.count > 0
  end

  # TODO: extract to loader/unloader service (PackingService?)
  def load_elevator(elevator)
    while people_waiting? && !elevator.full? do
      elevator.load(@people.pop)
    end
  end

  def unload_elevator(elevator)
    elevator.unload
  end
end
