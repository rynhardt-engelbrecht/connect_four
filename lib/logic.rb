# frozen_string_literal: true

require_relative 'display'
require_relative 'player'

# rubocop:disable Metrics/ModuleLength

# module containing main functionality of the game.
module CFLogic
  include Display

  def play_game
    return unless start_game?

    pretty_print

    make_move while @is_active
  end

  def start_game?(input = '')
    puts game_message('start')
    until %w[y yes n no].include?(input.downcase) || %w[q quit].include?(input.downcase)
      input = gets.chomp

      validate_start(input)
    end

    input.downcase == 'y' || 'yes'
  end

  def validate_start(input)
    if %w[q quit].include?(input.downcase)
      exit
    elsif !%w[y yes n no].include?(input.downcase)
      puts error_message('yes no')
      print '>> '
    end
  end

  def make_move(column = player_input)
    row_to_update = find_empty_slot(column)
    grid[row_to_update][column] = @current_turn.number

    pretty_print

    if win?(row_to_update, column, @current_turn)
      @is_active = false
      puts game_message('win')
    elsif draw?
      @is_active = false
      puts game_message('draw')
    else
      swap_turn
    end
  end

  def player_input(input = '')
    until input.match(/^[1-7]$/) && find_empty_slot(input.to_i - 1) || %w[q quit].include?(input.downcase)
      print turn_message('move')
      input = gets.chomp

      validate_input(input)
    end

    input.to_i - 1
  end

  def validate_input(input)
    if %w[q quit].include?(input)
      puts game_message('thanks')
      exit
    elsif (input.to_i - 1) > 6 || (input.to_i - 1).negative?
      puts error_message('input')
    elsif !find_empty_slot(input.to_i - 1)
      puts error_message('filled')
    end
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

  def draw?
    @grid.all? do |row|
      row.all? { |row| row != 0 }
    end
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

# rubocop:enable Metrics/ModuleLength
