# frozen_string_literal: true

# module to handle output
module Display
  def error_message(message)
    {
      'input' => colorize('Invalid input, please only enter 1 number between 0 and 6.', 'red'),
      'filled' => colorize('Cannot play here, column is already filled.', 'red'),
      'color' => colorize('Please only enter a number between 1 and 6 to choose your color.', 'red')
    }[message]
  end
  
  def game_message(message); end
  def pretty_print; end
  def turn_message(message); end
end