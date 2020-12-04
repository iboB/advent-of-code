# "If I had more time, I would have written a shorter letter."
input = File.read('input.txt').split("\n\n").map { |entry| entry.split(/ |\n/) }
puts [
  [/^byr:/, /^iyr:/, /^eyr:/, /^hgt:/, /^hcl:/, /^ecl:/, /^pid:/],
  [
    /^byr:(19[2-9]\d|200[0-2])$/,
    /^iyr:20(1\d|20)$/,
    /^eyr:20(2\d|30)$/,
    /^hgt:(1([5-8]\d|9[0-3])cm|(59|6\d|7[0-6])in)$/,
    /^hcl:#[0-9a-f]{6}$/,
    /^ecl:(amb|blu|brn|gry|grn|hzl|oth)$/,
    /^pid:\d{9}$/
  ]
].map { |rules| input.filter { |data| rules.all? { |r| data.any? { |kv| kv =~ r } } }.length }
