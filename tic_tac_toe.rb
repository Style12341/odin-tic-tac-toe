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

# Board Class
class Board
  attr_accessor :board

  def initialize(size)
    @board = Array.new(size) { Array.new(size, ' ') }
    @symbol1 = ''
    @symbol2 = ''
  end

  def set_symbols(sym1, sym2)
    @symbol1 = sym1
    @symbol2 = sym2
  end

  def display_board
    @board.each_with_index do |row, i|
      print '|'
      row.each do |cell|
        print " #{cell} |"
      end
      print "\n"
      puts '-------------' if i < @board.size - 1
    end
  end

  def row_winner?(row)
    @board[row].all? { |cell| cell == @board[row][0] } && @board[row][0] != ' '
  end

  def col_winner?(col)
    @board.reduce(true) { |acc, row| acc && row[col] == @board[0][col] && row[col] != ' ' }
  end

  def first_diag_winner?
    offset = -1
    @board.reduce(true) do |acc, row|
      offset += 1
      acc && row[0 + offset] == @board[0][0] && row[0] != ' '
    end
  end

  def second_diag_winner?
    offset = -1
    @board.reduce(true) do |acc, row|
      offset += 1
      acc && row[@board.size - offset] == @board[0][@board.size - 1] && row[@board.size - 1] != ' '
    end
  end

  def diag_winner?
    first_diag_winner? || second_diag_winner?
  end

  def winner?
    @board.each_with_index do |_, i|
      return true if row_winner?(i) || col_winner?(i)
    end
    diag_winner?
  end

  def valid_move?(row, col)
    @board[row][col] == ' ' && row < @board.size && col < @board.size && row >= 0 && col >= 0
  end

  def move(move, symbol)
    @board[move[0]][move[1]] = symbol
  end
end
