File.readlines('input.txt')[1].split(',').map(&:to_i).each_with_index.select { |t, i|
  t != 0
}.map { |a,b|
  [a, (a-b)%a]
}.transpose.map { |group|
  group.join(',')
}.tap { |nums, rems|
  puts `wolframscript -c \"ChineseRemainder[{#{rems}},{#{nums}}]\"`
}
