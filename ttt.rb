class Board
  attr_accessor :board

  def self.pos_to_coord(position)
    row = 0
    col = (position - 1) % 3

    if position.between?(1, 3)
      col = position - 1
    elsif position.between?(4, 6)
      row = 1
    elsif position.between?(7, 9)
      row = 2
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

  def valid_move?(input)
    res = false
    if (!input.is_a? Integer) || !input.between?(0, 9)
      res = false
    else
      coord = Board.pos_to_coord(input)
      res = !marked?(coord[:row], coord[:col])
    end
    res
  end

  def marker_has_won?(marker)
    win_by_row = marker_wins_by_row?(marker)
    win_by_col = marker_wins_by_col?(marker)
    win_by_tl_diag = marker_has_tl_diagonal?(marker)
    win_by_tr_diag = marker_has_tr_diagonal?(marker)
    puts win_by_row
    puts win_by_col
    puts win_by_tl_diag
    puts win_by_tr_diag
    [
      win_by_row,
      win_by_col,
      win_by_tl_diag,
      win_by_tr_diag
    ].any?
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

  def marker_has_tr_diagonal?(marker)
    3.times do |num|
      col = num.zero? ? 2 : (num + 2) % 2
      board[num][col]
      marker
    end
  end

  def marked?(row, col)
    %w[X O].include?(board[row][col])
  end

  def drop_marker(marker, row, col)
    board[row][col] = marker
  end
end

class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  attr_accessor :p1, :p2, :board, :current_player, :done, :winner, :turn_complete

  def initialize
    @p1 = Player.new('Player 1', 'X')
    @p2 = Player.new('Player 2', 'O')
    @board = Board.new
    @current_player = p1
    @done = false
    @winner = nil
    @turn_complete = false
    announce_start
    turn_cycle
  end

  def announce_start
    puts 'Starting a new game of Tic-Tac-Toe!'
    puts 'Type a number from 1-9 and {ENTER} to make your move'
  end

  def announce_turn(player_name, player_marker)
    puts "#{player_name} (#{player_marker}) it is your turn"
  end

  def set_the_stage
    puts announce_turn(current_player.name, current_player.marker)
    puts board
  end

  def ask_move
    set_the_stage
    gets.chomp.to_i
  end

  def turn_cycle
    turn until turn_complete
    after_turn
  end

  def turn
    move = ask_move
    if board.valid_move?(move)
      board.handle_move(current_player.marker, move)
      self.turn_complete = true
    else
      puts "Invalid move: #{move}. Please enter a number 0-9 and that has not been marked yet."
    end
  end

  def after_turn
    if board.marker_has_won?(current_player.marker)
      puts 'TBD'
    else
      self.current_player = current_player == p1 ? p2 : p1
      self.turn_complete = false
      turn_cycle
    end
  end
end

class Prompter
  def prompt
    puts "Would you like to start a game of Tic-Tac-Toe? Enter 'y' if so, any other key otherwise."
    res = gets.chomp
    return unless res.downcase == 'y'

    Game.new
  end
end

prompter = Prompter.new

prompter.prompt
