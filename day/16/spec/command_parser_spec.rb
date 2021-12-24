require 'command_parser'

describe CommandParser do
    before do
    end

    describe 'parse' do
        it "should parse a transmission with a single literal packet" do
            expect(CommandParser.parse('D2FE28')).to eq({
                version: 6,
                type_id: 4,
                value: 2021
            })
        end

        describe 'operator packets' do
            it 'should parse a single packet with length type 0' do
                expect(CommandParser.parse('38006F45291200')).to eq({
                    version: 1,
                    type_id: 6,
                    length_type_id: 0,
                    subpackets_length: 27,
                    subpackets: [
                        {
                            version: 6,
                            type_id: 4,
                            value: 10            
                        }, {
                            version: 2,
                            type_id: 4,
                            value: 20
                        }
                    ]
                })    
            end

            it 'should parse a single packet with length type 1' do
                expect(CommandParser.parse('EE00D40C823060')).to eq({
                    version: 7,
                    type_id: 3,
                    length_type_id: 1,
                    number_of_subpackets: 3,
                    subpackets: [
                        {
                            version: 2,
                            type_id: 4,
                            value: 1            
                        }, {
                            version: 4,
                            type_id: 4,
                            value: 2
                        }, {
                            version: 1,
                            type_id: 4,
                            value: 3
                        }
                    ]
                })
            end
        end
    end
end