require './lib/connect_four.rb'

RSpec.describe ConnectFour do
  describe '#player_input' do
    subject(:game_invalid_input) { ConnectFour.new }
    PROMPT_STRING = 'Enter column number to make your move>> '

    context 'when user enters invalid input once, then valid input' do
      before do
        allow(game_invalid_input).to receive(:gets).and_return('7', '6')
        allow(game_invalid_input).to receive(:print).with(PROMPT_STRING)
      end

      it 'prompts for input again, once' do
        expect(game_invalid_input).to receive(:print).with(PROMPT_STRING).twice
        expect(game_invalid_input).to receive(:gets).twice

        game_invalid_input.player_input
      end

      it 'finally returns valid input as integer' do
        expect(game_invalid_input.player_input).to eql(6)
      end
    end

    context 'when user enters invalid input twice, then valid input' do
      before do
        allow(game_invalid_input).to receive(:gets).and_return('7', '%', '6')
        allow(game_invalid_input).to receive(:print).with(PROMPT_STRING)
      end

      it 'prompts for input again, twice' do
        expect(game_invalid_input).to receive(:print).with(PROMPT_STRING).exactly(3).times
        expect(game_invalid_input).to receive(:gets).exactly(3).times

        game_invalid_input.player_input
      end

      it 'finally returns valid input as integer' do
        expect(game_invalid_input.player_input).to eql(6)
      end
    end

    context 'when user enters valid input' do
      subject(:game_valid_input) { ConnectFour.new }

      before do
        allow(game_valid_input).to receive(:gets).and_return('6')
        allow(game_valid_input).to receive(:print).with(PROMPT_STRING)
      end

      it 'prompts for input only once' do
        expect(game_valid_input).to receive(:print).with(PROMPT_STRING).exactly(:once)
        expect(game_invalid_input).to receive(:gets).exactly(:once)

        game_valid_input.player_input
      end

      it 'returns valid input as integer' do
        expect(game_valid_input.player_input).to eql(6)
      end
    end
  end
end