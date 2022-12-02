input = File.readlines('input.txt').map { |l|
  l.strip.split(' ').map {
    case _1
      when ?A, ?X then 0
      when ?B, ?Y then 1
      when ?C, ?Z then 2
    end
  }
}

# a
p input.map { |m|
  m[1] + 1 + if m[0] == m[1]
    3
  elsif (m[0] + 1) % 3 == m[1]
    6
  else
    0
  end
}.sum

# b
p input.map { |m|
  m[1] * 3 + 1 + case m[1]
  when 0 then (m[0] + 2) % 3
  when 1 then m[0]
  when 2 then (m[0] + 1) % 3
  end
}.sum

