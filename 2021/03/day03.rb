input = File.readlines('input.txt').map { |l|
  l.strip.split(//).map(&:to_i)
}

len = input[0].length

class FalseClass; def to_i; 0 end end
class TrueClass; def to_i; 1 end end

# a
full = ([1]*len).join.to_i(2) # so we xor with this to find the complement in the appropriate width
half = input.length / 2
gamma = input.inject { |n, s| n.zip(s).map { |a, b| a + b } }.map { |s| (s > half).to_i }.join.to_i(2)

p gamma * (gamma ^ full)

# b
oxy = input.dup
co2 = input.dup
len.times do |bit|
  most_least = -> (ar) {
    s = ar.map { |n| n[bit] }.sum
    most = (s >= ar.length.to_f / 2)
    least = !most
    [most.to_i, least.to_i]
  }
  if oxy.length > 1
    most, _ = most_least.(oxy)
    oxy.select! { |n| n[bit] == most }
  end
  if co2.length > 1
    _, least = most_least.(co2)
    co2.select! { |n| n[bit] == least }
  end
end

p oxy.join.to_i(2) * co2.join.to_i(2)