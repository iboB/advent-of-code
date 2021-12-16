$input = File.read('input.txt').strip.each_char.map { |c| c.to_i(16).to_s(2).rjust(4, '0').split(//) }.flatten

class Array
  def td(n)
    ret = []
    n.times { ret << shift }
    ret
  end
  def b2i
    join.to_i(2)
  end
end

class Hash
  def ver_sum
    self[:v] + (self[:d] ? 0 : self[:s].map(&:ver_sum).sum)
  end
  def sub_data
    self[:d] || self[:s].map(&:calc)
  end
  def calc
    sd = sub_data
    case self[:i]
    when 0 then sd.sum
    when 1 then sd.inject &:*
    when 2 then sd.min
    when 3 then sd.max
    when 4 then sd
    when 5 then sd[0] > sd[1] ? 1 : 0
    when 6 then sd[0] < sd[1] ? 1 : 0
    when 7 then sd[0] == sd[1] ? 1 : 0
    end
  end
end

def parse
  ver = $input.td(3).b2i
  id = $input.td(3).b2i
  if id == 4
    data = []
    while true
      g = $input.td(5)
      c = g.shift
      data += g
      break if c == ?0
    end
    return {v: ver, i: id, d: data.b2i}
  else
    subs = []
    lt = $input.shift
    if lt == ?0
      num = $input.td(15).b2i
      target = $input.length - num
      while $input.length > target
        subs << parse
      end
    else
      nsubs = $input.td(11).b2i
      nsubs.times do
        subs << parse
      end
    end
    return {v: ver, i: id, s: subs}
  end
end

root = parse

# a
p root.ver_sum

# b
p root.calc
