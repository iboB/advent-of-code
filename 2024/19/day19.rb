@parts, strings =  File.read('input.txt').split("\n\n").then { [_1.split(', '), _2.lines.map(&:strip)] }

def find(reached, path, s)
  reached[path] = @parts.select { s.start_with?(_1) }.map { |part|
    ns = s[part.size..]
    np = path + part
    next 1 if ns.empty?
    next reached[np] if reached[np]
    find(reached, np, ns)
  }.sum
end

puts strings.map { find({}, '', _1) }.select { _1 > 0 }.then { [_1.size, _1.sum] }
