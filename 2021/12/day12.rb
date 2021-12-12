graph = {}

File.readlines('input.txt').map { |l|
  l.strip.split('-')
}.each do |a, b|
  graph[a] = [] if !graph[a]
  graph[b] = [] if !graph[b]
  graph[a] << b
  graph[b] << a
end

G = graph

def solve(node, visited, v2)
  if node == node.downcase
    if node == 'end'
      $paths += 1
      return
    end

    if !visited[node]
      visited[node] = true
    else
      return if v2
      v2 = node
    end
  end

  G[node].each do |n|
    next if n == 'start'
    solve(n, visited, v2)
  end

  if v2 == node
    v2 = nil
  else
    visited.delete(node)
  end
end

# a
$paths = 0
solve('start', {}, 'NOPE')
p $paths

# b
$paths = 0
solve('start', {}, nil)
p $paths
