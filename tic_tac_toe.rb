class Board

  def self.position_to_coordinates(position)
    puts "TBD"
  end

  def initialize
    @board = [
      [1], [2], [3],
      [4], [5], [6],
      [7], [8], [9],
    ]
  end

  def to_str
    p board
  end

  private

  def valid_move?(position)
    position.between?(0, 9)
  end

  def drop_marker(marker)
    puts "TBD"
  end

  def marker_wins?(marker)
    puts "TBD"
  end

  def is_full?
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

