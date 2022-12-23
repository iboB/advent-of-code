Props = File.readlines('input.txt').map { |l|
  l.scan(/-?\d+/).map(&:to_i)
}

@best = 0
@best500 = 0

def solve(buf, rem, i)
  return if rem == 0
  if i == Props.size - 1
    # record
    buf << Props[-1].map { _1 * rem }
    reduced = buf.inject { |as, bs| as.zip(bs).map { |a, b| a + b } }.map { _1 < 0 ? 0 : _1 }
    q = reduced[0..-2].inject(:*)
    @best = q if q > @best
    @best500 = q if q > @best500 && reduced[-1] == 500
  else
    1.upto(rem) do |q|
      solve(buf.dup << Props[i].map { _1 * q }, rem - q, i + 1)
    end
  end
end

solve([], 100, 0)

p @best
p @best500

