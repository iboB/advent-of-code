p1, p2 = File.read('input.example').split("\n\n").map { |pl| pl.split("\n")[1..].map(&:to_i) }

until p1.empty? || p2.empty?
  c1 = p1.shift
  c2 = p2.shift
  if c1 > c2
    p1 << c1 << c2
  else
    p2 << c2 << c1
  end
end

winner = p1.empty? ? p2 : p1

p winner.reverse.each_with_index.map { |c, i| c * (i + 1) }.sum
