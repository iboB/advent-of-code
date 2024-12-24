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

base = calc(init, prog)
z = num(base, ?z)
p z # a

### then b was solved mostly on pen and paper with experiments with
### "adding" differrent numbers and finding the mistakes

x = num(base, ?x)
y = num(base, ?y)

zs = base.keys.select { _1[0] == ?z }.sort

target_z = x + y
bad = (z ^ target_z).to_s(2).chars.map.with_index { |c, i| c == ?1 ? zs[i] : nil }.compact
good = zs - bad


def set_xy(x, y)
  xs, ys = 100.times.map { |i|
    x, xb = x.divmod(2)
    y, yb = y.divmod(2)
    is = "%02d" % i
    [[is, xb], [is, yb]]
  }.transpose
  xs.map { [?x + _1, _2] } + ys.map { [?y + _1, _2] }
end

a = calc(set_xy(2**3, 2**2).to_h, prog)
p num(a, ?z)

exit

prog = prog.map { |x, op, y, z| [z, [op, x, y]] }.to_h

def find_deps(prog, keys)
  deps = keys.to_set
  dfs = keys.dup
  until dfs.empty?
    k = dfs.pop
    op, x, y = prog[k]

    if !deps.include?(x) && prog[x]
      dfs << x
      deps << x
    end

    if !deps.include?(y) && prog[y]
      dfs << y
      deps << y
    end
  end
  deps
end

good_deps = find_deps(prog, good)

p bad
p bad.map { find_deps(prog, [_1]) }[..2]
