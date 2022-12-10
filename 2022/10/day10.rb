cx = 1
cyc = [cx]

File.readlines('input.txt').map { |l|
  cyc << cx
  if l =~ /x (-?\d+)/
    cyc << cx
    cx += $1.to_i
  end
}

# a
p 20.step(220, 40).map { |i|
  cyc[i] * i
}.sum

# b
cyc.shift
puts 240.times.map { |i|
  val = cyc[i]
  x = i % 40 # fuck... this '%40' took me 20 minutes to figure out :)
  next '#' if val >= x-1 && val <= x+1
  ' '
}.each_slice(40).map { _1.join }.join("\n")
