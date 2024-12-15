require 'matrix'

rpos = nil
map, moves = File.read('input.txt').split("\n\n").then { |map, moves|
  [
    map.lines.map.with_index { |line, y|
      line = line.strip.chars
      ai = line.index ?@
      rpos = Vector[ai, y] if ai
      line
    },
    moves.split.join.chars
  ]
}

d2m = {?< => Vector[-1, 0], ?> => Vector[1, 0], ?^ => Vector[0, -1], ?v => Vector[0, 1]}
map[rpos[1]][rpos[0]] = ?.

moves.each { |move|
  dir = d2m[move]
  npos = rpos + dir

  c = map[npos[1]][npos[0]]
  next if c == ?#

  cpos = npos
  while map[cpos[1]][cpos[0]] == ?O
    cpos += dir
  end

  next if map[cpos[1]][cpos[0]] == ?#

  map[cpos[1]][cpos[0]] = ?O
  map[npos[1]][npos[0]] = ?.
  rpos = npos
}

# puts map.map(&:join).join("\n")

sum = 0

map.each.with_index { |line, y|
  line.each.with_index { |c, x|
    next if c != ?O
    sum += y * 100 + x
  }
}

p sum
