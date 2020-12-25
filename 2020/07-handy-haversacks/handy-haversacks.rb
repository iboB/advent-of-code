SG = "shiny gold"

class Node
  def initialize(bags)
    @bags = bags
  end

  def build(rules)
    @bags = @bags.map { |name, num| [rules[name], num] }.to_h
    @has_sg = true if rules[SG] == self
    @count = 0 if @bags.empty?
  end

  def has_sg?
    return @has_sg if @has_sg != nil
    @has_sg = @bags.any? { |node, num| node.has_sg? }
  end

  def count
    return @count if @count
    @count = @bags.map { |node, num| num * (node.count + 1) }.sum
  end
end

Rules = File.readlines('input.txt').map { |s|
  bag, contents = s.split('contain')
  bag = bag[0..-7]
  contents = Node.new contents.split(',').map { |c|
    break [] if c.start_with?(' no other')
    c =~ /^ (\d+) (.+) bag/
    [$2, $1.to_i]
  }
  [bag, contents]
}.to_h

Rules.each { |name, rule| rule.build Rules }

p Rules.count { |name, rule| rule.has_sg? } - 1
p Rules[SG].count
