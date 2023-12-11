require 'digest'

PASS = 'yjjvjgan'
Dirs = [[?U, -1i], [?D, 1i], [?L, -1], [?R, 1]]

def bfs
  found = []
  paths = [[PASS, 0]]
  while true
    npaths = []
    paths.each do |path, pos|
      locks = Digest::MD5.hexdigest(path)[0...4].chars.map { _1 > ?a }
      Dirs.zip(locks).select { _2 }.each do |(name, dir), l|
        npos = pos + dir
        next if npos.rect.any? { _1 < 0 || _1 > 3 }
        npath = path + name
        if npos == 3 + 3i
          found << npath[PASS.length..]
        else
          npaths << [npath, npos]
        end
      end
    end
    return found if npaths.empty?
    paths = npaths
  end
end

paths = bfs

p paths[0] # a
p paths[-1].length # b
