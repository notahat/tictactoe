class Board

  def initialize
    @board = [[nil,nil,nil],
              [nil,nil,nil],
              [nil,nil,nil]]
  end

  def win?(current_player, row, col)
    lines = []

    left_diagonal = [[0,0],[1,1],[2,2]]
    right_diagonal = [[2,0],[1,1],[0,2]]

    [left_diagonal, right_diagonal].each do |line|
      lines << line if line.include?([row,col])
    end

    lines << (0..2).map { |c1| [row, c1] }
    lines << (0..2).map { |r1| [r1, col] }

    win = lines.any? do |line|
      line.all? { |row,col| @board[row][col] == current_player }
    end
  end

  def tie?
    @board.flatten.compact.length == 9
  end

  def draw
    puts @board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
  end

  def cell_occupied?(row, col)
    !@board.fetch(row).fetch(col).nil?
  end

  def make_move(player, row, col)
    @board[row][col] = player
  end

  def read_row_and_column
    row, col = nil

    begin
      print "\n>> "
      row, col = gets.split.map { |e| e.to_i }

      if !row_and_column_valid?(row, col)
        puts "Out of bounds, try another position"
      elsif cell_occupied?(row, col)
        puts "Cell occupied, try another position"
      end
    end until row_and_column_valid?(row, col) && !cell_occupied?(row, col)

    return row, col
  end

private

  def row_and_column_valid?(row, col)
    [0, 1, 2].include?(row) && [0, 1, 2].include?(col)
  end

end



board = Board.new
players = [:X, :O].cycle

current_player = nil
row, col = nil

begin
  current_player = players.next 

  board.draw

  row, col = board.read_row_and_column
  board.make_move(current_player, row, col)
end until board.win?(current_player, row, col) || board.tie?

if board.win?(current_player, row, col)
  puts "#{current_player} wins!"
elsif board.tie?
  puts "It's a tie!"
end
