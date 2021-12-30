class TrenchMap
    attr_reader :image, :image_enhancement_algorithm

    def initialize(input)
        @image_enhancement_algorithm, @image = input.split("\n\n")
        
        @image_enhancement_algorithm = @image_enhancement_algorithm.strip.chars
        @image = @image.split("\n").map{|row| row.split('')}
    end
end