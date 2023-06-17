# frozen_string_literal: true

require_relative 'colors'

# module to handle output
module Display
  include Colors

  def error_message(message)
    {
      'input' => colorize('Invalid input, please only enter 1 number between 0 and 6.', 'red'),
      'filled' => colorize('Cannot play here, column is already filled.', 'red'),
      'color' => colorize('Please only enter a number between 1 and 6 to choose your color.', 'red')
    }[message]
  end

  def game_message(message)
    {
      'win' => colorize("Player #{@current_turn.color} wins the game!", 'green'),
      'draw' => colorize('The game ended in a draw', 'yellow'),
      'play again' => 'Would you like to play again? (y/n)>>',
      'thanks' => "Thank you so much for playing my version of #{colorize('Connect Four', 'blue')}! Check out my Github at https://github.com/rynhardt-engelbrecht."
    }[message]
  end

  def pretty_print
    puts '0   1   2   3   4   5   6'
    puts '_________________________'

    @grid.each do |row|
      row_output = row.map { |value| token_color(value) }
      puts row_output.join('| ')
    end

    puts '-------------------------'
  end

  def turn_message(message); end
end