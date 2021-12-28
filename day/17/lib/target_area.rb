class TargetArea
    def initialize(x_range, y_range)
        @x_range = x_range
        @y_range = y_range
    end

    def include?(position)
        x, y = position
        @x_range.include?(x) && @y_range.include?(y)
    end

    def missed?(probe)
        missed_left?(probe) || missed_right?(probe)
    end

    def missed_left?(probe)
        x,y = probe.position

        x <= @x_range.end && y < @y_range.begin
    end

    def missed_right?(probe)
        x,y = probe.position

        x > @x_range.end
    end
end