keys = []
locks = []
File.read('input.txt').split("\n\n").each { |group|
  lines = group.lines.map { _1.strip.chars }
  (lines[0].all? { _1 == ?# } ? locks : keys) << lines.transpose.map { _1.count(?#) - 1 }
}
p keys.product(locks).count { |k, l| k.zip(l).all? { _1 + _2 <= 5 } }
