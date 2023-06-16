require_relative 'colors'

class Player
  attr_reader :number, :color

  include Colors

  def initialize
    @number = select_color.to_i
    @color = token_color(@number)
  end

  private

  def select_color(input = '')
    input = gets.chomp until input.match(/^[1-6]$/)
    input
  end
end