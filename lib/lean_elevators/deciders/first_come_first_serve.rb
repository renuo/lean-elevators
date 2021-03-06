module LeanElevators
  module Deciders
    class FirstComeFirstServe
      def calculate_level(decider_dto)
        first_serve(decider_dto.elevator) || first_come(decider_dto.floors) || 0
      end

      def first_serve(elevator)
        elevator[:target_floors].first
      end

      def first_come(floors)
        floors.map { |f| f[:panel] }.each_index.select do |level|
          floors[level][:up] || floors[level][:down]
        end.first
      end
    end
  end
end
