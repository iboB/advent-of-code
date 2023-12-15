p File.read('input.txt').strip.split(',').map { |str|
  str.chars.map(&:ord).inject(0) { ((_1 + _2) * 17) % 256 }
}.sum
