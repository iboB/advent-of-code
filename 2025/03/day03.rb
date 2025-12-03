# solution for both parts created for part 2
# build number by selecting max first digits for a length n
# and throwing out the digits to the left of it

input = File.readlines(?i).map { _1.strip.chars.map(&:to_i) }

p [2,12].map { |part|
  input.map { |seq|
    part.downto(1).map { |n|
      d, i = seq[..-n].each_with_index.max_by { [_1, -_2] }
      seq = seq[(i + 1)..]
      d
    }.join.to_i
  }.sum
}
