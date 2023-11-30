input = File.readlines('input.txt').map { |l|
  l.strip
}

input = File.read('input.txt').strip.split(',').map(&:to_i)
