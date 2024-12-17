# generate program from input
def cmb(n) = ((0..3).to_a + [?a, ?b, ?c])[n]

inst = File.readlines('input.txt')[-1].strip.split[-1].split(?,).map(&:to_i).each_slice(2).to_a

inst.each.with_index { |(code, operand), ip|
  print "#{ip}: "
  puts case code
  when 0 then "a >>= #{cmb(operand)}"
  when 1 then "b ^= #{operand}"
  when 2 then "b = #{cmb(operand)} & 7"
  when 3 then "goto #{operand/2} if a"
  when 4 then "b ^= c"
  when 5 then "puts #{cmb(operand)} & 7"
  when 6 then "b = a >> #{cmb(operand)}"
  when 7 then "c = a >> #{cmb(operand)}"
  end
}
