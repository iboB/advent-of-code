require 'matrix'
require 'set'

class Vector
  def mhd = self
end

pos = Vector[0, 0]
dir = Vector[1, 0]

vis = Set.new
b_done = false

File.read('input.txt').strip.split(/[\s\,]+/).each { |inst|
  t, d = inst[0], inst[1..]
  dir = case t
  when 'R' then Vector[-dir[1], dir[0]]
  when 'L' then Vector[dir[1], -dir[0]]
  end

  d.to_i.times do
    pos += dir
    if vis === pos
      p pos.map(&:abs).sum
      exit 0
    end
    vis << pos
  end
}
