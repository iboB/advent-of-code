input = File.readlines('input.txt').map { |l|
  parts = l.strip.split(/\[|\]/)
  parts << '' if parts.length.odd?
  parts.each_slice(2).to_a.transpose
}

class String
  def abba?() = self =~ /(.)(.)\2\1/ && $1 != $2
  def abas() = self.scan(/(?=(.)(.)\1)/)
end

# a
p input.select { |parts|
  parts[0].any?(&:abba?) && parts[1].none?(&:abba?)
}.length

# b
p input.select { |parts|
  abas = parts[0].map(&:abas).flatten(1).uniq.select { _1 != _2 }
  next false if abas.empty?
  re = Regexp.new abas.map { |a, b| [b,a,b].join }.join('|')
  parts[1].any? { _1 =~ re }
}.length
