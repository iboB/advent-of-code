Dirs = [
  [-1,-1], [-1, 0], [-1, 1],
  [ 0,-1],          [ 0, 1],
  [ 1,-1], [ 1, 0], [ 1, 1],
]

Dirs = [
  -1 + -1i, -1 +  0i, -1 +  1i,
   0 + -1i,            0 +  1i,
   1 + -1i,  1 +  0i,  1 +  1i,
]

input = File.readlines('input.txt').map { |l|
  l.strip.scan(/\d+/).map(&:to_i)
}

input = File.read('input.txt').strip.split(',').map(&:to_i)
