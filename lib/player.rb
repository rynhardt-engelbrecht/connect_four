require_relative 'colors'

class Player
  include Colors

  def initialize
    @color = token_color(select_color)
  end

  private

  def select_color(input = '')
    input = gets.chomp until input.match(/^[1-6]$/)
    input
  end
end