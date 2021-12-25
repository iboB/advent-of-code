require 'matrix'

class Vector
  def

regs = [0]*4 # wxyz

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
    Val.new @range + Vector[i, i], op_parens(@str, '+', i)
  end

  def addv(v)
    Val.new @range + v.range, op_parens(@str, '+', v.str)
  end

  def muli(i)
    return self if i == 1
    return 0 if i == 0
    Val.new @range * i, op(@str, '*', i)
  end

  def mulv(v)
    Val.new Vector[@range.zip(v.range).map { _1 * _2 }], op(@str, '*', v.str)
  end

  def divi(i)
    return self if i == 1
    Val.new @range / i, op(@str, '/', i)
  end

  def idiv(i)
    return 0 if i == 0
    Val.new
  end
end

input = File.readlines('input.txt').map { |l|
  op, a, b = l.strip.split
  op = op.to_sym
  a = a.ord - ?w.ord
  # b = b =~ /\d/ ? b.to_i : b.ord - ?w.ord


}