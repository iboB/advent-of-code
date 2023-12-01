MYHP = 100
Boss = {hp: 109, dmg: 8, arm: 2}

SHOP = <<DATA
Weapons:    Cost  Damage  Armor
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0

Armor:      Cost  Damage  Armor
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5

Rings:      Cost  Damage  Armor
Damage +1    25     1       0
Damage +2    50     2       0
Damage +3   100     3       0
Defense +1   20     0       1
Defense +2   40     0       2
Defense +3   80     0       3
DATA

shop = {}
cur_type = nil
item_stat_types = [:p, :dmg, :arm]
SHOP.each_line do |line|
  next if line.strip.empty?
  if line =~ /^(\w+)\:/
    cur_type = shop[$1.downcase.to_sym] = []
  else
    cur_type << item_stat_types.zip(line.scan(/\d+/)[-3..].map(&:to_i)).to_h
  end
end

weapon_cmb = shop[:weapons]
armor_cmb = [nil] + shop[:armor]
ring_cmb = [[]] + shop[:rings].map { [_1] } + shop[:rings].permutation(2).to_a

class Hash
  def hit(victim)
    dmg = self[:dmg] - victim[:arm]
    dmg > 0 ? dmg : 1
  end
end

def fight(a, b)
  ahp = a[:hp]
  bhp = b[:hp]

  while true
    bhp -= a.hit(b)
    return true if bhp < 1
    ahp -= b.hit(a)
    return false if ahp < 1
  end
end

builds = weapon_cmb.product(armor_cmb).product(ring_cmb).map { |eq|
  {hp: MYHP}.merge eq.flatten.compact.inject { |sum, h| sum.merge(h) { |_, a, b| a + b } }
}.sort_by { _1[:p] }

# a
p builds.find { |build| fight(build, Boss) }[:p]

# b
p builds.reverse.find { |build| !fight(build, Boss) }[:p]

