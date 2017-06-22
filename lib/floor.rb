require_relative 'panel'

class Floor
  attr_accessor :panel, :people

  def initialize
    @panel = Panel.new
    @people = []
  end

  def people_waiting?
    @people.count.positive?
  end

  # TODO: extract to loader/unloader service (PackingService?)
  def load_elevator(elevator)
    elevator.load(@people.pop) while people_waiting? && !elevator.full?
  end

  def unload_elevator(elevator)
    elevator.unload
  end
end
