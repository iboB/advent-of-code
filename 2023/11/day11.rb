gal = []

col_pad = nil
row_pad = []
input = File.readlines('input.txt').each.with_index { |l, y|
  l.strip!
  col_pad = [0] * l.length if !col_pad

  row_gal = l.chars.map.with_index { |c, x|
    if c == ?#
      col_pad[x] += 1
      x + y * 1i
    end
  }.compact
  row_pad << row_gal.length
  gal += row_gal
}

s = 0
row_pad.map! { _1 == 0 ? s += 2-1 : s}
s = 0
col_pad.map! { _1 == 0 ? s += 2-1 : s}

p gal.map {
  _1 + col[_1.real] + row[_1.imag] * 1i
}.combination(2).map { |a, b|
  (a.real - b.real).abs + (a.imag - b.imag).abs
}.sum
