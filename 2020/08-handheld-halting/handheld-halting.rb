input = File.readlines('input.txt').map { |line|
  line.split(' ').tap { |i|
    i[0] = i[0].to_sym
    i[1] = i[1].to_i
  }
}

class Execute
  def initialize(code)
    @code = code
    @ip = 0
    @a = 0
    @code = code.map { |i| i.dup << 0 }
  end
  def nop(v)
    @ip += 1
  end
  def jmp(v)
    @ip += v
  end
  def acc(v)
    @a += v
    @ip += 1
  end
  def run
    loop do
      return [@a, :t] if @ip >= @code.length
      i = @code[@ip]
      return [@a, :l] if i[-1] > 0
      i[-1] += 1
      send(i[0], i[1])
    end
  end
end

p Execute.new(input).run

p input.each_with_index { |inst, ind|
  next if inst[0] == :acc
  ch = input.dup
  ch[ind] = inst.dup.tap { |i| i[0] = i[0] == :nop ? :jmp : :nop }
  res = Execute.new(ch).run
  break res if res[1] == :t
}

