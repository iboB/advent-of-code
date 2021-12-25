input = File.readlines('input.txt').map { |l|
  l.strip.split(//)
}

H = input.length
W = input[0].length

def step(map)
  m = []

  H.times do |y|
    W.times do |x|
      c = map[y][x]
      next if c != '>'
      nx = (x + 1) % W
      next if map[y][nx] != '.'
      m << [y, nx]
    end
  end

  moved = !m.empty?
  m.each do |y, x|
    map[y][x-1] = '.'
    map[y][x] = '>'
  end

  m = []

  H.times do |y|
    ny = (y + 1) % H
    W.times do |x|
      c = map[y][x]
      next if c != 'v'
      next if map[ny][x] != '.'
      m << [ny, x]
    end
  end

  moved = moved || !m.empty?
  m.each do |y, x|
    map[y-1][x] = '.'
    map[y][x] = 'v'
  end

  moved
end

n = 0
while step(input)
  n += 1
end

p n + 1
# puts input.map(&:join).join("\n")


