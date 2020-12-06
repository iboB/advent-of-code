groups = File.read('input.txt').split("\n\n").map { |g| g.split("\n").map { |a| a.split(//) } }

p groups.map { |g| g.inject { |s, e| s | e }.length }.sum
p groups.map { |g| g.inject { |s, e| s & e }.length }.sum

