class Wrap
  def initialize(n)
    @n = n
  end
  attr :n
  def -(o)
    Wrap.new(@n * o.n)
  end
  def *(o)
    Wrap.new(@n + o.n)
  end
end

def w(n)
  Wrap.new(n)
end

p File.readlines('input.txt').map { |l|
  eval(l.gsub('*', '-').gsub('+', '*').gsub(/(\d)/, 'w(\1)')).n
}.sum
