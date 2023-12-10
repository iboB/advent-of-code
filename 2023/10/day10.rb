level = File.readlines('input.txt').map { _1.strip.chars }

start_pos = nil

links = level.flat_map.with_index { |row, y|
  row.map.with_index { |c, x|
    cur_pos = x + y * 1i

    dirs = case c
    when ?| then [1i, -1i]
    when ?- then [1, -1]
    when ?L then [1, -1i]
    when ?J then [-1, -1i]
    when ?7 then [-1, 1i]
    when ?F then [1, 1i]
    when ?S
      start_pos = cur_pos
      nil
    end

    next nil if !dirs
    [cur_pos, dirs]
  }.compact
}.to_h

def find_path(links, start_pos, start_dir)
  path = [start_dir]
  pos = start_pos
  while true
    dir = path[-1]
    pos += path[-1]
    return path if pos == start_pos

    next_dir = links[pos]
    return false if !next_dir # dead end
    next_dir.select! { _1 != -dir }
    return false if next_dir.length != 1
    path << next_dir[0]
  end
end

path = nil
[1, -1, 1i, -1i].each do |dir|
  path = find_path(links, start_pos, dir)
  break if path
end

p path.length / 2

# b
pos = start_pos
path.each do |dir|
  a = pos
  b = pos += dir
  if dir.imag != 0
    # vertical
    level[a.imag][a.real] = dir.imag
    level[b.imag][b.real] = dir.imag
  else
    # horizontal
    level[a.imag][a.real] = 0 if !(Integer === level[a.imag][a.real])
  end
end

# puts level.map(&:inspect)

p level.map { |row|
  first = nil
  count = false
  sum = 0
  row.each do |e|
    if Integer === e
      if !first
        first = e
        count = true
      else
        count = first == e
      end
    else
      sum += 1 if count
    end
  end
  sum
}.sum
