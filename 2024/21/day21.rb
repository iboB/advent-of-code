def to_pad(s) = s.lines.flat_map.with_index { |l, y| l.chomp.chars.map.with_index { [_2 + y.i, _1] } }.to_h

NP = <<~M
  789
  456
  123
  _0A
M
numpad = to_pad(NP)
numpad.delete(3i)

KP = <<~M
  _^A
  <v>
M
@keypad = to_pad(KP)
@keypad.delete(0i)

Dirs = {1i => ?v, -1i => ?^, 1+0i => ?>, -1+0i => ?<}

# find all shortest paths in map
def find_cost(pad, depth, a, b)
  return 1 if depth == 0
  return 1 if a == b

  memo = @memo[depth]
  mkey = a+b
  return memo[mkey] if memo[mkey]

  inv_pad = pad.invert

  layer = [[0, [inv_pad[a]]]]
  finish = inv_pad[b]
  best_cost = Float::INFINITY
  paths = []

  until layer.empty?
    layer = layer.flat_map { |cost, path|
      Dirs.keys.map { |d|
        next_pos = path.last + d
        next if !pad[next_pos]
        next if path.include? next_pos
        prev_dir = path.size > 1 ? Dirs[path[-1] - path[-2]] : ?A
        next_cost = cost + find_cost(@keypad, depth-1, prev_dir, Dirs[d])

        next_l = [next_cost, path + [next_pos]]
        if next_pos == finish
          best_cost = next_cost if next_cost < best_cost
          paths << next_l
          nil
        else
          next_l
        end
      }.compact
    }
  end

  memo[mkey] = paths.map { |cost, path|
    cost + find_cost(@keypad, depth-1, Dirs[path[-1] - path[-2]], ?A)
  }.min
end

input = File.readlines('input.txt').map { _1.strip }

MAX = 200
[3, 26].each { |depth|
  @memo = (MAX+1).times.map { {} }
  p input.sum { |path|
    length = (?A + path).chars.each_cons(2).map { find_cost(numpad, depth, _1, _2) }.sum
    path.scan(/\d/).join.to_i * length
  }
}
