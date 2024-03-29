require 'matrix'

def solve(days, cost)
  max_b = Vector[
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
    timeline = timeline.map { |bot, res, hodl|
      if hodl
        nres = res - price[hodl]
        if nres.any? { _1 < 0 }
          [[bot, res + bot, hodl]]
        else
          [[bot + buy[hodl], nres + bot, nil]]
        end
      else
        can_hodl = [
          true,
          true,
          bot[1] != 0,
          bot[2] != 0
        ]
        vars = 4.times.select {
          bot[_1] < max_b[_1] && can_hodl[_1]
        }
        vars.map { |b|
          nres = res - price[b]
          next [bot, res + bot, b] if nres.any? { _1 < 0 }
          [bot + buy[b], nres + bot, nil]
        }
      end
    }.flatten(1).uniq

    # fuck
    # I only thought of the following two lines after I rewrote the solution in C++
    # and submitted my answers.
    # They make it oreders of magnitude faster and even this ruby solution is viable
    # Of course it makes sense that one should buy geode as soon as possible!
    # :(
    max_g = timeline.map { _1[1][-1] }.max
    timeline = timeline.select { _1[1][-1] == max_g  }
  end
  timeline.map { _1[1][-1] }.max
end

p File.read('input.txt').strip.split("\n").join.split("Blueprint")[1..].map { |l|
  solve(24, l.split(':')[1].scan(/\d+/).map(&:to_i))
}.map.with_index { _1 * (_2 + 1) }.sum

p File.read('input.txt').strip.split("\n").join.split("Blueprint")[1..3].map { |l|
  solve(32, l.split(':')[1].scan(/\d+/).map(&:to_i))
}.inject(:*)
