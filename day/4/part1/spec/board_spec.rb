require 'board'

describe Board do

    before do
        @board_input = <<~BOARD_STATE
            14 21 17 24  4
            10 16 15  9 19
            18  8 23 26 20
            22 11 13  6  5
             2  0 12  3  7
        BOARD_STATE

        @board = Board.new(@board_input)
    end

    describe "play!" do
        it "marks a number as played" do
            @board.play!(7)
            expect(@board.to_s).to eq(
                <<~BOARD_STATE
                    14 21 17 24  4
                    10 16 15  9 19
                    18  8 23 26 20
                    22 11 13  6  5
                     2  0 12  3  *
                BOARD_STATE
            )
        end
    end

    describe "winner?" do
        it "returns true if all numbers in a column are marked" do
            [21, 16, 8, 11, 0].each{|number| @board.play!(number)}
            expect(@board.winner?).to be true
        end

        it "returns true if all numbers in a row are marked" do
            [10, 16, 15, 9, 19].each{|number| @board.play!(number)}
            expect(@board.winner?).to be true
        end

        it "returns false othewise" do
            expect(@board.winner?).to be false
        end
    end

    describe "score" do
        context "when board isn't a winner" do
            it "returns nil" do
                expect(@board.winner?).to be false

                expect(@board.score).to be nil    
            end
        end

        context "when board is a winner" do
            it "returns the sum of the unmarked numbers times the last played number"
        end
    end

    describe "to_s" do
        it "shows all numbers on the board" do
            expect(@board.to_s).to eq(@board_input)
        end

        it "replaces numbers on the board with asterisks when they're played"
    end
end