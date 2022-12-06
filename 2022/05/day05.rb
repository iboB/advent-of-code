icrates, moves = File.read('input.txt').split("\n\n")

# relies on trailing spaces for input until longest column!
crates_a = icrates.lines.reverse.drop(1).map { |line|
  1.step(line.length, 4).map { line[_1] }
}.transpose.map { |crate|
  crate.filter { _1 != ' '}
}

crates_b = Marshal.load Marshal.dump crates_a

moves.lines.each do |l|
  n, from, to = l.scan(/\d+/).map(&:to_i)
  from -= 1
  to -= 1

  n.times do
    crates_a[to] << crates_a[from].pop
  end

  crates_b[to] += crates_b[from].pop(n)
end

p crates_a.map(&:last).join
p crates_b.map(&:last).join
