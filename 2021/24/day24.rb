# A terrible brute-force which I wrote for 30 minutes and ran for 20 minutes
# Maybe I'll spend more time on this if I have time
# So far I have no better ideas

class Val
  def initialize(r = [])
    @range = r
  end
  def self.[](*r)
    return new(r)
  end
  def reset
    @range = [0]
  end
  attr_accessor :range
  def inspect
    "(#{@range.min}; #{@range.max}) \# #{@range.length}"
  end
end

Regs = 4.times.map { Val[0] }

class Inp
  def initialize(a, i)
    @a = Regs[a.ord - ?w.ord]
    @i = i
    reset
  end
  def execute
    @a.range = @val
  end
  def reset
    @val = (1..9).to_a
  end
  attr_accessor :val
  def log
    puts "inp #{@i}"
  end
  def inspect
    @val.inspect
  end
end

module Op
  def initialize(line, a, b)
    @line = line
    @a = Regs[a.ord - ?w.ord]
    @b = b =~ /\d/ ? Val[b.to_i] : Regs[b.ord - ?w.ord]
  end
  def execute
    @a.range = do_exec(@a.range, @b.range)
  end
  def log
    puts
    puts @line
    puts Regs.map.with_index { "#{(_2 + ?w.ord).chr}: #{_1.inspect}" }
  end
end

class Add
  include Op
  def do_exec(ra, rb)
    ret = []
    ra.each do |a|
      rb.each do |b|
        ret << a+b
      end
    end
    ret.uniq
  end
end

class Mul
  include Op
  def do_exec(ra, rb)
    return ra if rb == [1]
    return rb if ra == [1]
    return [0] if ra == [0] || rb == [0]
    ret = []
    ra.each do |a|
      rb.each do |b|
        ret << a*b
      end
    end
    ret.uniq
  end
end

class Div
  include Op
  def do_exec(ra, rb)
    return ra if rb == [1]
    return [0] if ra == [0]
    ret = []
    rb.each do |b|
      next if b == 0
      ra.each do |a|
        ret << a/b
      end
    end
    ret.uniq
  end
end

class Mod
  include Op
  def do_exec(ra, rb)
    return ra if rb == [1]
    return [0] if ra == [0]
    posb = rb.select { _1 > 0 }
    ret = []
    ra.select { _1 >= 0 }.each do |a|
      posb.each do |b|
        ret << a%b
      end
    end
    ret.uniq
  end
end

class Eql
  include Op
  def do_exec(ra, rb)
    return [0] if (ra & rb).empty?
    return [1] if ra.length == 1 && rb.length == 1 && ra[0] == rb[0]
    return [0, 1]
  end
end

$pass = []
$ops = []

File.readlines('input.txt').each do |l|
  op, a, b = l.strip!.split

  if op == 'inp'
    inp = Inp.new a, $pass.length
    $pass << inp
    $ops << inp
  else
    $ops << eval(op.capitalize).new("#{$ops.length}: #{l}", a, b)
  end
end

def test_run
  Regs.each(&:reset)
  $ops.each(&:execute)
  Regs[-1].range.include?(0)
end

def bf(i)
  p $pass if i == 3
  $order.each do |d|
    $pass[i].val = [d]
    next if !test_run
    return true if i == 13
    return true if bf(i+1)
  end
  $pass[i].reset
  false
end

# a
$order = 9.downto(1).to_a
bf(0)
p $pass.map(&:val).flatten.join

# b
$pass.each(&:reset)
$order = 1.upto(9).to_a
bf(0)
p $pass.map(&:val).flatten.join
