Input = File.readlines('input.txt').map { |l|
  l.split(': ').last.split(' | ').map {
    _1.split(' ').map(&:to_i)
  }
}.map {
  _1.intersection(_2).length
}

# a
p Input.map { 2 ** (_1-1) }.map(&:to_i).sum

# b
InputRg = Input.map.with_index { |num, i|
  (i+1..i+num)
}

def num_copies(h) = h.map { _1.size * _2 }.sum

def get_copies(h)
  ret = Hash.new(0)
  h.each do |rg, num|
    InputRg[rg].each do |cprg|
      ret[cprg] += num
    end
  end
  ret
end

cur = InputRg.map { [_1, 1] }.to_h

wins = InputRg.length
until cur.empty?
  wins += num_copies(cur)
  cur = get_copies(cur)
end

p wins
