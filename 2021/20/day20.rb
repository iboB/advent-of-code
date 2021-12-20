class String
  def s2b
    split(//).map { _1 == ?# }
  end
end

Algo, img = File.read('input.txt').strip.split("\n\n").yield_self { |algo, img|
  [algo.s2b, img.lines.map(&:strip).map(&:s2b)]
}

def niner(img, x, y, void)
  ret = 0
  (y-1..y+1).each do |iy|
    if iy < 0 || iy >= img.length
      ret *= 8
      ret += void ? 7 : 0
      next
    end
    row = img[iy]
    (x-1..x+1).each do |ix|
      bit = (ix < 0 || ix >= row.length) ? void : row[ix]
      ret *= 2
      ret += bit ? 1 : 0
    end
  end
  ret
end

def apply(img, void)
  rl = img[0].length
  ret = (-2...img.length+2).map { |y|
    (-2...rl+2).map { |x|
      Algo[niner(img, x, y, void)]
    }
  }
  [ret, void ? Algo[511] : Algo[0]]
end

def solve(img, n)
  void = false
  n.times do
    img, void = apply(img, void)
  end
  img.flatten.count(true)
end

# a
p solve(img, 2)

# b
p solve(img, 50)
