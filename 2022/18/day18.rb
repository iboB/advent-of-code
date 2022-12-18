require 'matrix'

sides = Hash.new(0)

input = File.readlines('input.txt').map { |l|
  cube = Vector[*l.strip.split(',').map(&:to_i)]
  sides[[cube, :r]] += 1
  sides[[cube, :d]] += 1
  sides[[cube, :i]] += 1
  sides[[cube - Vector[1, 0, 0], :r]] += 1
  sides[[cube - Vector[0, 1, 0], :d]] += 1
  sides[[cube - Vector[0, 0, 1], :i]] += 1
  cube.to_a
}

# a
sides.delete_if { _2 == 2 }
p sides.length

# b
# size = input.transpose.map(&:max)
# grid = Array.new(size[2]+1) { Array.new(size[1] + 1) { Array.new(size[0] + 1, 0) } }

# incubes = Hash.new(0)

# size[2].times do |z|
#   size[1].times do |y|
#     cnt = 0
#     size[0].times do |x|
#       grid[z][y][x] = cnt
#       cnt += 1 if sides[[Vector[x,y,z], :r]]
#     end
#   end
# end
