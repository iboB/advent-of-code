rs, ids = File.read(?i).strip.split("\n\n").then {[
  _1.lines.map{|l| l.split(?-).map(&:to_i)},
  _2.lines.map(&:to_i)
]}

# a
p ids.select { |i| rs.any? { (_1.._2) === i } }.size

d = 0
p rs.flat_map{[[_1,1],[_2+1,-1]]}.sort.select{[d,d+=_2].sort==[0,1]}.each_slice(2).map{_2[0]-_1[0]}.sum
