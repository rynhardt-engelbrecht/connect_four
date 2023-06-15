module CFLogic
  def make_move(column = player_input)
    self.grid[6][column] = 1
  end

  def player_input(input = '')
    until input.match(/^[0-6]$/) do
      print 'Enter column number to make your move>> '
      input = gets.chomp
    end
    
    input.to_i
  end

  def find_empty_slot; end
end