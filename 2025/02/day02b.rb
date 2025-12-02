# construct numbers from repeating numbers and check if they are in an interval

input = File.read(?i).strip.split(?,).map { eval(_1.gsub(?-, '..')) }
max = input.map(&:last).max

found = Set.new
sum = 0
(1..).each { |q|
  sq = q.to_s
  (2..).each { |r|
    nq = (sq * r).to_i
    next if found === nq
    found << nq
    if nq > max
      break if r > 2
      p sum
      exit
    end
    sum += nq if input.find { _1 === nq }
  }
}
