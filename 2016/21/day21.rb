str = (?a..?h).to_a

input = File.readlines('input.txt').map { |l|
  cmd = l.strip.split
  case cmd[0..1].join(' ')
  when 'swap position'
    p0 = cmd[2].to_i
    p1 = cmd[5].to_i
    str[p0], str[p1] = str[p1], str[p0]
  when 'swap letter'
    p0 = str.index(cmd[2])
    p1 = str.index(cmd[5])
    str[p0], str[p1] = str[p1], str[p0]
  when 'reverse positions'
    p0 = cmd[2].to_i
    p1 = cmd[4].to_i
    str[p0..p1] = str[p0..p1].reverse
  when 'rotate left'
    str = str.rotate(cmd[2].to_i)
  when 'rotate right'
    str = str.rotate(-cmd[2].to_i)
  when 'move position'
    p0 = cmd[2].to_i
    p1 = cmd[5].to_i
    c = str.delete_at(p0)
    str[p1...p1] = c
  when 'rotate based'
    p0 = str.index(cmd[-1])
    str = str.rotate(-(1 + p0 + (p0 >= 4 ? 1 : 0)))
  end
}

puts str.join
