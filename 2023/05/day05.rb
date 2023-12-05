input = File.read('input.txt').split("\n\n")

seeds = input[0].scan(/\d+/).map(&:to_i)

class Array
  def find_range(i)
    self.bsearch { |range, diff|
      next -1 if i < range[0]
      next 1 if i > range[1]
      0
    }
  end
  def smap(i)
    f = find_range(i)
    return i if !f
    return i + f[1]
  end
end

#############
# a

maps = input[1..].map { |block|
  block.lines[1..].map { |l|
    a, b, len = l.scan(/\d+/).map(&:to_i)
    [[b, b+len-1], a-b]
  }.sort_by { |range, diff|
    range[0]
  }
}

p seeds.map { |seed|
  maps.inject(seed) { |elem, map|
    map.smap(elem)
  }
}.min

#############
# b

seed_ranges = seeds.each_slice(2).map { [_1, _1+_2-1] }.sort_by(&:first).map { [_1, true] }

inv_maps = input[1..].reverse.map { |block|
  block.lines[1..].map { |l|
    a, b, len = l.scan(/\d+/).map(&:to_i)
    [[a, a+len-1], b-a]
  }.sort_by { |range, diff|
    range[0]
  }
}

# just brute-force search in inverse maps
# takes 18-ish seconds to reach 6-million
(0..).each do |loc|
  seed = inv_maps.inject(loc) { |elem, map|
    map.smap(elem)
  }
  if seed_ranges.find_range(seed)
    p loc
    break
  end
end
