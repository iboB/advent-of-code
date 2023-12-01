PROGRAM = File.readlines('input.txt').map { |l|
  inst, a0, a1 = l.strip.split(/[\s\,]+/)
  args = case inst
    when 'hlf', 'tpl', 'inc' then a0.to_sym
    when 'jmp' then a0.to_i
    else [a0.to_sym, a1.to_i]
  end

  [inst.to_sym, args]
}

def compute(reg)
  ip = 0

  while ip < PROGRAM.length
    inst, arg = PROGRAM[ip]
    ip += case inst
      when :hlf
        reg[arg] /= 2
        1
      when :tpl
        reg[arg] *= 3
        1
      when :inc
        reg[arg] += 1
        1
      when :jmp
        arg
      when :jie
        reg[arg[0]] % 2 == 0 ? arg[1] : 1
      when :jio
        reg[arg[0]] == 1 ? arg[1] : 1
    end
  end

  reg
end

p compute({a: 0, b: 0}) # a
p compute({a: 1, b: 0}) # b
