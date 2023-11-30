last_img = File.readlines('input.txt').map { |l|
  l.strip.split(//).map { _1 == ?# }
}

def neighbors_on(img, x, y)
  on = 0
  (y-1..y+1).each do |iy|
    next if iy < 0 || iy >= img.length
    row = img[iy]
    (x-1..x+1).each do |ix|
      next if ix == x && iy == y # don't count self
      next if ix < 0 || ix >= row.length
      on += 1 if row[ix]
    end
  end
  on
end

cur_img = last_img.map(&:dup)

100.times do
  cur_img.length.times do |y|
    cur_row = cur_img[y]
    cur_row.length.times do |x|
      ton = last_img[y][x]
      non = neighbors_on(last_img, x, y)
      cur_row[x] = if ton
        non == 2 || non == 3
      else
        non == 3
      end
    end
  end
  cur_img, last_img = last_img, cur_img
end

p last_img.flatten.count(true)


