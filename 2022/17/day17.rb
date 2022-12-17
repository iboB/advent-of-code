require 'matrix'
require 'set'

Input = File.read('input.txt').strip.split(//).map { _1 == '<' ? 0 : 1 }

Shapes = [
  4.times.map { Vector[_1, 0] },
  [
    Vector[1,0],
    *3.times.map { Vector[_1, 1]},
    Vector[1,2]
  ],
  [
    *2.times.map { Vector[2, _1 + 1] },
    *3.times.map { Vector[_1, 0]},
  ],
  4.times.map { Vector[0,_1] },
  [
    *2.times.map { Vector[_1, 0] },
    *2.times.map { Vector[_1, 1]},
  ]
]

curh = 0
windi = 0
@map = Set.new

WDir = [Vector[-1, 0], Vector[1, 0]]

def trymove(shape, dir)
  shape.each do |elem|
    check = elem + dir
    return false if check[0] < 0 || check[0] > 6
    return false if check[1] < 0
    return false if @map.include?(check)
  end
  shape.map! { _1 + dir }
  true
end

def pmap
  10.times do |y|
    print '|'
    7.times do |x|
      print (@map.include?(Vector[x, 10-y-1]) ? '#' : '.')
    end
    puts '|'
  end
  puts '========='
end

lcm = Input.size.lcm(Shapes.size)

heights = []

(25*lcm).times do |shapei|
  heights << curh if shapei % lcm == 0

  shape = Shapes[shapei % Shapes.size].dup
  offset = Vector[2, curh + 3]
  shape.map! { _1 + offset }
  while true do
    push = Input[windi % Input.size]
    windi += 1
    trymove(shape, WDir[push])
    next if trymove(shape, Vector[0, -1])
    shape.each do |v|
      @map << v
      curh = [curh, v[1] + 1].max
    end
    break
  end
end

p heights
p heights.each_cons(2).map { _2 - _1 }

