DTOI = {
  '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
  'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9,
  'oneight'=> 8, 'twone' => 1, 'threeight' => 8, 'eighthree' => 3, 'fiveight' => 8, 'sevenine' => 9, 'eightwo' => 2, 'nineight' => 8,
}

class String
  def dtoi = DTOI[self]
end

p File.readlines('input.txt').map { |l|
  a = l.strip.scan(/1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine/)[0]
  b = l.strip.scan(/1|2|3|4|5|6|7|8|9|oneight|twone|threeight|eighthree|fiveight|sevenine|eightwo|nineight|one|two|three|four|five|six|seven|eight|nine/)[-1]
  a.dtoi * 10 + b.dtoi
}.sum

