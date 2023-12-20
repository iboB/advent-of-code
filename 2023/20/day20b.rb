rx_in = nil # checked input that it's only one

state = File.readlines('input.txt').map { |l|
  name, outs = l.strip.split(' -> ')
  type, name = name =~ /^\&|\%/ ? [name[0], name[1.. ]] : [nil, name]
  rx_in = name if outs["rx"]
  [name, [type, {}, outs.split(', ')]]
}.to_h

state.each { |name, (type, ins, outs)|
  outs.each {
    out = state[_1]
    next if !out || out[0] != ?&
    out[1][name] = false
  }
}

rx_in_flips = state[rx_in][1].keys.map { [_1, 0] }.to_h

counts = Hash.new 0

(1..).each do |i|
  counts[false] += 1
  q = state["broadcaster"][2].map { [nil, _1, false] }
  while !q.empty?
    from, to, high = q.shift

    rx_in_flips[from] = i if to == rx_in && high

    counts[high] += 1
    pulse = case state[to]
    in [?%, on, _] then on[0] = !on[0] if !high
    in [?&, ins, _]
      ins[from] = high
      !ins.values.all?
    else; nil
    end
    next if pulse == nil
    q += state[to][2].map { [to, _1, pulse] }
  end

  p counts.values.inject(&:*) if i == 1000 # also a :)
  break if rx_in_flips.values.none?(&:zero?)
end

p rx_in_flips.values.inject{ _1.lcm(_2) }
