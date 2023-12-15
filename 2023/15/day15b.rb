boxen = Array.new(256) { [] }

File.read('input.txt').strip.split(',').each { |str|
  str =~ /([a-z]+)(=|-)(\d+)?/

  label = $1
  ib = label.chars.map(&:ord).inject(0) { ((_1 + _2) * 17) % 256 }
  box = boxen[ib]
  il = box.find_index { _1[:l] == label }

  if $2 == ?-
    box.delete_at(il) if il
  else
    foc = $3.to_i
    if il
      box[il][:f] = foc
    else
      box << {l: label, f: foc}
    end
  end
}

p boxen.map.with_index { |box, ib|
  box.map.with_index { |lens, il|
    (1 + ib) * (1 + il) * lens[:f]
  }.sum
}.sum
