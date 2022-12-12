require 'matrix'
start = nil
finish = nil
Input = File.readlines('input.txt').map.with_index { |l, y|
  l.strip.split(//).map.with_index { |e, x|
    if e == ?S
      start = Vector[x, y]
      0
    elsif e == ?E
      finish = Vector[x, y]
      25
    else
      e.ord - ?a.ord
    end
  }
}

H = Input.length
W = Input[0].length

@best = Hash.new(100000)
@best[start.hash] = 0

Dirs = [
  Vector[1, 0],
  Vector[-1, 0],
  Vector[0, 1],
  Vector[0, -1],
]

def solve(cur, len)
  ch = Input[cur[1]][cur[0]]
  len += 1
  Dirs.each do |d|
    nex = cur + d
    next if nex[0] < 0 || nex[0] >= W || nex[1] < 0 || nex[1] >= H
    nexh = Input[nex[1]][nex[0]]
    next if (nexh - ch).abs > 1
    next if @best[nex.hash] <= len
    @best[nex.hash] = len
    if nexh == 25
      puts "#{nex} @ #{len+1}"
      next
    end
    solve(nex, len)
  end
end

solve(start, 0)



