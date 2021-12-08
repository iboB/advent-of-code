p File.readlines('input.txt').map { |l|
  l.strip.split(' | ')[1].split.map(&:length).select { |len|
    case len
    when 2,3,4,7 then true
    else false
    end
  }.length
}.sum
