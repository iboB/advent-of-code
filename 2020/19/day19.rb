irules, Tests = File.read('input.txt').split("\n\n")

class Seq<Array; end # so we can test for seq and not match array

Rules = []
irules.each_line { |r|
  id, data = r.split(': ')
  id = id.to_i
  if data.start_with?('"')
    data = eval(data)
  else
    data = Seq.new data.split(' | ').map { |m| m.split(' ').map(&:to_i) }
  end
  Rules[id] = data
}

def match(r, strs)
  return strs.select { |s| s.start_with?(r) }.map { |s| s[r.length..] } if String === r

  return match(Rules[r], strs) if Integer === r

  return r.map { |s| match(s, strs) }.flatten if Seq === r

  r.each do |m|
    strs = match(m, strs)
    return [] if strs.empty?
  end
  strs
end

def solve
  Tests.each_line.select { |t|
    match(0, [t.strip]).any? { |str| str.empty? }
  }.length
end

p solve
Rules[8] << [42, 8]
Rules[11] << [42, 11, 31]
p solve
