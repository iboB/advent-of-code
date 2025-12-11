# keep all paths in real part and dac-fft paths in imaginary part

$graph = File.readlines(?i).map { |l|
  k, v = l.split(?:)
  [k.to_sym, v.strip.split.map(&:to_sym)]
}.to_h

def dfs(node, enc = 0)
  return 1 + (enc == 3 ? 1i : 0i) if node == :out
  enc |= 1 if node == :dac
  enc |= 2 if node == :fft
  key = [node, enc]
  return $memo[key] if $memo[key]
  children = $graph[node]
  return 0i if !children
  $memo[key] = children.sum { dfs _1, enc }
end

$memo = {}

p dfs(:you).real # a
p dfs(:svr).imag # b

