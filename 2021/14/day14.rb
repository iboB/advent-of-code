input = File.read('input.txt').strip.split("\n\n")
Tpl = input[0].split(//)
Rules = input[1].split("\n").map { _1.split(' -> ') }.to_h

def solve(steps)
  spawns = Hash.new(0).merge Tpl.tally

  pairs = Hash.new(0)
  Tpl.each_cons(2) do |a, b|
    pairs[a+b] += 1
  end

  steps.times do
    new_pairs = Hash.new(0)

    pairs.each do |pair, count|
      s = Rules[pair]
      spawns[s] += count
      a, b = pair.split(//)
      new_pairs[a + s] += count
      new_pairs[s + b] += count
    end

    pairs = new_pairs
  end

  qs = spawns.to_a.map { _1[1] }.sort
  qs.last - qs.first
end

#a
p solve 10

#b
p solve 40

