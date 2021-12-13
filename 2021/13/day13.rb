input = File.read('input.txt').split("\n\n").map { _1.split("\n") }

points = input[0].map { _1.split(',').map(&:to_i) }

folds = input[1].map {
  _1.split(' ').last.split('=').tap { |f| f[1] = f[1].to_i }
}

def fold(axis, coord, points)
  i = axis == ?x ? 0 : 1
  points.map { |c|
    next c if c[i] < coord
    d = c.dup
    d[i] = 2*coord - d[i]
    d
  }.uniq
end

# a
single = fold(folds.first[0], folds.first[1], points)
p single.length

# b
folds.each do |f|
  points = fold(f[0], f[1], points)
end

# big enough hopefully
20.times do |y|
  60.times do |x|
    print(points.include?([x,y]) ? '||' : '  ')
  end
  puts
end

# actual b answer was read by my human eyes :)
