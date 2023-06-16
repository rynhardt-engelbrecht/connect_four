module CFLogic
  def make_move(column = player_input)
    row_to_update = find_empty_slot(column)
    self.grid[row_to_update][column] = @current_turn.number
  
    if win?(row_to_update, column)
      @is_active = false
      puts "Congratulations! Player #{@current_turn.color} won the game!"
    else
      swap_turn
    end
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
  
  def swap_turn
    temp = @current_turn
    @current_turn = @next_turn
    @next_turn = temp
  end

  def win?(current_row, current_col)
    horizontal_win?(current_row) ||
      vertical_win?(current_col) ||
      diagonal_win?(current_row, current_col)
  end

  def horizontal_win?(current_row)
    counter = 1
    row_to_iterate = grid[current_row]

    (1..6).each do |index|
      if row_to_iterate[index] == row_to_iterate[index - 1] && row_to_iterate[index] != 0
        counter += 1
        return true if counter == 4
      else
        counter = 1
      end
    end

    false
  end

  def vertical_win?(current_col)
    counter = 1

    (1..6).each do |index|
      if grid[index][current_col] == grid[index - 1][current_col] && grid[index][current_col] != 0
        counter += 1
        return true if counter == 4
      else
        counter = 1
      end
    end

    false
  end

  def diagonal_win?(current_row, current_col)
    counter_up = 1
    counter_down = 1
    
    diagonal_up_array = diagonal_up(current_row, current_col)
    diagonal_down_array = diagonal_down(current_row, current_col)

    (1..diagonal_up_array.length).each do |index|
      if diagonal_up_array[index] == diagonal_up_array[index - 1] && diagonal_up_array[index] != 0
        counter_up += 1
        return true if counter_up == 4
      else
        counter_up = 1
      end
    end

    (1..diagonal_down_array.length).each do |index|
      if diagonal_down_array[index] == diagonal_down_array[index - 1] && diagonal_down_array[index] != 0
        counter_down += 1
        return true if counter_down == 4
      else
        counter_down = 1
      end
    end

    false
  end
  
  
  def diagonal_up(row, col)
    arr = []
  
    while row < 6 && col > 0 # lower limit
      row += 1
      col -= 1
    end
  
    while row >= 0 && col < 7 # upper limit
      arr.push(grid[row][col])
      
      row -= 1
      col += 1
    end
  
    arr
  end  
  
  def diagonal_down(row, col)
    arr = []

    while row < 7 && col < 7 # lower limit
      row += 1
      col += 1
    end

    while row > 0 && col > 0 # upper limit
      row -= 1
      col -= 1

      arr.push(grid[row][col])
    end

    arr
  end
end