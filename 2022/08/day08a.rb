input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map { [_1.to_i, 0] }
}

work = [input, input.map(&:reverse), input.transpose, input.transpose.map(&:reverse)]

work.each do |grid|
  grid.each do |ar|
    max = -1
    ar.each do |tree|
      h = tree[0]
      tree[1] += 1 if h <= max
      max = h if max < h
    end
  end
end

p input.flatten(1).map(&:last).select { _1 != 4 }.count
