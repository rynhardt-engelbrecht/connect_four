# frozen_string_literal: true

# module containing main functionality of the game.
module CFLogic
  def make_move(column = player_input)
    row_to_update = find_empty_slot(column)
    grid[row_to_update][column] = @current_turn.number

    if win?(row_to_update, column, @current_turn)
      @is_active = false
      puts "Congratulations! Player #{@current_turn.color} won the game!"
    else
      swap_turn
    end
  end

  def player_input(input = '')
    until input.match(/^[0-6]$/) && find_empty_slot(input.to_i)
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

  def win?(current_row, current_col, player)
    horizontal_win?(current_row, player) ||
      vertical_win?(current_col, player) ||
      diagonal_win?(current_row, current_col, player)
  end

  def horizontal_win?(current_row, player)
    counter = 1

    (1..6).each do |index|
      if grid[current_row][index] == grid[current_row][index - 1] && grid[current_row][index] == player.number
        counter += 1
        return true if counter == 4
      else
        counter = 1
      end
    end

    false
  end

  def vertical_win?(current_col, player)
    counter = 1

    (1..6).each do |index|
      if grid[index][current_col] == grid[index - 1][current_col] && grid[index][current_col] == player.number
        counter += 1
        return true if counter == 4
      else
        counter = 1
      end
    end

    false
  end

  def diagonal_win?(current_row, current_col, player)
    diagonal_up_array = create_diagonal_up_array(current_row, current_col)
    diagonal_down_array = create_diagonal_down_array(current_row, current_col)
    # make 1-dimensional arrays to be used in the horizontal_win? method

    traverse_diagonal_array(diagonal_up_array, player) || traverse_diagonal_array(diagonal_down_array, player)
  end

  def traverse_diagonal_array(array, player)
    counter = 1

    (1..array.length).each do |index|
      if array[index] == array[index - 1] && array[index] == player.number
        counter += 1
        return true if counter == 4
      else
        counter = 1
      end
    end

    false
  end

  def create_diagonal_up_array(row, col, arr = [])
    while row < 6 && col.positive? # lower limit
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

  def create_diagonal_down_array(row, col, arr = [])
    while row < 7 && col < 7 # lower limit
      row += 1
      col += 1
    end

    while row.positive? && col.positive? # upper limit
      row -= 1
      col -= 1

      arr.push(grid[row][col])
    end

    arr
  end
end
