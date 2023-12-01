require 'matrix'

DIRS = {
  U: Vector[-1, 0],
  R: Vector[0, 1],
  D: Vector[1, 0],
  L: Vector[0, -1],
}

INPUT = File.readlines('input.txt').map { |l|
  l.strip.split(//).map(&:to_sym)
}

def find_5(buttons)
  buttons.each.with_index do |line, y|
    line.each.with_index do |b, x|
      return Vector[y, x] if b == ?5
    end
  end
end

def solve(buttons)
  buttons = buttons.lines.map { _1.strip.split(//) }
  pos = find_5(buttons)
  INPUT.each do |cmd|
    cmd.each do |d|
      npos = pos + DIRS[d]
      next if buttons[npos[0]][npos[1]] == ?*
      pos = npos
    end
    print buttons[pos[0]][pos[1]]
  end
  puts
end

buttons_a = <<~DATA
  *****
  *123*
  *456*
  *789*
  *****
DATA
solve(buttons_a)

buttons_b = <<~DATA
  *******
  ***1***
  **234**
  *56789*
  **ABC**
  ***D***
  *******
DATA
solve(buttons_b)
