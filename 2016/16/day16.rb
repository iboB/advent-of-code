def solve(str, len)
  ar = str.split(//).map { _1 == ?1 }
  ar = ar + [false] + ar.reverse.map(&:!) while ar.length < len
  ar = ar[...len]

  ar = ar.each_slice(2).map { _1 == _2 } while ar.length.even?

  ar.map { _1 ? '1' : '0' }.join
end

# a
puts solve('01111001100111011', 272)

# b
puts solve('01111001100111011', 35651584)
