module CFLogic
  def make_move(column = player_input)
    row_to_update = find_empty_slot(column)
    self.grid[row_to_update][column] = 1
  end

  def player_input(input = '')
    until input.match(/^[0-6]$/) && find_empty_slot(input.to_i) do
      print 'Enter column number to make your move>> '
      input = gets.chomp
    end

    input.to_i
  end

  def find_empty_slot(column, row = 6)
    return row if grid[row][column].zero?
  
    find_empty_slot(column, row - 1) unless row.zero?
  end
  
end