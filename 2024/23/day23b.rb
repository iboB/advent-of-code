@edges = File.readlines('input.txt').map { |l|
  l.strip.split(?-)
}.then {
  @nodes = _1.flatten.sort.uniq
  _1 + _1.map(&:reverse)
}.to_set

def max_clique(cliq)
  @nodes[@nodes.index(cliq.last) + 1..].select { |n|
    cliq.all? { @edges === [_1, n] }
  }.map { |n|
    max_clique(cliq + [n])
  }.max_by(&:size) || cliq
end

puts @nodes.map { max_clique [_1] }.max_by(&:size).join(?,)
