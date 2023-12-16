def bturn(c) = c.imag + c.real * 1i # backslash turn

Input = File.readlines('input.txt').map { |l|
  l.strip.chars
}

H = Input.length
W = Input[0].length

def solve(rays)
  level = Input.flat_map.with_index { |l, y|
    l.map.with_index { |c, x|
      [x + 1i*y, [c, 0]]
    }
  }.to_h

  while !rays.empty?
    rays = rays.flat_map { |pos, dir|
      npos = pos + dir
      lev = level[npos]
      next nil if !lev

      elem, energy = lev

      mask = case elem
      when '.' then dir.real.abs + 2 * dir.imag.abs
      when '-', '|' then 3
      when '\\' then dir.real - dir.imag < 0 ? 1 : 2
      when '/' then -(dir.real + dir.imag) < 0 ? 1 : 2
      end

      next nil if energy & mask != 0

      lev[1] |= mask

      case elem
      when '.' then [dir]
      when '-' then dir.real != 0 ? [dir] : [bturn(dir), -bturn(dir)]
      when '|' then dir.imag != 0 ? [dir] : [bturn(dir), -bturn(dir)]
      when '\\' then [bturn(dir)]
      when '/' then [-bturn(dir)]
      end.map { [npos, _1] }
    }.compact
  end

  level.values.select { |elem, energy| energy > 0 }.length
end

# a
p solve [[-1+0i, 1+0i]]

# b
top_down = W.times.map { [_1-1i, 0+1i] }
bottom_up = W.times.map { [_1 + H*1i, 0-1i] }
left_right = H.times.map { [-1 + _1*1i, 1+0i] }
right_left = H.times.map { [W + _1*1i, -1+0i] }

p (top_down + bottom_up + left_right + right_left).map { solve [_1] }.max
