# for each interval construct possible numbers repeated twice

input = File.read(?i).strip.split(?,).map { _1.split(?-).map(&:to_i) }

sum = 0
input.each { |a, b|
  as = a.to_s
  n = as[...as.length/2].to_i
  (n..).each {
    q = (_1.to_s * 2).to_i
    next if q < a
    break if q > b
    sum += q
  }
}

p sum
