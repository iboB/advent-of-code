# ew
# so...

# use this:
#
# puts File.readlines('input.txt').flat_map { |l|
#   a, *bs = l.strip.split
#   a.chop!
#   bs.map { "#{a}--#{_1}" }
# }
#
# to generate a dot file which was then opened with http://magjac.com/graphviz-visual-editor/
# manually delete one of the halves
# export to input-trimmed.txt
# then:

all = File.readlines('input.txt').flat_map { |l|
  a, *bs = l.strip.split
  a.chop!
  [a, *bs]
}.uniq.length

right = File.readlines('input-trimmed.txt').flat_map { |l|
   l.strip.split('--')
}.uniq.length

p (all - right) * right
