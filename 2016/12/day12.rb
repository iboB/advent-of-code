input = File.readlines('input.txt').map { |l|
  l.strip.split(' ')
}

def execute(asm, c)
  mem = Hash.new { |h, k| k.to_i }
  mem.merge!({'a'=>0, 'b'=>0, 'c'=>c, 'd'=>0})
  ip = 0

  while ip < asm.length
    inst, a0, a1 = asm[ip]
    ip += case inst
    when 'cpy'
      mem[a1] = mem[a0]
      1
    when 'inc'
      mem[a0] += 1
      1
    when 'dec'
      mem[a0] -= 1
      1
    when 'jnz'
      mem[a0] == 0 ? 1 : a1.to_i
    end
  end

  mem['a']
end

# a
p execute(input, 0)

# b
p execute(input, 1)

