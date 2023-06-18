# frozen_string_literal: true

require_relative 'logic'
require_relative 'player'
require_relative 'display'
require_relative 'instructions'

# class representing a Connect Four game
class ConnectFour
  GRID = Array.new(7) { Array.new(7, 0) }

  attr_accessor :grid, :current_turn, :next_turn

  include CFLogic
  include Display
  include Instructions

  def initialize(grid = GRID, current_turn = Player.new, next_turn = Player.new, is_active: true)
    @grid = grid
    @current_turn = current_turn
    @next_turn = next_turn
    @is_active = is_active
  end
end
