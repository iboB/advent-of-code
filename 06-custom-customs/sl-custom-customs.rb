File.read('input.txt').split("\n\n").map { |g|
  g.split("\n").map { |a| a.split(//) }
}.tap { |groups|
  p groups.map { |g|
    [g.inject { |s, e| s | e }.length, g.inject { |s, e| s & e }.length]
  }.transpose.map(&:sum)
}


