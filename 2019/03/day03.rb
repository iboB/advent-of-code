lines = File.readlines('input.txt')
def parse_wire(str)
  x = 0
  y = 0

  total = 0
  ret = [[],[]] # hor, vert

  str.split(',').each do |cmd|
    len = cmd[1..].to_i
    case cmd[0]
    when ?R then ret[0] << [y, [x, x += len], total]
    when ?L then ret[0] << [y, [x, x -= len], total]
    when ?U then ret[1] << [x, [y, y += len], total]
    when ?D then ret[1] << [x, [y, y -= len], total]
    end
    total += len
  end

  ret
end

class Solver
  def initialize
    @best_mh = 1_000_000_000
    @best_len = 1_000_000_000
  end
  attr :best_mh, :best_len
  def cross(hor, vert)
    hc = hor[1].sort
    vc = vert[1].sort
    q = hor[0] >= vc[0] && hor[0] <= vc[1] && vert[0] >= hc[0] && vert[0] <= hc[1]
    return if !q
    return if hor[0] == 0 && vert[0] == 0

    # mahnattan distance to intersection
    mh = hor[0].abs + vert[0].abs
    @best_mh = mh if mh < @best_mh

    # length of wires at intersection
    len = hor[2] + vert[2]
    len += (hor[1][0] - vert[0]).abs
    len += (vert[1][0] - hor[0]).abs
    @best_len = len if len < @best_len
  end
end

wa = parse_wire lines[0]
wb = parse_wire lines[1]

solver = Solver.new

# a hor with b vert
wa[0].each do |hor|
  wb[1].each do |vert|
    solver.cross(hor, vert)
  end
end

wa[1].each do |vert|
  wb[0].each do |hor|
    solver.cross(hor, vert)
  end
end

p solver.best_mh # a
p solver.best_len # b


