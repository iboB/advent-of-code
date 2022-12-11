input = File.read('input.txt').strip.split("\n\n").map { |monkey|
  s, op, t, tt, tf = monkey.split("\n")[1..]
  {
    items: s.scan(/\d+/).map(&:to_i),
    op: op.split(':')[1].strip.gsub(/new|old/, 'val'),
    div: t.split(/ /).last.to_i,
    on_true: tt.split(/ /).last.to_i,
    on_false: tf.split(/ /).last.to_i,
    num: 0
  }
}

20.times do
  input.each do |m|
    items = m[:items]
    m[:items] = []
    items.each do |val|
      m[:num] += 1
      eval(m[:op])
      val = val / 3
      if val % m[:div] == 0
        input[m[:on_true]][:items] << val
      else
        input[m[:on_false]][:items] << val
      end
    end
  end
end

p input.map { _1[:num] }.sort.reverse.take(2).inject(:*)
