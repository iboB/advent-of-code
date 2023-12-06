t, d = File.readlines('input.txt').map { |l|
  l.strip.scan(/\d+/).join.to_i
}

# x(t-x) > d:
#
#       t - √(t² - 4d)    t + √(t² - 4d)
# x ∈  --------------- ; ---------------
#             2                 2

di = Math.sqrt(t**2 - 4*d)
min = ((t - di)/2).ceil
max = ((t + di)/2).floor
p (max - min + 1)

