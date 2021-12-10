groups = File.readlines('input.txt').map { |l|
  stack = []
  ret = l.strip.each_char.with_index { |c, i|
    case c
    when '{', '(', '[', '<' then stack << c
    when ')'
      break 3 if stack[-1] != '('
      stack.pop
    when ']'
      break 57 if stack[-1] != '['
      stack.pop
    when '}'
      break 1197 if stack[-1] != '{'
      stack.pop
    when '>'
      break 25137 if stack[-1] != '<'
      stack.pop
    end
  }

  Integer === ret ? ret : stack
}.group_by { Integer === _1 }

# a
p groups[true].sum

# b
sorted = groups[false].map { |seq|
  score = 0
  seq.reverse.each do |c|
    score *= 5
    score += case c
    when '(' then 1
    when '[' then 2
    when '{' then 3
    when '<' then 4
    end
  end
  score
}.sort

p sorted[sorted.length/2]
