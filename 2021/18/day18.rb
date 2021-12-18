
def split(tokens)
  i = tokens.index { |t| Integer === t && t > 9 }
  return true if !i
  n = tokens[i]
  tokens[i] = ['[', n/2, ',', (n+1)/2, ']']
  tokens.flatten!
  false
end

def explode(tokens)
  ileft = nil
  iright = nil
  ikill = []
  depth = 0
  tokens.each_with_index do |t, i|
    case t
    when '[' then depth += 1
    when ']' then depth -= 1
    when Integer then ikill << i if depth >= 5
    end
    break if ikill.length == 2
  end

  return true if ikill.empty?

  ileft = tokens[0...ikill[0]].rindex { |t| Integer === t }
  tokens[ileft] += tokens[ikill[0]] if ileft

  iright = tokens[(ikill[1]+1)..-1].index { |t| Integer === t }
  tokens[ikill[1] + 1 + iright] += tokens[ikill[1]] if iright

  tokens[(ikill[0]-1)..(ikill[1]+1)] = 0

  false
end

def reduce(tokens)
  while true
    until explode tokens do; end
    return tokens if split tokens
  end
end

def sum(a, b)
  ['['] + a + [','] + b + [']']
end

input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map { |t|
    i = t.to_i
    i.to_s == t ? i : t
  }
}

r = input.inject { reduce sum(_1, _2) }

def rmag(a, n)
  return n*a if Integer === a
  n * (rmag(a[0], 3) + rmag(a[1], 2))
end

def mag(f)
  rmag eval(f.join), 1
end

# a
p mag r

# b
p input.permutation(2).map { |a, b|
  mag reduce sum(a, b)
}.max
