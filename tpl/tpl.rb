Dirs = [
  [-1,-1], [-1, 0], [-1, 1],
  [ 0,-1],          [ 0, 1],
  [ 1,-1], [ 1, 0], [ 1, 1],
]

input = File.readlines('input.txt').map { |l|
  l.strip.scan(/\d+/).map(&:to_i)
}

input = File.read('input.txt').strip.split(',').map(&:to_i)
