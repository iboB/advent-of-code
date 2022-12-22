require 'matrix'
map, path = File.read('input.txt').split("\n\n")

map.gsub!("\n", ' ')
map = map.lines.map { _1.split(//) }
map[-1] << ' '
map << [' '] * map[0].size

pos = Vector[map[0].index('.'), 0]
dir = 0
Dirs = [Vector[1, 0], Vector[0, 1], Vector[-1, 0], Vector[0, -1]]
Turns = {'R' => 1, 'L' => -1}

path = path.strip.split(/(?=[R|L])/).map { _1.split(/(?<=[R|L])/) }.flatten.map { |i|
  next i if i == ?R || i == ?L
  i.to_i
}

# path.each
3.times do |i|
  p i
  if String === i
    dir += Turns[i]
    dir %= 4
  else
    i.times do
      npos = pos + Dirs[dir]
      while map[npos[1]][npos[0]] == ' '
        npos += Dirs[dir]
        npos[1] %= map.size
        npos[0] %= map[0].size
      end
      break if map[npos[1]][npos[0]] == ?#
      pos = npos
    end
  end
end

p pos
p dir
