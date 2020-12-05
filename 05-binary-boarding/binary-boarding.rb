seats = File.readlines('input.txt').map { |l| eval '0b' + l.strip.gsub(/F|L/, '0').gsub(/B|R/, '1') }
p seats.max
p 1 + seats.sort.each_cons(2).map { |a, b| [a, b-a] }.find { |p| p[1] == 2 }[0]
