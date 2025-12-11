$graph = File.readlines(?i).map { _1.scan(/\w+/).map(&:to_sym).then { |k, *v| [k, v] } }.to_h
def dfs(memo, node, tgt)
  return memo[node] if memo[node]
  return 1 if node == tgt
  memo[node] = ($graph[node]||[]).sum { dfs memo, _1, tgt }
end
puts [[:you, :out], [:svr, :fft, :dac, :out]].map {
  _1.each_cons(2).reverse_each.inject({}) { |m, (n, t)| {n => dfs(m, n, t)} }.values[0]
}
