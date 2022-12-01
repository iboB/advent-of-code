input = File.read('input.txt').strip.split("\n\n").map { _1.lines.map(&:to_i).sum }.sort

p input[-1] # a
p input[-3..-1].sum # b

