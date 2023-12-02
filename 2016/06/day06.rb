p File.readlines('input.txt').map(&:strip).map { _1.split(//) }.transpose.map { _1.tally.to_a.max_by(&:last).first }.join
p File.readlines('input.txt').map(&:strip).map { _1.split(//) }.transpose.map { _1.tally.to_a.min_by(&:last).first }.join
