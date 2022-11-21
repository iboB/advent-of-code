Input = File.read('input.txt').strip.split(',').map(&:to_i)

def solve(a1, a2)
  ia = Input.dup
  ia[1] = a1
  ia[2] = a2
  i = 0
  while true
    op = ia[i]
    break if op == 99
    a = ia[ia[i+1]]
    b = ia[ia[i+2]]
    ia[ia[i+3]] = op == 1 ? a+b : a*b
    i += 4
  end
  ia[0]
end

# a
p solve(12, 2)

# b
def bf()
  99.times do |noun|
    99.times do |verb|
      return noun*100+verb if solve(noun, verb) == 19690720
    end
  end
end

p bf
