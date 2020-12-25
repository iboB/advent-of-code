input = []
cur = {}
File.readlines('input.txt').each do |line|
  line.strip!
  if line.empty?
    input << cur
    cur = {}
    next
  end

  cur.merge! line.split(' ').map { |e| e.split(':') }.to_h
end
input << cur if !cur.empty?

input.map! { |data|
  data.delete 'cid'
  data.transform_keys(&:to_sym)
}

module Validator
  extend self
  def byr(val)
    val.to_i.between?(1920, 2002)
  end
  def iyr(val)
    val.to_i.between?(2010, 2020)
  end
  def eyr(val)
    val.to_i.between?(2020, 2030)
  end
  def hgt(val)
    return $1.to_i.between?(150, 193) if val =~ /^(\d+)cm$/
    return $1.to_i.between?(59, 76) if val =~ /^(\d+)in$/
    false
  end
  def hcl(val)
    return false if val.length != 7
    val =~ /^#[0-9a-f]+$/
  end
  def ecl(val)
    %w(amb blu brn gry grn hzl oth).include?(val)
  end
  def pid(val)
    return false if val.length != 9
    val =~ /^\d+$/
  end
end

REQ = Validator.public_instance_methods

puts "Total: #{input.length}"

input.filter! { |data| REQ.all? { |key| data.key? key } }

puts "A: #{input.length}"

input.filter! { |data| data.all? { |key, val| Validator.send(key, val) } }

puts "B: #{input.length}"

