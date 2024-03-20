#
#
# General game class
class Game
  attr_accessor :board, :player1, :player2, :current_player

  def initialize(board_size)
    @board = Board.new(board_size)
    @current_player = @player1
  end
end

# Player Class
class Player
  attr_accessor :name, :symbol

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end
end

