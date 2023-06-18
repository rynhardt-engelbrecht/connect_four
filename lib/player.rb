# frozen_string_literal: true

require_relative 'colors'
require_relative 'display'

# class to handle all player actions
class Player
  attr_reader :number, :color

  include Colors
  include Display

  def initialize
    @number = select_color.to_i
    @color = token_color(@number)
  end

  private

  def select_color(input = '')
    puts 'Choose your color. (Enter a number between 1 and 6)>> '

    until input.match(/^[1-6]$/) || %w[q quit].include?(input)
      input = gets.chomp

      validate_color(input)
    end

    puts "Your color is #{token_color(input.to_i)}"
    input
  end

  def validate_color(number)
    if %w[q quit].include?(number)
      exit
    elsif !number.match(/^[1-6]$/)
      puts error_message('color')
      print '>> '
    end
  end
end
