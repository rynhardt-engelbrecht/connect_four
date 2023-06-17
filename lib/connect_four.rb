# frozen_string_literal: true

require_relative 'logic'
require_relative 'player'
require_relative 'display'
require_relative 'instructions'

# class representing a Connect Four game
class ConnectFour
  attr_accessor :grid, :current_turn, :next_turn

  include CFLogic
  include Display
  include Instructions

  def initialize
    @grid = Array.new(7) { Array.new(7, 0) }
    create_players
    self.count_down
    @current_turn = @players[:player_one]
    @next_turn = @players[:player_two]
    @is_active = true
  end

  def create_players
    puts instructions
    @players = Hash.new
    puts pick_color('one')
    @players[:player_one] = Player.new
    puts "Player one, your color is: #{@players[:player_one].color}"
    puts ''
    puts pick_color('two')
    @players[:player_two] = Player.new
    puts "Player two, your color is: #{@players[:player_two].color}"
  end
end
