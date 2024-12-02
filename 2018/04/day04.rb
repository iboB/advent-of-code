guards = Hash.new { |h, k| h[k] = [] }

cur = nil
File.readlines('input.txt').sort.each { |l|
  stamp, action = l.strip.split('] ')
  y, m, d, h, min = stamp.scan(/\d+/)
  if action =~ /Guard #(\d+)/
    cur = $1.to_i
    guards[cur] << []
  else
    guards[cur].last << min.to_i
  end
}

stats = guards.map { |k, v|
  days = v.map { |hour|
    mins = [nil] * 60
    hour.each_slice(2) { |a, b|
      (a..b).each { mins[_1] = true }
    }
    mins
  }
  [
    # guard id
    k,

    # total minutes of sleep
    days.flatten.compact.length,

    # most slept minute (and num days in which it happened)
    *days.transpose.map.with_index { |mins, i|
      [i, mins.count(true)]
    }.max_by(&:last)
  ]
}

# a
p stats.max_by { _2 }.then { _1 * _3 }

# b
p stats.max_by { _4 }.then { _1 * _3 }
