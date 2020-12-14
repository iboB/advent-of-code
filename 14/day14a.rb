mask_or = 0
mask_and = 0
mem = {}

File.readlines('input.example').each do |l|
  if l =~ /^mask = (.+)$/
    mask_or = 0
    mask_and = 0
    $1.strip.split(//).each { |sym|
      mask_or *= 2
      mask_and *= 2
      if sym == '1'
        mask_or += 1
        mask_and += 1
      elsif sym == 'X'
        mask_and += 1
      end
    }
  elsif l =~ /^mem\[(\d+)\] = (\d+)$/
    mem[$1.to_i] = ($2.to_i & mask_and) | mask_or
  else
    raise l
  end
end

p mem.values.sum
