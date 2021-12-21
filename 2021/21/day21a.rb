pos = [8, 6]
score = [0, 0]

die = 0
rolls = 0
move = 0

do_move = -> {
  i = move % 2
  3.times do
    rolls += 1
    die += 1
    pos[i] += die
    die -= 100 if die >= 100
  end
  pos[i] -= 10 while pos[i] > 10
  score[i] += pos[i]
  score[i] < 1000
}

while do_move.() do
  move += 1
end

p rolls * score.min
