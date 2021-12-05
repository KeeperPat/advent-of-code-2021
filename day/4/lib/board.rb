class Board
    def initialize(board)
        @board = board.split("\n").map(&:split).map{|row| row.map{|number| number.to_i}}
        @marked = Array.new(5){Array.new(5)} 
        @played_numbers = []
    end

    def play!(played_number)
        @board.each.with_index do |row, row_index|
            row.each.with_index do |board_number, column_index|
                @marked[row_index][column_index] = true if played_number == board_number
            end
        end
        @played_numbers << played_number
    end

    def winner?
        winning_row = @marked.detect{|row| row.all?(true)}
        winning_column = @marked.transpose.detect{|column| column.all?(true)}

        !!(winning_row || winning_column)
    end

    def score
        if winner?
           unmarked_numbers.sum * @played_numbers.last
        end
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

    private
        def unmarked_numbers
            numbers = []

            @marked.each.with_index do |row, row_index|
                row.each.with_index do |position_marked, column_index|
                    numbers << @board[row_index][column_index] unless position_marked
                end
            end

            return numbers
        end
end