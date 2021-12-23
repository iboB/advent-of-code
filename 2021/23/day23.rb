room = File.readlines('input.txt').map { |l|
  l.strip
}[2..3].map { _1.gsub(?#, '').split(//) }.transpose # .map { |c| c.map { 10**(_1.ord - ?A.ord) }}

p room

hw = [nil]*11

4.times do |i|
  hw[(i+1)*2] = [nil] + room[i]
end

p hw
