input = File.read('input.txt').strip.chars.map(&:to_i).map.with_index {
  [_2 & 1 == 0 ? _2/2 : nil, _1.to_i]
}.reject { _2 == 0 }

result = []
until input.empty?
  id, n = input.shift
  if id
    result += [id] * n
    next
  else
    while n != 0
      tail = input[-1]
      if tail[1] == 0 || tail[0].nil?
        input.pop
        next
      end
      result << tail[0]
      tail[1] -= 1
      n -= 1
    end
  end
end

p result.map.with_index { _1*_2 }.sum
