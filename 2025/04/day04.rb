Dirs = [
  -1 + -1i, -1 +  0i, -1 +  1i,
   0 + -1i,            0 +  1i,
   1 + -1i,  1 +  0i,  1 +  1i,
]

crates = File.readlines(?i).flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    (x + y * 1i) if c == ?@
  }.compact
}.to_set

nrem = 0
while true
  rem = crates.select { |h| Dirs.map { h + _1 }.count { crates === _1 } < 4 }
  p rem.size if nrem == 0 # part a
  break if rem.empty?
  nrem += rem.size
  crates -= rem
end

# part b
p nrem
