# frozen_string_literal: true

require_relative 'connect_four'
require_relative 'instructions'

include Instructions

puts Instructions.instructions
game = ConnectFour.new
game.play_game
