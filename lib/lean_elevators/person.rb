module LeanElevators
  class Person
    attr_reader :target_floor_number

    def initialize(target_floor_number)
      @target_floor_number = target_floor_number
    end
  end
end
