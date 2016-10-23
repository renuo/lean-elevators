require 'panel'

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
      elevator.load(@persons.pop)
    end
  end

  def unload_elevator(elevator)
    elevator.unload
  end
end
