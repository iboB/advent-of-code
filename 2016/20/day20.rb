black = File.readlines('input.txt').flat_map { |l|
  a, b = l.strip.split('-').map(&:to_i)
  [a, b * 1i]
}.sort_by(&:abs)

depth = 0

white = [0]

black.each do |i|
  if i.real?
    depth += 1
    white << i if depth == 1
  else
    depth -= 1
    white << i.abs + 1 if depth == 0
  end
end

white << 2**32

white = white.each_slice(2).map { |b, e| (b...e) if b != e }.compact

p white[0].first # a
p white.map(&:size).sum # b
