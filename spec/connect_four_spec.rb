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

    context 'when user tries to play in a filled column' do
      subject(:game_filled_column) { ConnectFour.new }

      before do
        7.times { |index| game_filled_column.grid[index][2] = 1 }
        allow(game_filled_column).to receive(:gets).and_return('2', '1')
        allow(game_invalid_input).to receive(:print).with(PROMPT_STRING)
      end

      it 'prompts for input again, once' do
        expect(game_filled_column).to receive(:print).with(PROMPT_STRING).exactly(:twice)
        expect(game_filled_column).to receive(:gets).exactly(:twice)

        game_filled_column.player_input
      end

      it 'finally returns valid input as integer' do
        expect(game_filled_column.player_input).to eql(1)
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
        expect(game_valid_input).to receive(:gets).exactly(:once)

        game_valid_input.player_input
      end

      it 'returns valid input as integer' do
        expect(game_valid_input.player_input).to eql(6)
      end
    end
  end

  describe '#find_empty_slot' do
    context 'when a row is available in given column' do
      subject(:game_available_row) { ConnectFour.new }

      it 'returns index of the available row' do
        expect(game_available_row.find_empty_slot(0)).to eql(6)
      end
    end

    context 'when the given column is already filled' do
      subject(:game_filled_column) { ConnectFour.new }

      before do
        7.times { |index| game_filled_column.grid[index][0] = 1}
      end

      it 'returns nil' do
        expect(game_filled_column.find_empty_slot(0)).to eql(nil)
      end
    end
  end
end