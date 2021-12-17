input = File.read('input.txt').strip =~ /x=(-?\d+\.\.-?\d+), y=(-?\d+\.\.-?\d+)/
Ax = eval($1)
Ay = eval($2)

def sim(vx, vy)
  px = 0
  py = 0
  maxy = 0

  while true do
    px += vx
    py += vy
    vx -= 1 if vx > 0
    vy -= 1
    maxy = py if py > maxy
    # p [px, py]
    return maxy if Ax === px && Ay === py
    return false if px > Ax.last || py < Ay.first
  end
end

sims = []

# brute force search for result
130.times do |vx|
  3000.times do |vy|
    r = sim(vx, 1000 - vy)
    sims << r if r
  end
end

# a
p sims.max

# b
p sims.length

