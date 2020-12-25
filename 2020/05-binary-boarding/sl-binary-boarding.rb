File.readlines('input.txt').map { |l|
  eval '0b' + l.strip.gsub(/F|L/, '0').gsub(/B|R/, '1')
}.sort.tap { |s|
  p [s[-1], s.each_cons(2).find { |a,b| b-a==2 }[0]+1]
}
