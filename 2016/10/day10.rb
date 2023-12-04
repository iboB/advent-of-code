players = Hash.new { |h, k|
  h[k] = Hash.new { |h, k|
    h[k] = {c: []}
  }
}

File.readlines('input.txt').each do |l|
  if l =~ /value (\d+) goes to bot (\d+)/
    players['bot'][$2.to_i][:c] << $1.to_i
  elsif l =~ /bot (\d+) gives low to (output|bot) (\d+) and high to (output|bot) (\d+)/
    players['bot'][$1.to_i][:g] = [players[$2][$3.to_i], players[$4][$5.to_i]]
  end
end

bots = players['bot']
outs = players['output']

Q = [17, 61]

while true
  fbots = {}
  bots.each do |id, bot|
    next if bot[:c].length < 2
    fbots[id] = bot
  end
  break if fbots.empty?
  fbots.keys.each { bots.delete(_1) }
  fbots.each do |id, bot|
    chip = bot[:c].sort
    if (chip == Q)
      # a
      p id
    end
    bot[:g][0][:c] << chip[0]
    bot[:g][1][:c] << chip[1]
  end
end

# b
p (0..2).map { outs[_1][:c].first }.inject(:*)

