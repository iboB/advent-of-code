require 'matrix'
require 'set'

class Vector
  def mhd = self.map(&:abs).sum
end

pos = Vector[0, 0]
dir = Vector[1, 0]

vis = Set[pos]
b_done = false

File.read('input.txt').strip.split(/[\s\,]+/).each { |inst|
  t, d = inst[0], inst[1..]
  dir = case t
  when 'R' then Vector[-dir[1], dir[0]]
  when 'L' then Vector[dir[1], -dir[0]]
  end

  pos += d.to_i * dir
}

puts "a: #{pos.mhd}"
