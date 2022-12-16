input = File.readlines('input.txt').map { |l|
  l =~ /Valve ([A-Z]+) has flow rate=(\d+); tunnel(s?) lead(s?) to valve(s?) (.+)/
  vname = $1
  rate = $2.to_i
  links = $6.split(', ')
  [vname, rate, links]
}


