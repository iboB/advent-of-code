input = File.readlines('input.txt').map { |l|
  l.strip.split(' | ').map(&:split)
}

p input
