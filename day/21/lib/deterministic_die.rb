class DeterministicDie
    attr_reader :total_rolls

    def initialize
        @total_rolls = 0
    end

    def roll!
        result = SIDES[@total_rolls % 100]

        @total_rolls += 1

        return result
    end

    private
        SIDES = (1..100).to_a
end
