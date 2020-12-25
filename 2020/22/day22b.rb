def play(p1, p2)
  record = {}
  until p1.empty? || p2.empty?
    entry = [p1, p2].map { |p| p.join(',') }.join(' ')
    return 1 if record[entry]
    record[entry] = true

    c1 = p1.shift
    c2 = p2.shift

    rw =
      if (c1 > p1.length || c2 > p2.length)
        c1 > c2 ? 1 : 2
      else
        play(p1[0...c1], p2[0...c2])
      end

    if rw == 1
      p1 << c1 << c2
    else
      p2 << c2 << c1
    end
  end

  p1.empty? ? 2 : 1
end

def winner(p1, p2)
  play(p1, p2) == 1 ? p1 : p2
end

p1, p2 = File.read('input.txt').split("\n\n").map { |pl| pl.split("\n")[1..].map(&:to_i) }

w = winner(p1, p2)
p w.reverse.each_with_index.map { |c, i| c * (i + 1) }.sum
