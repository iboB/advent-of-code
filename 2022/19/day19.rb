require 'matrix'
class Array
  def dup_add(*pairs)
    pairs.each do |i, e|
      return nil if self[i] + e < 0
    end
    ret = self.dup
    pairs.each do |i, e|
      ret[i] += e
    end
    ret
  end
end


def solve(days, cost)
  max_r = Vector[
    [cost[0], cost[1], cost[2], cost[4]].max,
    cost[3],
    cost[5],
    1_000_000
  ]

  price = [
    Vector[cost[0], 0, 0, 0],
    Vector[cost[1], 0, 0, 0],
    Vector[cost[2], cost[3], 0, 0],
    Vector[cost[4], 0, cost[5], 0]
  ]

  buy = [
    Vector[1, 0, 0, 0],
    Vector[0, 1, 0, 0],
    Vector[0, 0, 1, 0],
    Vector[0, 0, 0, 1],
  ]

  timeline = [[Vector[1, 0, 0, 0], Vector[0, 0, 0, 0], nil]]
  1.upto(days) do |d|
    timeline = timeline.map { |t|
      rob = t[0]
      res = t[1]
      hodl = t[2]



      if hodl
        nres = res - price[hodl]
        if nres.any? { _1 < 0 }
          [[rob, res + rob, hodl]]
        else
          [[rob + buy[hodl], nres + rob, nil]]
        end
      else
        can_hodl = [
          true,
          true,
          rob[1] != 0,
          rob[2] != 0
        ]
        vars = 4.times.select {
          rob[_1] < max_r[_1] && can_hodl[_1]
        }
        vars.map { |r|
          nres = res - price[r]
          next [rob, res + rob, r] if nres.any? { _1 < 0 }
          [rob + buy[r], nres + rob, nil]
        }.compact
      end
    }.flatten(1).uniq
    p timeline.length
  end
  timeline.map { _1[1][-1] }.max
end

# p File.read('input.txt').strip.split("\n").join.split("Blueprint")[1..].map { |l|
#   p l
#   solve(24, l.split(':')[1].scan(/\d+/).map(&:to_i))
# }.map.with_index { _1 * (_2 + 1) }.sum

p File.read('input.txt').strip.split("\n").join.split("Blueprint")[1..1].map { |l|
  p l
  solve(24, l.split(':')[1].scan(/\d+/).map(&:to_i))
}.map.with_index { _1 * (_2 + 1) }.sum
