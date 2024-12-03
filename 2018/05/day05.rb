input = File.read('input.txt').strip

def react(str)
  build = []
  str.bytes.each do |b|
    if build.last == b ^ 32
      build.pop
    else
      build.push(b)
    end
  end
  build.size
end

# a
p react(input)

# b
p ('a'..'z').map { |c|
  react(input.tr(c + c.upcase, ''))
}.min
