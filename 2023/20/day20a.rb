state = File.readlines('input.txt').map { |l|
  name, outs = l.strip.split(' -> ')
  type, name = name =~ /^\&|\%/ ? [name[0], name[1.. ]] : [nil, name]
  [name, [type, {}, outs.split(', ')]]
}.to_h

state.each { |name, (type, ins, outs)|
  outs.each {
    out = state[_1]
    next if !out || out[0] != ?&
    out[1][name] = false
  }
}

counts = Hash.new 0

1000.times do
  counts[false] += 1
  q = state["broadcaster"][2].map { [nil, _1, false] }
  while !q.empty?
    from, to, high = q.shift

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
end

p counts.values.inject(&:*)
