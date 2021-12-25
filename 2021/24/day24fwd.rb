class FalseClass; def to_i; 0 end end
class TrueClass; def to_i; 1 end end

class Val
  def initialize(r, c)
    @range = r
    @str = c
  end

  attr :range, :str

  def op_parens(a, op, b)
    "(#{a} #{op} #{b})"
  end

  def op(a, op, b)
    "#{a} #{op} #{b}"
  end

  def addi(i)
    return self if i == 0
    Val.new @range.map { _1 + i }, op_parens(@str, '+', i)
  end

  alias_method :iadd, :addi

  def addv(v)
    Val.new @range.product(v.range).map { _1 + _2 }.uniq, op_parens(@str, '+', v.str)
  end

  def muli(i)
    return self if i == 1
    return 0 if i == 0
    Val.new @range.map { _1 * i }, op(@str, '*', i)
  end

  alias_method :imul, :muli

  def mulv(v)
    Val.new @range.product(v.range).map { _1 * _2 }.uniq, op(@str, '*', v.str)
  end

  def divi(i)
    return self if i == 1
    nr = @range.map { _1 / i }.uniq
    return nr[0] if nr.length == 1
    Val.new nr, op(@str, '/', i)
  end

  def idiv(i)
    return 0 if i == 0
    nr = @range.select { _1 != 0 }.map { i / _1 }.uniq
    return nr[0] if nr.length == 1
    Val.new nr, op(i, '/', @str)
  end

  def divv(v)
    @range.product(v.range.select { _1 != 0 }).map { _1 / _2 }.uniq
    return nr[0] if nr.length == 1
    Val.new nr, op(@str, '/', v.str)
  end

  def modi(i)
    nr = @range.select { _1 >= 0 }.map { _1 % i }.uniq
    return nr[0] if nr.length == 1
    Val.new nr, op_parens(@str, '%', i)
  end

  def imod(i)
    nr = @range.select { _1 > 0 }.map { i % _1 }.uniq
    return nr[0] if nr.length == 1
    Val.new nr, op_parens(i, '%', @str)
  end

  def modv(v)
    @range.select { _1 >= 0 }.product(v.range.select { _1 > 0 }).map { _1 % _2 }.uniq
    return nr[0] if nr.length == 1
    Val.new nr, op_parens(@str, '%', v.str)
  end

  def eqli(i)
    return 0 if !@range.include?(i)
    Val.new [0, 1], op_parens(@str, '==', i) + ".to_i"
  end

  alias_method :ieql, :eqli

  def eqlv(v)
    return 0 if (@range & v.range).empty?
    Val.new [0, 1], op_parens(@str, '==', v.str) + ".to_i"
  end

  def perform(op, arg)
    return send(op + 'i', arg) if Integer === arg
    send(op + 'v', arg)
  end
end

class Integer
  def perform(op, arg)
    return arg.send('i' + op, self) if !(Integer === arg)
    case op
    when 'add' then self + arg
    when 'mul' then self * arg
    when 'div' then self / arg
    when 'mod' then self % arg
    when 'eql' then (self == arg).to_i
    end
  end
end

regs = [0]*4 # wxyz

lim = 0
ii = 0
input = File.readlines('input.txt').map { |l|
  op, a, b = l.strip.split

  a = a.ord - ?w.ord

  if op == 'inp'
    regs[a] = Val.new (1..9).to_a, "m[#{ii}]"
    ii += 1
  else
    va = regs[a]
    vb = b =~ /\d/ ? b.to_i : regs[b.ord - ?w.ord]

    regs[a] = va.perform(op, vb)
  end

  lim += 1
  # break if lim > 140
}

z = regs[-1]
puts z.range.length
puts z.range.min
puts z.range.max
puts z.str


