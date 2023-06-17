require_relative 'display'

module Instructions
  include Display

  def instructions
    <<-HEREDOC

    Welcome to my version of Connect Four!


    
    How the game works:
     - When the game starts, both players will have to pick a color, from:
        1: #{token_color(1)} | 2: #{token_color(2)} | 3: #{token_color(3)} | 4: #{token_color(4)} | 5: #{token_color(5)} | 6: #{token_color(6)}
        by typing one of the colors' corresponding number as shown above.

     - The players are then provided with a 7x7 grid

     - Each player will get prompted, one after another, to 'drop a token' into one of the columns,
       simply by typing the corresponding number of the column they want to place the token in. The token
       will then go down to the lowest available row.

     - When one of the players connects #{colorize('FOUR', 'yellow')} of their own tokens together, either
       horizontally, vertically, or diagonally. That player wins the game.

     - But when the grid has been filled, and no winner has been determined, the game ends in a draw.

     - Either player can also enter 'q' or 'quit' at any time to stop playing the game.



    Best of luck to you, and enjoy the game!
    HEREDOC
  end
end