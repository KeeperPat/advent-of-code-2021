class TrenchMap
    attr_reader :image, :image_enhancement_algorithm

    def initialize(input)
        @image_enhancement_algorithm, @image = input.split("\n\n")
        
        @image_enhancement_algorithm = @image_enhancement_algorithm.strip.chars
        @image = @image.split("\n").map{|row| row.split('')}

        @infinite_char = '.'
    end

    def enhance!
        expand!

        @image = max_y.times.map do |y|
            max_x.times.map do |x|
                output_pixel_at(x, y)
            end
        end

        update_infinite_char!

        self
    end

    def light_pixels
        light_pixels = []

        @image.each_with_index do |row, y|
            row.each_with_index do |value, x|
                light_pixels << [x, y] if value == '#'
            end
        end

        return light_pixels
    end

    def output_pixel_at(x, y)
        @image_enhancement_algorithm[binary_value_at(x, y)]
    end

    def binary_value_at(x, y)
        adjacent_pixels(x, y).gsub('.', '0').gsub('#', '1').to_i(2)
    end 

    def to_s
        @image.map{|row | row.join('') + "\n"}
    end

    private
        ADJACENT_OFFSETS = [
            [-1,-1], [0,-1], [1,-1],
            [-1,0], [0,0], [1,0],
            [-1,1], [0,1], [1,1],
        ]

        def adjacent_pixels(x, y)
            ADJACENT_OFFSETS.map do |x_offset, y_offset|
                [x + x_offset, y + y_offset]
            end.map do |x, y|
                if valid_coordinates?(x, y)
                    @image[y][x]
                else
                    @infinite_char
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

        def expand!
            @image = @image.map do |row|
                [@infinite_char] + row + [@infinite_char]
            end
            blank_row = (@infinite_char * max_x).split('')
            @image = [blank_row].concat(image, [blank_row])
        end

        def update_infinite_char!
            if @infinite_char == '.'
                @infinite_char = image_enhancement_algorithm.first
            else
                @infinite_char = image_enhancement_algorithm.last
            end
        end
    end