class SnailfishNumber
    def initialize(snailfish_number_string)
        raise ArgumentError.new("Invalid characters in snailfish number") if INVALID_CHARS.match?(snailfish_number_string)

        @string = snailfish_number_string.gsub(' ', '')
        @array = eval(@string)
    end

    def to_s
        return @string
    end

    def to_a
        @array
    end

    def +(other_snailfish_number)
        SnailfishNumber.new("[#{self},#{other_snailfish_number}]")
    end

    def explode
        if index_of_pair_to_explode
            left_value, right_value = pair_at(index_of_pair_to_explode)

            left_string = @string[0...index_of_pair_to_explode]
            right_string = @string[index_of_pair_to_explode+pair_at(index_of_pair_to_explode).to_s.gsub(' ', '').length..@string.length]

            new_string = replace_left_regular_number(left_string, left_value) + '0' + replace_right_regular_number(right_string, right_value)

            SnailfishNumber.new(new_string)
        else
            return self
        end
    end

    def split
        first_2_digit_number = @string.scan(/\d{2}/).first
        if first_2_digit_number
            halved = first_2_digit_number.to_i / 2.0
            new_pair = "[#{halved.floor},#{halved.ceil}]"

            return SnailfishNumber.new(@string.sub(first_2_digit_number, new_pair))
        else
            return self
        end
    end

    def reduce
        if explode.to_s != @string
            return explode.reduce
        elsif split.to_s != @string
            return split.reduce
        else
            return self
        end
    end

    def magnitude
        left_value = if @array.first.is_a?(Integer)
            @array.first
        else
            SnailfishNumber.new(@array.first.to_s).magnitude
        end

        right_value = if @array.last.is_a?(Integer)
            @array.last
        else
            SnailfishNumber.new(@array.last.to_s).magnitude
        end

        return (left_value * 3) + (right_value * 2)
    end

    def self.sum(list)
        result = SnailfishNumber.new(list.shift)
        until list.empty? do
            result = result + list.shift
            result = result.reduce
        end

        return result
    end

    private
        INVALID_CHARS = /[^\d\,\[\] ]/

        def pair_at(index)
            eval(@string.slice(index..(index+6)).scan(/\[\d+\,\d+\]/).first)
        end

        def replace_left_regular_number(new_string, value_to_add)
            if last_regular_number(new_string)
                number = last_regular_number(new_string)

                return new_string.sub(/.*\K#{number}/, (number + value_to_add).to_s)
            else
                return new_string
            end
        end

        def last_regular_number(string)
            string.scan(/\d+/).last.to_i
        end

        def replace_right_regular_number(new_string, value_to_add)
            if first_regular_number(new_string)
                number = first_regular_number(new_string)

                return new_string.sub(number.to_s, (number + value_to_add).to_s)
            else
                return new_string
            end
        end

        def first_regular_number(string)
            string.scan(/\d+/).first.to_i
        end

        def index_of_pair_to_explode
            depth = 0
            position = nil
            @string.chars.each_with_index do |char, index|
                if depth == 5
                    return index-1
                end
    
                case char
                when '['
                    depth += 1
                when ']'
                    depth -= 1
                end                
            end

            return nil
        end
end