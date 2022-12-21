require 'json'
obj = JSON.parse(File.read('input.txt'))

sum = 0

bfs = [obj]
until bfs.empty? do
  cur = bfs.shift
  case cur
  when Array then bfs += cur
  when Integer then sum += cur
  when Hash then bfs += cur.values if !cur.values.include? "red"
  end
end

p sum
