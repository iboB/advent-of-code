# kinda lucky solution
# I thought I was going to be experiementign with various ways to record the
# state so as to find a cycle and its period, but my first try was a success:
# record shape index, wind index, and current heights relative to top
# (it's not *correct* since a shape can be "blown" into a horizontal hole, but
# this apparently never happens in the problem and sample inputs)

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

maxh = 0
@map = Set.new
maxh_per_shape = []
heights = [0] * 7
CC = {}
windi = 0
shapei = 0
while true
  shape = Shapes[shapei % Shapes.size].dup
  offset = Vector[2, maxh + 3]
  shape.map! { _1 + offset }
  while true do
    push = Input[windi % Input.size]
    windi += 1
    trymove(shape, WDir[push])
    next if trymove(shape, Vector[0, -1])
    shape.each do |v|
      @map << v
      maxh = [maxh, v[1] + 1].max
      heights[v[0]] = [heights[v[0]], v[1] + 1].max
    end

    record = [shapei % Shapes.size, windi % Input.size, heights.map { maxh - _1 }]

    ifrom = CC[record]
    if ifrom
      # found a cycle! Let's hope for the best
      puts "found @ #{shapei}"

      s = []
      if shapei > 2022
        puts "a: #{maxh_per_shape[2022]}"
      else
        s << 2022
      end

      s << 1000000000000

      hfrom = maxh_per_shape[ifrom]

      cycle_size = shapei - ifrom
      hdiff = maxh - hfrom

      puts s.map { |num|
        num -= shapei + 1
        num_cycles, rem_shapes = num.divmod cycle_size
        height_at_num = maxh + num_cycles * hdiff
        height_at_num += maxh_per_shape[ifrom + rem_shapes] - maxh_per_shape[ifrom]
        height_at_num
      }

      exit(0)
    end

    maxh_per_shape << maxh
    CC[record] = shapei
    break
  end
  shapei += 1
end
