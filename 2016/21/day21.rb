str = (?a..?h).to_a

input = File.readlines('input.txt').map(&:strip).map(&:split)

input.map { |cmd|
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
    p0 += 1 if p0 >= 4
    p0 += 1
    str = str.rotate(-p0)
  end
}

puts str.join

str = 'fbgdceah'.chars

inv_rotate_based = [1, 1, 6, 2, 7, 3, 0, 4] # manually calculated by
#
# class String
#   def rot(n) = chars.rotate(n).join
# end
# s = (?a..?h).to_a.join
# inv_based = [1, 1, 6, 2, 7, 3, 0, 4]
# puts s.length.times.map { |n|
#   a = s.rot(-n)
#   n += 1 if n >= 4
#   n += 1
#   r = a.rot(-n)
#   rr = r.rot(inv_based[r.index(?a)])
#   "#{a}->#{r}->#{rr} #{a == rr ? "- ok" : ""}"
# }

input.reverse.map { |cmd|
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
    str = str.rotate(-cmd[2].to_i)
  when 'rotate right'
    str = str.rotate(cmd[2].to_i)
  when 'move position'
    p0 = cmd[5].to_i
    p1 = cmd[2].to_i
    c = str.delete_at(p0)
    str[p1...p1] = c
  when 'rotate based'
    p0 = str.index(cmd[-1])
    str = str.rotate(inv_rotate_based[p0])
  end
}

puts str.join
