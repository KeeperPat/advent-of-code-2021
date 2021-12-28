class Probe
    attr_reader :step

    def initialize(velocity)
        @x_velocity, @y_velocity = velocity
        @x_position, @y_position = 0, 0
        @step = 0
    end

    def step!
        @x_position += @x_velocity
        @y_position += @y_velocity

        if @x_velocity < 0
            @x_velocity += 1
        elsif @x_velocity > 0
            @x_velocity -= 1
        end
        @y_velocity -= 1

        @step += 1
    end

    def velocity
        [@x_velocity, @y_velocity]
    end

    def position
        [@x_position, @y_position]
    end

    def missed?(target_area)
        @x_position > target_area.x_range.end || @y_position < target_area.y_range.begin
    end
end