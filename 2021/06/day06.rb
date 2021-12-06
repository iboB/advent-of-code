fish = [0]*9

File.read('input.txt').strip.split(',').map(&:to_i).each do |t|
  fish[t] += 1
end

256.times do |day|
  p fish.sum if day == 80 # a

  nextFish = [0]*9
  nextFish[8] += fish[0]
  nextFish[6] += fish[0]

  (1..8).each do |i|
    nextFish[i-1] += fish[i]
  end

  fish = nextFish
end

# b
p fish.sum
