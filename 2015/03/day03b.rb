cur = [[0, 0], [0, 0]]
vis = Hash.new(0)
vis[[0, 0]] = 1
ci = 0

File.read('input.txt').split(//).each do |c|
  case c
  when ?< then cur[ci][0] -= 1
  when ?> then cur[ci][0] += 1
  when ?v then cur[ci][1] -= 1
  when ?^ then cur[ci][1] += 1
  end
  vis[cur[ci].dup] += 1
  ci ^= 1
end

p vis.length
