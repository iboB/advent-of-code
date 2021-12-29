I16 = 0xFFFF

def wval(s)
  is = s.to_i
  is.to_s == s ? is : Wires[s].val
end

module UnaryOp
  def initialize(w)
    @w = w
  end
  def val
    return @val if @val
    @val = calc(wval(@w))
  end
  def reset
    @val = nil
  end
end

class Mov
  include UnaryOp
  def calc(w)
    w
  end
end

class Not
  include UnaryOp
  def calc(w)
    I16 - w
  end
end

module BinaryOp
  def initialize(a, b)
    @a = a
    @b = b
  end
  def val
    return @val if @val
    @val = calc(wval(@a), wval(@b))
  end
  def reset
    @val = nil
  end
end

class And
  include BinaryOp
  def calc(a, b)
    a & b
  end
end

class Or
  include BinaryOp
  def calc(a, b)
    a | b
  end
end

class Lshift
  include BinaryOp
  def calc(a, b)
    (a << b) & I16
  end
end

class Rshift
  include BinaryOp
  def calc(a, b)
    a >> b
  end
end

def parse(op)
  parts = op.split
  return Mov.new(op) if parts.size == 1
  return Not.new(parts[1]) if parts.size == 2
  eval(parts[1].downcase.capitalize).new(parts[0], parts[2])
end

Wires = File.readlines('input.txt').map { |l|
  op, wire = l.strip.split(' -> ')
  [wire, parse(op)]
}.to_h

# a
p a = Wires[?a].val

# b
Wires.values.each(&:reset)
Wires[?b] = Mov.new(a.to_s)
p Wires[?a].val
