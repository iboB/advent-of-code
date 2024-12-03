input = File.read('input.txt').strip

# a
p input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { |a, b| a.to_i * b.to_i }.sum

# b
input = input.scan(/(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don't\(\))/).map(&:compact).flatten

accept = 1
p input.map { |cmd|
  if cmd.start_with?('do')
    accept = cmd == 'do()' ? 1 : 0
    next 0
  end
  accept * cmd.scan(/\d+/).map(&:to_i).inject(&:*)
}.sum
