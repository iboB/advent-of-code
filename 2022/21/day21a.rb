@data = File.readlines('input.txt').map { |l|
  name, op = l.strip.split(':')
  if op =~ /-?\d+/
    op = op.to_i
  else
    op.gsub!(/([a-z]+)/, 'get_result("\1")')
  end
  [name, op]
}.to_h

def get_result(name)
  r = @data[name]
  return r if Integer === r
  @data[name] = eval(r)
  @data[name]
end

p get_result('root')

