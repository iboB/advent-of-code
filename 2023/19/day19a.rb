A = true
R = nil

b = binding

p File.read('input.txt').split("\n\n").yield_self { |flows, parts|
  flows.lines.each { |f|
    f =~ /([a-z]+)\{(.+)\}/
    eval "#{$1} = #{$2.gsub(?:, ' ? ').gsub(?,, ' : ').inspect}".gsub('in', 'in0'), b
  }
  parts.lines.map { |part|
    eval part.strip[1..-2].tr(?,, ?;), b
    r = 'in0'
    r = eval r, b while String === r
    r && "xmas".chars.sum { eval _1, b }
  }.compact.sum
}
