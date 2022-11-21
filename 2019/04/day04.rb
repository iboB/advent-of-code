a = 236491.upto(713787).select {
  |n| n.to_s.split(//).each_cons(2).all? { |a, b| a<=b }
}.select {
  |n| n.to_s.split(//).each_cons(2).any? { |a, b| a==b }
}

# a
p a.length

# b
p a.select {
  |n| n.to_s.split(//).chunk(&:itself).any? { |c| c[1].length == 2 }
}.length
