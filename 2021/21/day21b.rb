# input = [4, 8]
input = [8, 6]

Roll = (3**3).times.to_a.map { _1.to_s(3).ljust(3, '0').split(//).map { |d| d.to_i + 1 }.sum }.tally

def make_move(pdata)
  newdata = Hash.new(0)
  wins = 0
  pdata.each do |ps, pn|
    pos, score = *ps
    Roll.each do |r, rn|
      newpos = pos + r
      newpos -= 10 if newpos > 10
      newscore = score + newpos
      universes = rn * pn
      if newscore >= 21
        wins += universes
      else
        newdata[[newpos, newscore]] += universes
      end
    end
  end
  [newdata, wins]
end

p1, p2 = input.map { {[_1, 0] => 1} }
p1wins = 0
p2wins = 0

while true do
  p1, w1 = make_move(p1)
  p1wins += w1 * p2.values.sum
  p2, w2 = make_move(p2)
  p2wins += w2 * p1.values.sum
  break if p1.empty? && p2.empty?
end

p [p1wins, p2wins]
