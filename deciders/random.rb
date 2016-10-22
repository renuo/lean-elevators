module Deciders
  class Random
    class << self
      def calculate_level(elevator, floor_panels)
        rand(0..floor_panels.count - 1)
      end
    end
  end
end
