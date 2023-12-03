input = File.readlines('input.txt').map(&:strip).join

def d_len(input, deep)
  output_len = 0
  while true
    if input =~ /\((\d+)x(\d+)\)/
      l, t = [$1, $2].map(&:to_i)
      o = $~.offset(0)
      output_len += input[...o[0]].length
      input = input[o[1]..]
      part = input[...l]
      if deep
        part_len = d_len(part, true)
      else
        part_len = part.length
      end
      output_len += part_len * t
      input = input[l..]
    else
      output_len += input.length
      break
    end
  end
  output_len
end

p d_len(input, false)
p d_len(input, true)
