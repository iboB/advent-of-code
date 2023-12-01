# the initial implementations used to check whether the rest of the packages
# could be split into 2 or 3 equal subsets, but it turned out it's not needed

# leaving these function here for posterity

# pseudopolynomial partitioning (k=2)
def ppp(ar)
  sum = ar.sum
  return false if sum.odd?
  half = sum/2
  table = [[true] * (ar.length + 1)]
  table += half.times.map { [false] * (ar.length + 1) }

  1.upto(half) do |i|
    1.upto(ar.length) do |j|
      x = ar[j-1]
      table[i][j] = table[i][j-1]
      table[i][j] ||= table[i-x][j-1] if i-x >= 0
    end
  end

  table[-1][-1]
end

# pseudopolynomial partitioning (k=3)
def ppp(ar)
  sum = ar.sum
  return false if sum % 3 != 0
  third = sum/3

  table = []
  (third+1).times do |h|
    plane = []
    (third+1).times do |i|
      plane << [false] * (ar.length + 1)
    end
    table << plane
  end

  table[0].each { _1.map!{true} }

  1.upto(third) do |h|
    1.upto(third) do |i|
      1.upto(ar.length) do |j|
        x = ar[j-1]
        table[h][i][j] = table[h][i][j-1]
        table[h][i][j] ||= table[h][i-x][j-1] if i-x >= 0
        table[h][i][j] ||= table[h-x][i][j-1] if h-x >= 0
      end
    end
  end

  table[-1][-1][-1]
end
