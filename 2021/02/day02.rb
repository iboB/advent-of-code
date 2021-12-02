input = File.readlines('input.txt').map { |l|
  l.split(' ')
}.map { |cmd, val|
  [cmd[0].to_sym, val.to_i]
}

# a
x = 0
d = 0

input.each do |cmd, val|
  case cmd
    when :u then d -= val
    when :d then d += val
    when :f then x += val
  end
end

p x*d

# b
a = 0
x = 0
d = 0

input.each do |cmd, val|
  case cmd
    when :u then a -= val
    when :d then a += val
    when :f
      x += val
      d += a * val
  end
end

p x*d
