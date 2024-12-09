input = File.read('input.txt').strip.chars.map(&:to_i).map.with_index {
  [_2 & 1 == 0 ? _2/2 : nil, _1.to_i]
}.reject { _2 == 0 }

tail = []

until input.empty?
  id, n = input.pop
  if !id
    tail << [nil, n]
    next
  end

  i = input.index { !_1 && _2 >= n }
  if i
    input[i..i] = [[id, n], [nil, input[i][1] - n]]
    tail << [nil, n]
    next
  end

  tail << [id, n]
end

p tail.reverse.flat_map { [_1] * _2 }.map.with_index { (_1 || 0)  * _2 }.sum
