require 'digest'

IN = 'ihaygndm'

def solve(stretch = 0)
  stretch += 1

  keys = []
  pending = []
  lim = nil

  (0..).each do |i|
    pending = pending.drop_while { i - _1[0] > 1000 }

    md5 = IN + i.to_s
    stretch.times do
      md5 = Digest::MD5.hexdigest(md5)
    end

    next if md5 !~ /([0-9a-f])\1\1/

    found = pending.group_by { |p|
      !!md5[p[1]]
    }

    keys += found[true].map { _1[0] } if found[true]
    pending = found[false] || []

    if !lim
      if keys.length >= 64
        lim = pending[-1][0] + 1000
      end
    else
      break if i >= lim
    end

    pending << [i, $1 * 5]
  end

  keys.sort[63]
end

# a
p solve()

# b
p solve(2016)

