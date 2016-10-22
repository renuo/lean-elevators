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
