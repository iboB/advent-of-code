require 'set'
Dirs = [1, -1, 1i, -1i]
Elems = {?. => 0, ?> => 1, ?< => -1, ?v => 1i, ?^ => -1i}

$start = 1 + 0i
$finish = nil
walkable = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    pos = x + y * 1i
    next if !Elems[c]
    $finish = pos
    [pos, Elems[c]]
  }
}.compact.to_h

nodes = Set.new [$start, $finish] + walkable.keys.select { |pos|
  Dirs.map { pos + _1 }.count { walkable[_1] } > 2
}

coverage = nodes.map { [_1, [_1, 0, 0]] }.to_h
edges = []

q = nodes.map { [_1, _1, 0, 0] }
while !q.empty?
  pos, node, len, dm = q.shift
  at_pos = walkable[pos]
  Dirs.each do |dir|
    next_pos = pos + dir
    next if !walkable[next_pos]

    next_dm = dm
    next_dm = at_pos == dir ? 1 : -1 if dm != -1 && at_pos != 0

    cnode, clen, cdm = coverage[next_pos]
    next if cnode == node
    if cnode
      edges << [node, cnode, len + 1 + clen, dm != -1 && cdm != 1]
    else
      coverage[pos] = [node, len, next_dm]
      q << [next_pos, node, len + 1, next_dm]
    end
  end
end

def rec(cons, pos, path, len)
  return $fin_lens << len if pos == $finish
  cons[pos].each do |npos, nlen|
    next if path === npos
    rec(cons, npos, path + [npos], len + nlen)
  end
end

def solve(edges)
  $fin_lens = []
  cons = Hash.new { |h, k| h[k] = []}
  edges.each do |from, to, len|
    cons[from] << [to, len]
  end
  rec(cons, $start, Set[], 0)
  $fin_lens.max
end

# a
p solve edges.select { _4 }

# b ( brute force for 90 sec :) )
p solve edges
