class Vec
  def initialize(x, y)
    @x = x
    @y = y
  end
  attr :x, :y
  def self.[](x, y)
    Vec.new(x, y)
  end
  def +(v2)
    Vec[@x+v2.x,@y+v2.y]
  end
  def *(d)
    Vec[@x*d,@y*d]
  end
  def rr
    @x,@y = -@y,@x
  end
  def rl
    @x,@y = @y,-@x
  end
  def asum
    @x.abs+@y.abs
  end
end

# 0123 = enws

Dirs = [Vec[1,0],Vec[0,-1],Vec[-1,0],Vec[0,1]]

def a(input)
  idir = 0
  ship = Vec[0,0]

  exec = {
    E: -> d { ship += Dirs[0]*d },
    N: -> d { ship += Dirs[1]*d },
    W: -> d { ship += Dirs[2]*d },
    S: -> d { ship += Dirs[3]*d },
    F: -> d { ship += Dirs[idir]*d },
    R: -> deg {
      idir -= deg/90
      idir += 4 while idir < 0
    },
    L: -> deg {
      idir += deg/90
      idir -= 4 while idir >= 4
    },
  }
  input.map { |i| exec[i[0]].(i[1]) }
  ship.asum
end

def b(input)
  idir = 0
  wp = Vec[10,-1]
  ship = Vec[0,0]

  exec = {
    E: -> d { wp += Dirs[0]*d },
    N: -> d { wp += Dirs[1]*d },
    W: -> d { wp += Dirs[2]*d },
    S: -> d { wp += Dirs[3]*d },
    F: -> d { ship += wp*d },
    R: -> deg { (deg/90).times { wp.rr } },
    L: -> deg { (deg/90).times { wp.rl } },
  }
  input.map { |i| exec[i[0]].(i[1]) }
  ship.asum
end

input = File.readlines('input.txt').map { |line|
  line =~ /^([A-Z])(\d+)/
  [$1.to_sym, $2.to_i]
}

p a(input)
p b(input)


