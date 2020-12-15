input = File.readlines('input.txt').map { |l| l.to_i }

f = ->() { input.map! { |i| i/3 - 2 } }

sum = f.().sum
p sum

while !input.empty?
  sum += (f.().select!(&:positive?) || input).sum
end

p sum
