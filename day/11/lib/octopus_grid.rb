require 'set'

class OctopusGrid
    attr_reader :current_step, :total_flashes

    def initialize(input)
        @octopus_grid = input.split("\n").map{|row| row.split('').map{|number| number.to_i}}
        @max_x = @octopus_grid.first.size
        @max_y = @octopus_grid.size

        @current_step = 0
        @total_flashes = 0
    end

    def to_s
        @octopus_grid.map{|row| row.map(&:to_s).join('')}.join("\n") + "\n"
    end

    def step!
        @flashed = Set.new

        # Increment every Octopus's Energy by 1
        @octopus_grid = @octopus_grid.map{|row| row.map{|value| value + 1}}

        @coordinates_to_flash = coordinates_ready_to_flash

        until(@coordinates_to_flash.empty?) do
            flash!(@coordinates_to_flash.shift)
        end

        @current_step += 1
        @total_flashes += @flashed.size
    end

    def all_flashed?
        @octopus_grid.all?{|row| row.all?{|value| value == 0}}
    end

    private
        ADJACENT_OFFSETS = [
            [0,1],
            [1,1],
            [1,0],
            [1,-1],
            [0,-1],
            [-1,-1],
            [-1,0],
            [-1,1],
        ]

        def flash!(coordinates)
            x, y = coordinates
            @octopus_grid[y][x] = 0
            @flashed << coordinates

            # increment adjacent, unflashed octopus by 1
            adjacent_coordinates(x, y).each do |x, y| 
                @octopus_grid[y][x] += 1 unless @flashed.include?([x, y])
            end

            # add any octopus with energy of 9 to the queue to be flashed
            @coordinates_to_flash = coordinates_ready_to_flash
        end

        def adjacent_coordinates(x, y)
            ADJACENT_OFFSETS.map do |x_offset, y_offset|
                [x + x_offset, y + y_offset]
            end.select do |x, y|
                valid_coordinates?(x, y)
            end
        end

        def valid_coordinates?(x, y)
            (x >= 0 && x < @max_x) && (y >= 0 && y < @max_y)
        end

        def coordinates_ready_to_flash
            @octopus_grid.map.with_index do |row, y|
                row.map.with_index do |value, x|
                   if value > 9
                       [x,y]
                   else
                       nil
                   end
               end
            end.flatten(1).compact
        end
    end