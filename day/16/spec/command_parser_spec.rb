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
            end
        end
    end
end