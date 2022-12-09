require 'matrix'

Dirs = {
  ?R => Vector[1, 0],
  ?L => Vector[-1, 0],
  ?U => Vector[0, 1],
  ?D => Vector[0, -1],
}

def solve(commands, snake_len)
  snake = Array.new(snake_len) { Vector[0, 0] }
  tpos = {}

  commands.each do |cmd|
    # p cmd
    cmd[1].times {
      snake[0] += Dirs[cmd[0]]
      snake.each_cons(2) { |h, t|
        dir = h-t
        if (dir.any? { _1.abs > 1 })
          # hacky preserve t
          t[0..1] = t + dir.map { _1 == 0 ? 0 : _1/_1.abs}
        else
          break
        end
      }
      tpos[snake.last.to_a.join(';')] = true
      # p snake
    }
  end
  tpos.length
end

input = File.readlines('input.txt').map { |l|
  d, s = l.split(' ')
  [d, s.to_i]
}

# a
p solve(input, 2)

# b
p solve(input, 10)

