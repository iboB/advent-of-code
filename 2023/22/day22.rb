require 'set'
brick_boxes = File.readlines('input.txt').map { |l|
  nums = l.strip.scan(/\d+/).map(&:to_i)
  nums[..2].zip(nums[3..]).map { _1.._2 }
}.sort_by {
  _1[2].min
}

def simulate(boxes, skip_i = nil)
  bricks = boxes.map { {box: _1, on: Set.new, holds: Set.new} }

  tops = Hash.new { |h, k| h[k] = {h: 0, b: -1} }

  bricks.each.with_index do |brick, i|
    xs, ys = brick[:box][..1]
    proj = xs.flat_map { |x| ys.map { |y| tops[[x, y]] } }

    top = proj.group_by { _1[:h] }
    top_h = top.keys.max

    brick[:at] = top_h
    next if skip_i == i

    top[top_h].each { |t|
      brick[:on] << t[:b]
      bricks[t[:b]][:holds] << i if t[:b] != -1
    }

    brick_height = brick[:box][2].size

    proj.each { |t|
      t[:h] = top_h + brick_height
      t[:b] = i
    }
  end

  bricks
end

bricks = simulate(brick_boxes)

bricks_on = bricks.map { _1[:on] }
support_one = bricks_on.select { _1.size == 1 }.inject(Set.new, &:+)
support_more = bricks_on.select { _1.size > 1 }.inject(Set.new, &:+)

removable = support_more - support_one

# a
p removable.length + bricks.select { _1[:holds].empty? }.length

# b
# bf:
# for every brick whose removal *would* cause others to fall simulate and cound
# bricks at different positions
non_removable = Set.new(bricks.size.times.to_a) - removable

p non_removable.map { |skip_i|
  bricks_without = simulate(brick_boxes, skip_i)
  bricks.zip(bricks_without).count { _1[:at] > _2[:at] }
}.sum
