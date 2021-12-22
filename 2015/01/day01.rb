input = File.read('input.txt').strip.split(//).map { _1 == '(' ? 1 : -1 }

# a
p input.sum

part = []
input.inject { |s, n|
  part << s
  n + s
}

p part.index { _1 < 0 } + 1


