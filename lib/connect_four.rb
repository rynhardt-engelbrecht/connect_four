require_relative 'logic'

class ConnectFour
  attr_accessor :grid, :current_turn, :next_turn

  include CFLogic

  def initialize
    @grid = Array.new(7) { Array.new(7, 0) }
  end
end