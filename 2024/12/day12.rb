Cell = Struct.new(:p, :c, :pid, :oe)
Dirs = [-1, 1i, 1, -1i]

MAP = File.readlines('input.txt').flat_map.with_index { |l, y|
  l.strip.chars.map.with_index { |c, x|
    pos = x+y.i
    [pos, Cell.new(pos, c, nil, nil)]
  }
}.to_h

def find_plot(id, start)
  plot = []
  start.pid = id
  dfs = [start]
  until dfs.empty?
    plot << (cur = dfs.shift)

    # collect neighboring positions (disregarding same-type cells)
    cur.oe = Dirs.map { [_1 * 1i, cur.p + _1] }
      .select { !MAP[_2] || MAP[_2].c != cur.c }

    # collect neighboring cells of the same type and add them to plot
    dfs += Dirs.map { MAP[cur.p + _1] }.compact
      .select { _1.c == cur.c && _1.pid.nil? }
      .tap { |nbr| nbr.each { _1.pid = id } }
  end
  plot
end

plots = []
MAP.each do |_, cell|
  next if cell.pid
  plots << find_plot(plots.size, cell)
end

# a
p plots.sum { |plot| plot.size * plot.sum { _1.oe.size } }

# b
p plots.sum { |plot|
  x = Hash.new { |h, k| h[k] = [] }
  y = Hash.new { |h, k| h[k] = [] }
  plot.flat_map(&:oe).each {
    x[_2.real + _1] << _2.imag if _1.real == 0
    y[_2.imag.i + _1] << _2.real if _1.imag == 0
  }
  plot.size * [x, y].sum { |c|
    c.values.sum { |cs| cs.sort.slice_when { _2 - _1 != 1 }.to_a.size }
  }
}
