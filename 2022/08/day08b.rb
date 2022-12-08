Input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map(&:to_i)
}

# just do cubic

H = Input.length - 1
W = Input[0].length - 1

max_ss = 0

(1...H).each do |y|
  (1...W).each do |x|
    h = Input[y][x]

    ss = 1

    tmp = 0
    (x+1).upto(W) do |xi|
      tmp += 1
      other = Input[y][xi]
      break if other >= h
    end
    ss *= tmp

    tmp = 0
    (x-1).downto(0) do |xi|
      tmp += 1
      other = Input[y][xi]
      break if other >= h
    end
    ss *= tmp

    tmp = 0
    (y+1).upto(H) do |yi|
      tmp += 1
      other = Input[yi][x]
      break if other >= h
    end
    ss *= tmp

    tmp = 0
    (y-1).downto(0) do |yi|
      tmp += 1
      other = Input[yi][x]
      break if other >= h
    end
    ss *= tmp

    max_ss = ss if ss > max_ss
  end
end

p max_ss
