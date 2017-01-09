module Deciders
  class FirstComeFirstServe
    class << self
      def calculate_level(elevator, floor_panels)
        first_serve(elevator) || first_come(floor_panels) || 0
      end

      def first_serve(elevator)
        elevator.people.first&.target_floor_number
      end

      def first_come(floor_panels)
        floor_panels.each_index.select do |level|
          floor_panels[level].up? || floor_panels[level].down?
        end.first
      end
    end
  end
end
