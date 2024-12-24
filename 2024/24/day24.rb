def calc(init, prog)
  done, prog = init.dup, prog.dup
  until prog.empty?
    c, prog = prog.partition { done[_1] && done[_3] }
    c.each { |x, op, y, z|
      done[z] = case op
      when 'AND' then done[x] & done[y]
      when 'OR'  then done[x] | done[y]
      when 'XOR' then done[x] ^ done[y]
      end
    }
  end
  done
end

def num(done, c) = done.select { _1[0] == c }.to_a.sort_by(&:first).map(&:last).reverse.join.to_i(2)

init, prog = File.read('input.txt').split("\n\n").then { |init, prog|
  init = init.lines.map {
    a, i = _1.split(': ')
    [a, i.to_i]
  }.to_h

  prog = prog.lines.map { _1.scan(/\w+/) }

  [init, prog]
}

p num(calc(init, prog), ?z)

# x =  num('x')
# y =  num('y')
# p [x, y]
# p (x).to_s(2)
# p (y).to_s(2)
# p (x+y).to_s(2)
# p num('z').to_s(2)

# p '     ' + (num('z')^(x+y)).to_s(2)

# (num('z')^(x+y)).to_s(2).chars.count(?1).display
