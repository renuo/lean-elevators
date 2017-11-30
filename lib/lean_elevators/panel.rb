module LeanElevators
  class Panel
    def initialize
      @up = false
      @down = false
    end

    def up!
      @up = true
    end

    def up?
      @up
    end

    def down!
      @down = true
    end

    def down?
      @down
    end

    def reset
      @up = false
      @down = false
    end
  end
end
