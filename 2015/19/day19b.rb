require 'set'

STR = File.readlines('input.txt').map(&:strip)[-1]

class String
  def scan_len(m) = self.scan(m).length
end

# not my idea:
# https://www.reddit.com/r/adventofcode/comments/3xflz8/comment/cy4etju
p STR.scan_len(/[A-Z]/) - 2 * STR.scan_len('Rn') - 2 * STR.scan_len('Y') - 1

