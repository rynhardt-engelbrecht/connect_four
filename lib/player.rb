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
    until input.match(/^[1-6]$/) || %w[q quit].include?(input)
      input = gets.chomp

      if %w[q quit].include?(input)
        exit
      elsif !input.match(/^[1-6]$/)
        puts error_message('color')
        print '>> '
      end
    end

    input
  end
end
