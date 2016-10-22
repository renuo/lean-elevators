module Deciders
  class FirstComeFirstServe
    class << self
      def calculate_level(elevator, floor_panels)
        first_unload(elevator) || first_load(floor_panels) || 0
      end

      def first_unload(elevator)
        elevator.persons.first.target_floor_number if elevator.persons.first
      end

      def first_load(floor_panels)
        floor_panels.each_index.select { |level| floor_panels[level].up? || floor_panels[level].down? }.first
      end
    end
  end
end
