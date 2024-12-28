input = File.read('input.txt').strip.chars.map(&:to_i)
puts [1, input.size/2].map { |d|
  input.map.with_index { _1 if _1 == input[_2-d] }.compact.sum
}
