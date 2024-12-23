@es = File.readlines('input.txt').map { |l| l.strip.split(?-) }.then { _1 + _1.map(&:reverse) }.to_set
@ns = @es.to_a.flatten.sort.uniq
def max_clique(cliq = []) = @ns[(@ns.index(cliq.last) || -1) + 1..].map { |n| max_clique(cliq + [n]) if cliq.all? { @es === [_1, n] } }.compact.max_by(&:size) || cliq
puts max_clique.join(?,)
