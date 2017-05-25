class Populator
  def initialize(floors)
    @floors = floors
  end

  def populate
    3.times do
      spawn_person(*@floors.sample(2))
    end
  end

  private

  def spawn_person(origin_floor, target_floor)
    origin_floor.people << Person.new(target_floor)
    origin_floor.press_up! if @floors.index(target_floor) > @floors.index(origin_floor)
    origin_floor.press_down! if @floors.index(target_floor) < @floors.index(origin_floor)
  end
end