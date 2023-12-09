p File.readlines('input.txt').map { |l|
  history = l.strip.split.map(&:to_i)
  pyr = [history]
  pyr << pyr[-1].each_cons(2).map { _2 - _1 } until pyr[-1].all? { _1 == 0}
  pyr.reverse.inject { |sum, ar|
    [ar[0] - sum[0], ar[-1] + sum[-1]]
  }
}.transpose.map(&:sum)
