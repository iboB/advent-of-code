input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map(&:to_i)
}

W = input[0].length
H = input.length

lps = []

def ns(x, y)
  ret = []
  ret << [y-1, x] if y > 0
  ret << [y+1, x] if y < H-1
  ret << [y, x-1] if x > 0
  ret << [y, x+1] if x < W-1
  ret
end

H.times do |y|
  W.times do |x|
    nsvals = ns(x, y).map { |ny, nx| input[ny][nx] }
    val = input[y][x]
    lps << {pos: [x,y], basin: [], lp: val} if nsvals.all? { _1 > val }
  end
end

# a
p lps.map { |v| v[:lp] + 1 }.sum

# b
def flood(basin, input, pos)
  ival = input[pos[1]][pos[0]]
  return if !ival
  return if ival == 9
  basin << ival
  input[pos[1]][pos[0]] = nil
  ns(pos[0], pos[1]).each do |ny, nx|
    flood(basin, input, [nx,ny])
  end
end

lps.each do |lp|
  flood(lp[:basin], input, lp[:pos])
end

p lps.map { _1[:basin].length  }.sort.reverse[0...3].inject { _1*_2 }


