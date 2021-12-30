def look_and_say(ar)
  res = []
  cur = nil
  ar.each do |e|
    if e == cur
      res[-2] += 1
    else
      cur = e
      res << 1
      res << cur
    end
  end
  res
end

i = '1113222113'.split(//).map(&:to_i)

40.times { i = look_and_say i }

# a
p i.length

10.times { i = look_and_say i }

# b
p i.length
