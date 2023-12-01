valid = File.readlines('input.txt').map { |l|
  l =~ /([a-z\-]+)-(\d+)\[([a-z]+)\]/
  name, sec, expected = [$1, $2.to_i, $3]
  checksum = name.gsub('-', '').split(//).tally.to_a.map { |c, n|
    [-n, c]
  }.sort.map(&:last)[..4].join
  expected == checksum ? [name, sec] : nil
}.compact

# a
p valid.map(&:last).sum

# b
class String
  def caesar(offset)
    self.each_byte.map { |b|
      next ' ' if b == 32
      ((b + offset - ?a.ord) % 26 + ?a.ord).chr
    }.join
  end
end

valid.each { |name, sec|
  dec = name.gsub('-', ' ').caesar(sec)
  p [dec, sec] if dec =~ /north/
}
