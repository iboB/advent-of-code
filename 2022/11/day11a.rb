input = File.read('input.txt').strip.split("\n\n").map { |monkey|
  s, op, t, tt, tf = monkey.split("\n")[1..]
  {
    items: s.scan(/\d+/).map(&:to_i),
    op: op.split(':')[1].strip.gsub(/new|old/, 'val'),
    div: t.split(/ /).last.to_i,
    on: {
      true => tt.split(/ /).last.to_i,
      false => tf.split(/ /).last.to_i,
    },
    num: 0
  }
}

20.times do
  input.each do |m|
    items = m[:items]
    m[:num] += items.length
    m[:items] = []
    items.each do |val|
      eval(m[:op])
      val = val / 3
      input[m[:on][val % m[:div] == 0]][:items] << val
    end
  end
end

p input.map { _1[:num] }.sort.reverse.take(2).inject(:*)
