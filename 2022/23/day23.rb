require 'matrix'
@elves = File.readlines('input.txt').map.with_index { |l, y|
  l.strip.split(//).map.with_index { |c, x|
    Vector[x, y] if c == ?#
  }.compact
}

DN = Vector[0, -1]
DE = Vector[1, 0]
DS = Vector[0, 1]
DW = Vector[-1, 0]

DNE = N + E
DSE = S + E
DSW = S + W
DNW = N + W

def round()
