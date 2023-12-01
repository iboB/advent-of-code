PACKS = File.readlines('input.txt').map(&:to_i)

def solve(q)
  part = PACKS.sum / q
  1.upto(PACKS.length / q) do |i|
    ar = PACKS.combination(i).select { _1.sum == part }
    next if ar.empty?
    return ar.map { _1.inject { |a, b| a * b } }.sort[0]
  end
  nil
end

p solve(3)
p solve(4)

