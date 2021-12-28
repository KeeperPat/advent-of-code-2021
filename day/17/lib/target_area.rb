class TargetArea
    def initialize(x_range, y_range)
        @x_range = x_range
        @y_range = y_range
    end

    def include?(position)
        x, y = position
        @x_range.include?(x) && @y_range.include?(y)
    end
end