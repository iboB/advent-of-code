nums = File.readlines('input.txt').map(&:to_i)

bad = nums.each_cons(26) { |*g, l|
  break l if !g.combination(2).find { |a, b| a + b == l }
}

p bad

catch :done do
  nums.length.times do |i|
    (i..nums.length).each do |j|
      test = nums[i...j]
      s = test.sum
      next if s < bad
      break if s > bad
      puts test.min + test.max
      throw :done
    end
  end
end
