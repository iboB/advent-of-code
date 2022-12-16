@graph = {}

def get_or_add_node(name, rate = nil)
  node = @graph[name]
  if !node
    node = {rate: rate, links: {}}
    @graph[name] = node
  elsif rate
    node[:rate] = rate
  end
  node
end

File.readlines('input.txt').each { |line|
  line =~ /Valve ([A-Z]+) has flow rate=(\d+); tunnel(s?) lead(s?) to valve(s?) (.+)/
  name = $1
  rate = $2.to_i
  links = $6.split(', ')

  node = get_or_add_node(name, rate)
  links.each do |l|
    node[:links][l] = 1
    get_or_add_node(l)[:links][name] = 1
  end
}

# create no-open edges
def find_best_path(from, to)
  best = Hash.new(30)
  best[from] = 0
  bfs = [from]
  while !bfs.empty?
    cur = bfs.shift
    len = best[cur] + 1
    @graph[cur][:links].each do |name, w|
      next if best[name] <= len
      return len if name == to
      bfs << name
      best[name] = len
    end
  end
end

k = @graph.keys
k.combination(2).map { |a, b|
  [a, b, find_best_path(a, b)]
}.each do |a, b, w|
  @graph[a][:links][b] = w
  @graph[b][:links][a] = w
end

start = @graph['AA'][:links]

# elliminate zero-rate edges
obsolete = []
@graph.each do |name, node|
  next if node[:rate] != 0
  obsolete << name
  node[:links].to_a.combination(2) do |a, b|
    name_a = a[0]
    links_a = @graph[name_a][:links]
    name_b = b[0]
    links_b = @graph[name_b][:links]

    weight = a[1] + b[1]

    ab = links_a[name_b]
    next if ab && ab < weight # a better path exists, so ignore this one

    links_a[name_b] = weight
    links_b[name_a] = weight
  end
end

obsolete.each do |name|
  @graph.delete(name)
  start.delete(name)
end

@graph.each do |name, node|
  obsolete.each do |name|
    node[:links].delete(name)
  end
end

# p start
# p @graph

# brute force find all paths with weight <= @time and put into @found
def find_all(path, w, cur, rest)
  rec = 0
  rest.each_with_index do |nex, i|
    nw = w + cur[nex] + 1
    next if nw > @time
    rec += 1
    nrest = rest.dup
    nrest.delete_at(i)
    find_all(path + [[nex, nw]], nw, @graph[nex][:links], nrest)
  end
  return if rec != 0

  @found << [
    path,
    path.map { (@time - _1[1] + 1) * @graph[_1[0]][:rate] }.sum
  ]
end

# a
@found = []
@time = 30
find_all([], 1, start, @graph.keys)
p @found.map(&:last).max

# b
# here we make use of a fact which is not true for the example input:
# From the found paths of the real puzzle input, no path exceeds 8 (of 15 nodes).
# This means that if we collect all paths, both ours and the elephants will
# be present. And they will be disjoint.
# So:

# find all paths until min 26
@found = []
@time = 26
find_all([], 1, start, @graph.keys)

# create an integer denoting each path's nodes
# sort by value and remove duplicates
rank = @graph.keys.map.with_index { |k, i| [k, 1 << i] }.to_h
ranked = @found.map { |path, val|
  [path.inject(0) { |s, e| s | rank[e[0]] }, path, val]
}.sort_by(&:last).reverse.uniq(&:first)

# for each pair, if disjoint, add to list and find max by total throughput
p ranked.combination(2).map { |a, b|
  if a[0] & b[0] != 0
    nil
  else
    [a[-1] + b[-1], a[1], b[1]]
  end
}.compact.max_by(&:first).first
