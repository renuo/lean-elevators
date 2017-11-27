module LeanElevators
  class Populator
    def initialize(floors, options = {})
      @floors = floors
      @spawn_rate = (options[:initial_spawn_rate] || @floors.count / 2).to_i
      @spawn_limit = (options[:spawn_limit] || @floors.count**2).to_i
    end

    def populate
      @spawn_rate.times do
        spawn_person(*@floors.sample(2))
      end

      adjust_spawn_rate
    end

    private

    def spawn_person(origin_floor, target_floor)
      origin_floor.people << Person.new(@floors.index(target_floor))
      origin_floor.panel.up! if @floors.index(target_floor) > @floors.index(origin_floor)
      origin_floor.panel.down! if @floors.index(target_floor) < @floors.index(origin_floor)
    end

    def adjust_spawn_rate
      if waiting_people_count < @spawn_limit
        @spawn_rate += 1
      else
        @spawn_rate /= 2
      end
    end

    def waiting_people_count
      @floors.map(&:people).flatten.count
    end
  end
end
