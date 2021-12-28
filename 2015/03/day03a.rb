cur = [0, 0]
vis = Hash.new(0)
vis[cur.dup] = 1

File.read('input.txt').split(//).each do |c|
  case c
  when ?< then cur[0] -= 1
  when ?> then cur[0] += 1
  when ?v then cur[1] -= 1
  when ?^ then cur[1] += 1
  end
  vis[cur.dup] += 1
end

p vis.length
