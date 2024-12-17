inst = File.readlines('input.txt').then { |lines|
  @a, @b, @c = lines[..3].map { _1.split[-1].to_i }
  lines[4].strip.split[-1].split(?,).map(&:to_i).each_slice(2).to_a
}

ip = 0
out = []

orig = [@a, @b, @c]

def cmb(n)
  return n if n < 4
  [@a, @b, @c][n - 4]
end

while ip < inst.size
  code, operand = inst[ip]
  case code
  when 0 then @a >>= cmb(operand)
  when 1 then @b ^= operand
  when 2 then @b = cmb(operand) & 7
  when 3 then ip = operand/2 - 1 if @a != 0
  when 4 then @b ^= @c
  when 5 then out << (cmb(operand) & 7)
  when 6 then @b = @a >> cmb(operand)
  when 7 then @c = @a >> cmb(operand)
  end
  ip += 1
end

puts out.join(?,)
