# brute force... takes some tens of seconds to run
# ruby is at fault here. with a linked list this will likely be
# 1-2 orders of magnitude faster

input = File.read('input.txt').strip

def react(str)
  pd = str.bytes.each_cons(2).map { _1 - _2 }
  while true do
    i = pd.find_index { _1.abs == 32 }
    break unless i
    if i == 0
      pd.shift(2)
    elsif i == pd.length - 1
      pd.pop(2)
    else
      d = pd.delete_at(i) + pd.delete_at(i)
      pd[i-1] += d
    end
  end

  pd.length + 1
end

# a
p react(input)

# b
p ('a'..'z').map { |c|
  react(input.tr(c + c.upcase, ''))
}.min
