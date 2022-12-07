stack = []
sizes = Hash.new(0)

File.readlines('input.txt').map { |l|
  args = l.strip.split(' ')
  if args[0] == '$'
    if args[1] == 'cd'
      if args[2] == '/'
        stack = []
      elsif args[2] == '..'
        stack.pop
      else
        stack << args[2]
      end
    end
  elsif args[0] != 'dir'
    s = args[0].to_i
    path = '/'
    stack.each do |d|
      sizes[path] += s
      path += "/#{d}"
    end
    sizes[path] += s
  end
}

# a
p sizes.values.select { _1 < 100_000 }.sum

# b
req = 30_000_000 - (70_000_000 - sizes['/'])
p sizes.values.select { _1 >= req }.min
