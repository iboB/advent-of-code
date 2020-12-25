mask = []

def rgen(i, b, ar, &block)
  if i == ar.length
    block.(b)
    return
  end
  if ar[i] == ?X
    b << ?0
    rgen(i+1, b, ar, &block)
    b.pop
    b << ?1
    rgen(i+1, b, ar, &block)
    b.pop
  else
    b << ar[i]
    rgen(i+1, b, ar, &block)
    b.pop
  end
end

def gen(ar, &block)
  rgen(0, [], ar, &block)
end

sets = {}

File.readlines('input.txt').each do |l|
  if l =~ /^mask = (.+)$/
    mask = $1.chars
  elsif l =~ /^mem\[(\d+)\] = (\d+)$/
    gen($1.to_i.to_s(2).rjust(36, ?0).chars.zip(mask).map { |c, m| m == ?0 ? c : m }) { |g|
      sets[g.join] = $2.to_i
    }
  else
    raise l
  end
end

p sets.values.sum
