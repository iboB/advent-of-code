input = File.readlines('input.txt').map { |l|
  l.strip.split(' -> ').map { |pt|
    pt.split(',').map { |n| n.to_i }
  }
}

planeVert = Hash.new(0)
planeAll = Hash.new(0)

input.each do |b, e|
  x = b[0]
  y = b[1]

  dx = e[0] - b[0]
  dy = e[1] - b[1]

  len = dx == 0 ? dy.abs : dx.abs

  dx /= len
  dy /= len

  (len+1).times do
    planeAll[[x, y]] += 1
    planeVert[[x, y]] += 1 if dx == 0 || dy == 0
    x += dx
    y += dy
  end
end

def count(plane)
  plane.values.select { |n| n > 1 }.length
end

# a
p count(planeVert)

# b
p count(planeAll)
