# a
p File.read('input.txt').split.select {
  _1.scan(/a|e|i|o|u/).length > 2 && !_1.scan(/(.)\1/).empty? && _1.scan(/ab|cd|pq|xy/).empty?
}.length

# b
p File.read('input.txt').split.select {
  !_1.scan(/(..).*\1/).empty? && !_1.scan(/(.).\1/).empty?
}.length

