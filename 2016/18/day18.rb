# terrible brute-force
# should look for cycles, but... meh
require 'set'
TRAPS = Set.new %w(^^. .^^ ^.. ..^).map(&:chars)

p 39.times.inject([File.read('input.txt').strip.chars]) { |rows|
  rows + [(['.'] + rows[-1] + ['.']).each_cons(3).map { TRAPS === _1 ? '^' : '.' }]
}.flatten.count(?.)
