*n, o = File.readlines(?i)
p n.map(&:split).transpose.zip(o.split).sum{eval _1.join(_2)}
p n.map(&:chars).transpose.map{_1.join.to_i}.slice_when{_1==0}.zip(o.split).sum{eval _1[..-2].join(_2)}
