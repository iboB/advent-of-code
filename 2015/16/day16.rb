query = {
  children: 3,
  cats: '>7',
  samoyeds: 2,
  pomeranians: '<3',
  akitas: 0,
  vizslas: 0,
  goldfish: '<5',
  trees: '>3',
  cars: 2,
  perfumes: 1,
}

def mfa(sue, q)
  case q
  when Integer then sue == q
  else sue == q[1].to_i
  end
end

def mfb(sue, q)
  case q
  when Integer then sue == q
  else eval(sue.to_s + q)
  end
end

a = b = nil
File.readlines('input.txt').map.with_index { |l, i|
  sue = l.strip.scan(/\w+/)[2..].each_slice(2).map { |name, num|
    [name.to_sym, num.to_i]
  }.to_h
  a = i if sue.merge(query) { mfa(_2, _3) }.values.all?
  b = i if sue.merge(query) { mfb(_2, _3) }.values.all?
  break if a && b
}

p a + 1
p b + 1
