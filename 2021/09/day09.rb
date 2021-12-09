input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map(&:to_i)
}

w = input[0].length
h = input.length

res = []

h.times do |y|
  w.times do |x|
    ns = []
    ns << input[y-1][x] if y > 0
    ns << input[y+1][x] if y < h-1
    ns << input[y][x-1] if x > 0
    ns << input[y][x+1] if x < w-1
    val = input[y][x]
    res << val if ns.all? { _1 > val }
  end
end

p res.sum + res.length
