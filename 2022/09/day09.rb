require 'matrix'

snake = Array.new(10) { Vector[0, 0] }
tpos_a = {}
tpos_b = {}

File.readlines('input.txt').each { |l|
  # p l
  dir, moves = l.split(' ')
  dir = case dir
  when ?R then Vector[1, 0]
  when ?L then Vector[-1, 0]
  when ?U then Vector[0, 1]
  when ?D then Vector[0, -1]
  end
  moves.to_i.times {
    snake[0] += dir
    snake.each_cons(2) { |h, t|
      delta = h-t
      if (delta.any? { _1.abs > 1 })
        # hacky preserve t
        t[0..1] = t + delta.map { _1 == 0 ? 0 : _1/_1.abs}
      else
        break
      end
    }
    tpos_a[snake[1].to_s] = true
    tpos_b[snake.last.to_s] = true
    # p snake
  }
}

p tpos_a.length
p tpos_b.length

