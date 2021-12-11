input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map(&:to_i)
}

W = H = 10

def ns(x, y)
  ret = []
  ret << [y-1, x] if y > 0
  ret << [y+1, x] if y < H-1
  ret << [y, x-1] if x > 0
  ret << [y, x+1] if x < W-1
  ret << [y-1, x-1] if y > 0 && x > 0
  ret << [y-1, x+1] if y > 0 && x < W-1
  ret << [y+1, x-1] if y < H-1 && x > 0
  ret << [y+1, x+1] if y < H-1 && x < W-1
  ret
end

flashes_till_step_100 = 0
step_with_100_flashes = nil
step = 0
while true do
  # puts i
  # puts input.map { _1.join }

  input.each do |row|
    row.map! { |n| n+1 }
  end

  local = 0
  while true do
    flashed = false
    H.times do |y|
      W.times do |x|
        if input[y][x] >= 10
          flashed = true
          flashes_till_step_100 += 1 if step < 100
          local += 1
          input[y][x] = 0
          ns(x, y).each do |ny, nx|
            input[ny][nx] += 1 if input[ny][nx] > 0
          end
        end
      end
    end
    break if !flashed
  end

  step += 1

  step_with_100_flashes = step if local == 100


  break if step >= 100 && step_with_100_flashes
end

# a
p flashes_till_step_100

# b
p step_with_100_flashes
