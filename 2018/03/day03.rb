fabric = Hash.new { |h, k| h[k] = [] }

maxi = 0
File.readlines('input.txt').each { |l|
  i, x, y, w, h = l.scan(/\d+/).map(&:to_i)
  (x...x+w).each { |cx|
    (y...y+h).each { |cy|
      fabric[cx + 1i * cy] << i
    }
  }
  maxi = i
}

vals = fabric.values

# a
p vals.count { _1.size > 1 }

# b (brute force)
p (1..maxi).select { |i|
  vals.all? {
    _1 == [i] || !_1.include?(i)
  }
}
