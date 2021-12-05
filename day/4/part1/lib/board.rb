class Board
    def initialize(board)
        @board = board.split("\n").map(&:split).map{|row| row.map{|number| number.to_i}}
        @marked = Array.new(5){Array.new(5)} 
    end

    def play!(played_number)
        @board.each.with_index do |row, row_index|
            row.each.with_index do |board_number, column_index|
                @marked[row_index][column_index] = true if played_number == board_number
            end
        end
    end

    def winner?
        false
    end

    def score
        nil
    end

    def to_s
        @board.map.with_index { |row, row_index| 
            row.map.with_index{ |number, column_index|
                if @marked[row_index][column_index]
                    " *"
                else
                    number.to_s.rjust(2)
                end
            }.join(" ")
        }.join("\n") + "\n"
    end
end