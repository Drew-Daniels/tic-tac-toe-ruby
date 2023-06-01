class Board
  attr_accessor :board
  # TODO: Refactor to make more concise
  def self.pos_to_coord(position)
    row = nil
    col = nil

    if position.between?(1, 3)
     row = 0
     col = position - 1
    elsif position.between?(4, 6)
      row = 1
      col = (position  - 1) % 3
    elsif position.between?(7, 9)
      row = 2
      col = (position  - 1) % 3
    else
      raise StandardError.new "Invalid Position"
    end
    { row: row, col: col }
  end

  def initialize
    @board = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ]
  end

  def to_s
    pretty_board = ""
    self.board.each { |row| 
      line = ""
      row.each { |col|
        line = line + "[#{col}]"
      }
      pretty_board = pretty_board + line + "\n"
    }
    pretty_board
  end

  def handle_move(marker, position)
    if self.is_valid?(position)
      coordinates = Board.pos_to_coord(position)
      self.drop_marker(marker, coordinates.row, coordinates.col)
    else
    end
  end

  def is_full?
    self.board.all? { |row| row.all? { |col| ["X", "O"].include? col}}
  end

  private

  def valid_move?(position)
    position.between?(0, 9)
  end

  def drop_marker(marker, row, col)
    self.board[row][col] = marker
  end

  def marker_wins?(marker)
    puts "TBD"
  end
end

class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class GameController
  def prompt
    puts "Would you like to start a game of Tic-Tac-Toe? Enter 'y' if so, any other key otherwise."
    res = gets.chomp 
    if (res.downcase == "y")
      p1 = Player.new("Player 1", "X")
      p2 = Player.new("Player 2", "O")

      board = Board.new

      p p1
      p p2
      p board
    end
  end
end

gc = GameController.new

gc.prompt

(1..9).each do |pos| 
  puts pos
  puts Board.pos_to_coord(pos)
end

# Board.drop_marker('X', 9)

b = Board.new
puts b
