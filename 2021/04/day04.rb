lines = File.readlines('input.txt').map { |l|
  l.strip
}

draw = lines[0].split(',').map { |n| n.to_i }

boards = []
1.step(lines.length-1, 6) do |i|
  b = []
  5.times do |j|
    b << lines[i+j+1].split(' ').map { |n| n.to_i }
  end
  boards << b.flatten
end

def check_win(b)
  m = b.each_slice(5).to_a
  (m + m.transpose).find { |line| line.all?(String) }
end

won = []

draw.each do |d|
  not_won = []
  boards.each do |b|
    b.map! { |n| n == d ? ?x : n }
    if check_win(b)
      won << d * b.select { |n| Integer === n }.sum
    else
      not_won << b
    end
  end
  break if not_won.empty?
  boards = not_won
end

# a
p won.first

# b
p won.last
