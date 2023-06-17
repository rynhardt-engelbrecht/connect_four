# frozen_string_literal: true

require_relative 'colors'
require 'io/console'

# module to handle output
module Display
  include Colors

  def error_message(message)
    {
      'input' => colorize('Invalid input, please only enter 1 number between 1 and 7.', 'red'),
      'filled' => colorize('Cannot play here, column is already filled.', 'red'),
      'color' => colorize('Please only enter a number between 1 and 6 to choose your color.', 'red')
    }[message]
  end

  def game_message(message)
    {
      'win' => colorize("Player #{@current_turn.color}\e[92m wins the game!", 'green'),
      'draw' => colorize('The game ended in a draw', 'yellow'),
      'play again' => 'Would you like to play again? (y/n)>> ',
    }[message]
  end

  def pick_color(player)
    {
      'one' => 'Player one, choose a color. (Enter a number between 1 and 6)>> ',
      'two' => 'Player two, choose a color. (Enter a number between 1 and 6)>> '
    }[player]
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
      'move' => "Player #{@current_turn.color}, Enter column number to make your move>> "
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