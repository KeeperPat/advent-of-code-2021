class TrenchMap
    attr_reader :image, :image_enhancement_algorithm

    def initialize(input)
        @image_enhancement_algorithm, @image = input.split("\n\n")
        
        @image_enhancement_algorithm = @image_enhancement_algorithm.strip.chars
        @image = @image.split("\n").map{|row| row.split('')}
    end

    def binary_value_at(x, y)
        adjacent_pixels(x, y).gsub('.', '0').gsub('#', '1').to_i(2)
    end 

    private
        ADJACENT_OFFSETS = [
            [-1,-1],
            [0,-1],
            [1,-1],
            [-1,0],
            [0,0],
            [1,0],
            [-1,1],
            [0,1],
            [1,1],
        ]

        def adjacent_pixels(x, y)
            ADJACENT_OFFSETS.map do |x_offset, y_offset|
                [x + x_offset, y + y_offset]
            end.map do |x, y|
                if valid_coordinates?(x, y)
                    @image[y][x]
                else
                    '.'
                end
            end.join
        end

        def valid_coordinates?(x, y)
            (x >= 0 && x < max_x) && (y >= 0 && y < max_y)
        end

        def max_x
            @image.first.length
        end

        def max_y
            @image.length
        end
    end