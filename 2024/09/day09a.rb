i = File.read('input.txt').strip.chars.map(&:to_i).map.with_index {
  [_2 & 1 == 0 ? _2/2 : nil, _1.to_i]
}.reject { _2 == 0 }

result = []
until i.empty?
  id, n = i.shift
  result += if id
    [id] * n
  else
    n.times.map {
      i.pop while i.last[1] == 0 || i.last[0].nil?
      i.last[1] -= 1
      i.last[0]
    }
  end
end

p result.map.with_index { _1*_2 }.sum
