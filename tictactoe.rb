def win?(board, current_player, row, col)
  lines = []

  left_diagonal = [[0,0],[1,1],[2,2]]
  right_diagonal = [[2,0],[1,1],[0,2]]

  [left_diagonal, right_diagonal].each do |line|
    lines << line if line.include?([row,col])
  end

  lines << (0..2).map { |c1| [row, c1] }
  lines << (0..2).map { |r1| [r1, col] }

  win = lines.any? do |line|
    line.all? { |row,col| board[row][col] == current_player }
  end
end

def draw?(board)
  board.flatten.compact.length == 9
end

board   = [[nil,nil,nil],
           [nil,nil,nil],
           [nil,nil,nil]]

players = [:X, :O].cycle

current_player = nil
row, col = nil

begin
  current_player = players.next 

  puts board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
  print "\n>> "
  row, col = gets.split.map { |e| e.to_i }
  puts

  begin
    cell_contents = board.fetch(row).fetch(col)
  rescue IndexError
    puts "Out of bounds, try another position"
    next
  end
  
  if cell_contents
    puts "Cell occupied, try another position"
    next
  end

  board[row][col] = current_player
end until win?(board, current_player, row, col) || draw?(board)

if win?(board, current_player, row, col)
  puts "#{current_player} wins!"
end

if draw?(board)
  puts "It's a draw!"
end
