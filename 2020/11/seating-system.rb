room = File.readlines('input.txt').map(&:strip)

def iteration(room)
  ret = room.map(&:dup)

  nn = ->(ir, ic) {
    on = 0
    on+=1 if ir+1!=room.length && ic+1!=room[0].length && room[ir+1][ic+1] == '#'
    on+=1 if ir!=0 && ic!=0                            && room[ir-1][ic-1] == '#'
    on+=1 if ir!=0 && ic+1!=room[0].length             && room[ir-1][ic+1] == '#'
    on+=1 if ir+1!=room.length && ic!=0                && room[ir+1][ic-1] == '#'
    on+=1 if ir+1!=room.length    && room[ir+1][ic] == '#'
    on+=1 if ic!=0                && room[ir][ic-1] == '#'
    on+=1 if ir!=0                && room[ir-1][ic] == '#'
    on+=1 if ic+1!=room[0].length && room[ir][ic+1] == '#'
    on
  }

  room.each_with_index { |row, irow|
    row.split(//).each_with_index { |col, icol|
      next if col == '.'
      n = nn.(irow, icol)
      if n == 0
        ret[irow][icol] = '#'
      elsif n >= 4
        ret[irow][icol] = 'L'
      end
    }
  }

  ret
end

def ppr(room)
  room.each { |row| puts row }
end

def same(r1, r2)
  r1.zip(r2).map { |a,b| a==b }.all?
end

while true do
  newroom = iteration(room)

  if same(newroom, room)
    ppr room
    puts room.map { |row| row.count('#') }.sum
    break
  end

  room = newroom
end
