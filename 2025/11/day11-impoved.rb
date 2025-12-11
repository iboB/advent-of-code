# improved: not faster, but cleaner (b directly reuses code for a)
$graph = File.readlines(?i).map { |l|
  k, v = l.split(?:)
  [k.to_sym, v.strip.split.map(&:to_sym)]
}.to_h

def dfs(node, tgt)
  return 1 if node == tgt
  return $memo[node] if $memo[node]
  children = $graph[node]
  return 0 if !children
  $memo[node] = children.sum { dfs _1, tgt }
end

def solve(node, tgt)
  $memo = {}
  dfs(node, tgt)
end

p solve(:you, :out)

# b
# the key insight is that there can't be any other paths through
# for example if dac -> fft existed, there would be a cycle
p solve(:svr, :fft) * solve(:fft, :dac) * solve(:dac, :out)
