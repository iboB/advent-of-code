graph = Hash.new { |h, k| h[k] = {in: [], out: []} }

input = File.readlines('input.txt').map { |l|
  l =~ /Step (\w) must be finished before step (\w) can begin./
  graph[$1][:out] << $2
  graph[$2][:in] << $1
}

# basic topological sort

order = []
bfs = graph.select { |k, v| v[:in].empty? }.map(&:first)

loop do
  bfs.sort!
  step = bfs.shift
  order << step
  graph[step][:out].each do |s|
    graph[s][:in].delete(step)
    bfs << s if graph[s][:in].empty?
  end
  break if bfs.empty?
end

p order.join
