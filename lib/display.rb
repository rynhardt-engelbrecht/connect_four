# frozen_string_literal: true

require_relative 'colors'
require 'io/console'

# module to handle output
module Display
  include Colors

  def error_message(message)
    {
      'input' => colorize('Error: Invalid input, please only enter 1 number between 1 and 7.', 'red'),
      'filled' => colorize('Error: Cannot play here, column is already filled.', 'red'),
      'color' => colorize('Error: Please only enter a number between 1 and 6 to choose your color.', 'red'),
      'yes no' => colorize('Error: Please only type and enter "y", "yes", "n", or "no".', 'red')
    }[message]
  end

  def game_message(message)
    {
      'win' => colorize("Player #{@current_turn.color}\e[92m wins the game!", 'green'),
      'draw' => colorize('The game ended in a draw', 'yellow'),
      'play again' => 'Would you like to play again? (y/n)>> ',
      'start' => 'Start the game? (y/n)>> ',
      'thanks' => "Thank you for playing my version of #{colorize('Connect Four', 'blue')}! You can find more projects on my Github at https://github.com/rynhardt-engelbrecht"
    }[message]
  end

  def pretty_print
    $stdout.clear_screen

    puts '1   2   3   4   5   6   7'
    puts '_________________________'

    @grid.each do |row|
      row_output = row.map { |value| token_color(value) }
      puts row_output.join(' | ')
    end

    puts '-------------------------'
  end

  def turn_message(message)
    {
      'move' => "Player #{@current_turn.color} enter column number to make your move>> "
    }[message]
  end

  def count_down
    num = 5
    while num >= 0
      puts "Game starting in #{num}..."
      num -= 1

      sleep(1)
    end
  end
end