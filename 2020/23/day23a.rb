input = '368195742'.split(//).map(&:to_i)
N = input.max

move = ->() {
  cc = input.shift
  input << cc
  mc = input.shift(3)

  n = cc - 1
  i = nil
  while true
    n = N if n == 0
    i = input.index(n)
    break if i
    n -= 1
  end

  input[i+1,0] = mc
}

100.times { move.() }

front = input.shift(input.index(1))
input += front
puts input[1..].join
