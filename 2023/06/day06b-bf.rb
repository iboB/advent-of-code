# just a test for the bf solution for b
# it passes for a reasonable time, indeed - 9 sec on my machine
p File.readlines('input.txt').map { |l|
  l.strip.scan(/\d+/).join.to_i
}.yield_self { |time, record|
    0.upto(time).map { _1 * (time - _1) }.select { _1 > record }.length
}
