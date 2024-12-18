@pts = File.readlines('input.txt').map { _1.split(?,).map(&:to_i) }

@finish = @pts.transpose.then { _1.max + _2.max.i }

@empty_map = (0..@finish.imag).flat_map { |y| (0..@finish.real).map { |x| [x + y.i, 1e10] } }.to_h

def path(n)
  map = Hash.new(0)
    .merge @empty_map
    .merge @pts[...n].map { [_1 + _2.i, 0] }.to_h

  layer = [0i]
  step = 0

  while true
    map.merge! layer.product([step]).to_h
    return step if map[@finish] == step

    step += 1
    layer = layer.flat_map { |pos|
      [1, -1, 1i, -1i].map { pos + _1 }.select { map[_1] > step }
    }.uniq
    return nil if layer.empty?
  end
end

# a
p path(1024)

# b
puts @pts[(1025..).find { !path(_1) } - 1].join(?,)
