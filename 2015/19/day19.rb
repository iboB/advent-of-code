require 'set'

input = File.readlines('input.txt').map(&:strip)

target = input[-1]
reps =  input[0..-3].map { _1.split(' => ') }

uniq = {}

# reps.each do |from, to|

class String
  def super_scan(m)
    enum_for(:scan, m).map {
      b, e = Regexp.last_match.offset(0)
      b...e
    }
  end
  def all_reps(rep)
    from, to = rep
    super_scan(from).map { |range|
      d = self.dup
      d[range] = to
      d
    }.to_a
  end
end

# a
# p reps.map { target.all_reps(_1) }.flatten.uniq.length

# # b

# 3
# 18
# 105
# 607
# 3566
# 21287
# 129071
# 793306
# RnArRnArRnArRnYArRnArRnYArRnRnRnArArRnArYArRnArRnArRnArRnRnArYRnArRnArRnArRnArArRnArRnArRnArRnArRnArRnYArRnArRnRnArRnArRnRnArYRnArArArRnArRnArRnArRnAr

# somewhat hardcoded, but I'm too lazy to write a general solution
def ys(str) = str.scan('Y').length
def rns(str) = str.scan('Rn').length
def ars(str) = str.scan('Ar').length


Ys = ys(target)
Rns = rns(target)
Ars = ars(target)

vars = Set['e']

step = 0
until vars === target
  new_vars = Set[]
  vars.each do |v|
    reps.each do |rep|
      v.all_reps(rep).each do |mod|
        next if ys(mod) > Ys
        next if rns(mod) > Rns
        next if ars(mod) > Ars
        new_vars << mod
      end
    end
  end
  step += 1
  vars = new_vars

  p "MAX #{vars.map{ ys(_1) }.max}"
  p vars.length
end

# p step
