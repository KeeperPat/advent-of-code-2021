class Solver
    def initialize(target_area)
        @target_area = target_area
    end

    def max_successful_height
        potential_starting_x_velocities = (1..(@target_area.x_range.end)).to_a
        potential_starting_y_velocities = (1..(@target_area.y_range.begin * -1)).to_a

        potential_starting_x_velocities.each.map do |starting_x_velocity|
            potential_starting_y_velocities.map do |starting_y_velocity|
                probe = Probe.new([starting_x_velocity, starting_y_velocity])
                launch = Launch.new(probe, @target_area)
                case launch.outcome
                when :success
                    launch.max_height
                else
                    nil
                end
            end
        end.flatten.compact.max
    end

    def all_successful_starting_velocities
        potential_starting_x_velocities = (1..(@target_area.x_range.end)).to_a
        potential_starting_y_velocities = (@target_area.y_range.begin..(@target_area.y_range.begin * -1)).to_a

        potential_starting_x_velocities.each.map do |starting_x_velocity|
            potential_starting_y_velocities.map do |starting_y_velocity|
                starting_velocity = [starting_x_velocity, starting_y_velocity]
                launch = Launch.new(Probe.new(starting_velocity), @target_area)
                case launch.outcome
                when :success
                    starting_velocity
                else
                    nil
                end
            end
        end.flatten(1).compact
    end
end