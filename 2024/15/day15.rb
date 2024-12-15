@crates = []
@walls = Set[]
rpos = nil

moves = nil

File.read('input.txt').split("\n\n").then { |map, mvs|
  map.lines.map.with_index { |line, y|
    line.strip.chars.each.with_index { |c, x|
      p0 = 2*x + y.i
      p1 = 2*x + 1 + y.i
      case c
      when ?#
        @walls << p0 << p1
      when ?@
        rpos = p0
      when ?O
        @crates << [p0, p1]
      end
    }
  }
  moves = mvs.split.join.chars
}

d2m = {?< => -1, ?> => 1, ?^ => -1i, ?v => 1i}

def collect_crates(pos, dir, col)
  pos += dir
  return false if @walls === pos
  i = @crates.find_index { _1.include? pos }
  return true if !i
  c = @crates.delete_at(i)
  col << c
  collect_crates(c[0], dir, col) && collect_crates(c[1], dir, col)
end

moves.each { |move|
  dir = d2m[move]
  col = []
  if collect_crates(rpos, dir, col)
    rpos += dir
    col.each { |crate| crate.map! { _1 + dir } }
  end
  @crates += col
}

p @crates.sum {
  pos = _1[0]
  pos.imag * 100 + pos.real
}
