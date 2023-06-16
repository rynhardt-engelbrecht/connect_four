require './lib/connect_four.rb'
require './lib/player.rb'

RSpec.describe ConnectFour do
  subject(:game) { ConnectFour.new }

  before do
    allow_any_instance_of(Player).to receive(:gets).and_return('2', '4')
  end

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
        allow(game_filled_column).to receive(:print)
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

  describe '#make_move' do
    before do
      allow(game).to receive(:gets).and_return('4')
      allow(game).to receive(:print)
    end

    it 'swaps the current turn to the next player' do
      next_turn = game.instance_variable_get(:@next_turn)
      expect { game.make_move }.to change { game.instance_variable_get(:@current_turn) }.to(next_turn)
    end

    context 'when user inputs "4" for the column to play' do
      subject(:game_column_four) { ConnectFour.new }

      before do
        allow(game_column_four).to receive(:gets).and_return('4')
        allow(game_column_four).to receive(:print)
      end

      it 'updates the value at [6][4]' do
        expect { game_column_four.make_move }.to change { game_column_four.grid[6][4] }.from(0)
      end
    end

    context 'when lowest available row is "3" and column is "2"' do
      subject(:game_row_three) { ConnectFour.new }

      before do
        game_row_three.grid = [
          [0, 0, 0, 0, 0, 0, 1],
          [0, 0, 0, 0, 0, 0, 2],
          [0, 1, 0, 0, 1, 0, 2],
          [0, 1, 0, 0, 2, 1, 1],
          [0, 2, 1, 0, 1, 2, 1],
          [1, 1, 2, 0, 1, 2, 1],
          [2, 2, 1, 1, 2, 1, 2]
        ]
        allow(game_row_three).to receive(:gets).and_return('2')
        allow(game_row_three).to receive(:print)
      end

      it 'updates value at grid[3][2]' do
        expect { game_row_three.make_move }.to change { game_row_three.grid[3][2] }.from(0)
      end
    end

    context 'when lowest available row is "0" and column is "0"' do
      subject(:game_row_six) { ConnectFour.new }

      before do
        game_row_six.grid = [
          [0, 0, 0, 0, 0, 0, 1],
          [1, 0, 0, 0, 0, 0, 2],
          [1, 1, 0, 0, 1, 0, 2],
          [2, 1, 0, 0, 2, 1, 1],
          [2, 2, 1, 0, 1, 2, 1],
          [1, 1, 2, 0, 1, 2, 1],
          [2, 2, 1, 1, 2, 1, 2]
        ]
        allow(game_row_six).to receive(:gets).and_return('0')
        allow(game_row_six).to receive(:print)
      end

      it 'updates value at grid[0][0]' do
        expect { game_row_six.make_move }.to change { game_row_six.grid[0][0] }.from(0)
      end
    end
  end
end