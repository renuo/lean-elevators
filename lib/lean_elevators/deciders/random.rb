module LeanElevators
  module Deciders
    class Random
      def calculate_level(decider_dto)
        rand(0..decider_dto.floors.count - 1)
      end
    end
  end
end
