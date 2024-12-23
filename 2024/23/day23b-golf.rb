N,E=File.readlines('input.txt').map{_1.strip.split(?-)}.then{[_1.flatten.sort.uniq,(_1+_1.map(&:reverse)).to_set]}
def mc(c=[])=N[(N.index(c[-1])||-1)+1..].map{|n|mc(c+[n])if c.all?{E===[_1,n]}}.compact.max_by(&:size)||c
puts mc*?,
