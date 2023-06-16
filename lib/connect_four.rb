require_relative 'logic'
require_relative 'player'

class ConnectFour
  attr_accessor :grid, :current_turn, :next_turn

  include CFLogic

  def initialize
    @grid = Array.new(7) { Array.new(7, 0) }
    @players = { player_one: Player.new, player_two: Player.new }
    @current_turn = @players[:player_one]
    @next_turn = @players[:player_two]
    @is_active = true
  end
end