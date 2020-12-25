foods = File.readlines('input.txt').map { |line|
  line.split('contains').map { |part| part.scan(/\w+/) }
}

products = foods.map { |f| f[0] }.flatten.uniq

a_maybes = Hash.new(products)

foods.each do |f|
  f[1].each do |a|
    a_maybes[a] &= f[0]
  end
end

allergens = {}
while !a_maybes.empty?
  a_maybes.find { |k, v| v.length == 1 }.tap { |a, i|
    i = i[0]
    allergens[a] = i
    a_maybes.delete(a)
    a_maybes.each { |_, is| is.delete(i) }
  }
end

# a
p foods.map { |food| (food[0] - allergens.values).length }.sum

# b
p allergens.to_a.sort { |a, b| a[0] <=> b[0] }.map { |_, i| i }.join(',')
