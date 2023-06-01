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
      col = (position - 1) % 3
    elsif position.between?(7, 9)
      row = 2
      col = (position - 1) % 3
    else
      raise StandardError, 'Invalid Position'
    end
    { row: row, col: col }
  end

  def initialize
    @board = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
  end

  def to_s
    pretty_board = ''
    board.each do |row|
      line = ''
      row.each do |col|
        line += "[#{col}]"
      end
      pretty_board = "#{pretty_board}#{line}\n"
    end
    "#{pretty_board}\n"
  end

  def handle_move(marker, position)
    raise StandardError 'Invalid Move - please try again' unless valid_move?(position)

    coordinates = Board.pos_to_coord(position)
    drop_marker(marker, coordinates[:row], coordinates[:col])
  end

  def full?
    board.all? { |row| row.all? { |col| %w[X O].include? col } }
  end

  private

  def marker_has_row?(marker, row_num)
    board[row_num].all? { |col| col == marker }
  end

  def marker_has_col?(marker, col_num)
    board.all? do |row|
      row[col_num] == marker
    end
  end

  def marker_wins_by_row?(marker)
    (0..2).all? { |row| marker_has_row?(marker, row) }
  end

  def marker_wins_by_col?(marker)
    (0..2).all? { |col| marker_has_col?(marker, col) }
  end

  def marker_has_tl_diagonal?(marker)
    3.times do |num|
      board[num][num]
      marker
    end
  end

  def marker_has_tr_diagonal(marker)
    3.times do |num|
      col = num == 0 ? 2 : (num + 2) % 2
      board[num][col]
      marker
    end
  end

  def valid_move?(position)
    position.between?(0, 9)
    coord = Board.pos_to_coord(position)
    !marked?(coord[:row], coord[:col])
  end

  def marked?(row, col)
    %w[X O].include?(board[row][col])
  end

  def drop_marker(marker, row, col)
    board[row][col] = marker
  end

  def marker_has_won?(marker)
    win_by_row = marker_wins_by_row(marker)
    win_by_col = marker_wins_by_col(marker)
    win_by_tl_diag = marker_has_tl_diagonal?(marker)
    win_by_tr_diag = marker_has_tr_diagonal(marker)
    [
      win_by_row,
      win_by_col,
      win_by_tl_diag,
      win_by_tr_diag
    ].any?
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
    return unless res.downcase == 'y'

    p1 = Player.new('Player 1', 'X')
    p2 = Player.new('Player 2', 'O')

    board = Board.new

    p p1
    p p2
    p board
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

b.handle_move('X', 9)

puts b

b.handle_move('O', 9)
