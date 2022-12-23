deer = File.readlines('input.txt').map { |l|
  s = l.split(' ')
  [s[0], s[3].to_i, s[6].to_i, s[-2].to_i]
}
