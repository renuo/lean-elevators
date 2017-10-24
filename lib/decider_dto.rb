require 'ostruct'

class DeciderDto
  attr_reader :elevator, :floors

  def initialize(elevator, panels)
    @elevator = build_elevator_struct(elevator)
    @floors = build_floor_structs(panels)
  end

  def to_hash
    {
      elevator: @elevator,
      floors: @floors
    }
  end

  private

  def build_elevator_struct(elevator)
    {
      capacity: elevator.capacity,
      current_floor: elevator.floor_number,
      target_floors: elevator.people.map(&:target_floor_number),
      statistics: elevator.statistics
    }
  end

  def build_floor_structs(panels)
    panels.map do |panel|
      {
        panel: {
          up: panel.up?,
          down: panel.down?
        }
      }
    end
  end
end
