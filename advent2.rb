sum = 0
ARGF.each do |line|
  values = line.split.collect(&:to_i)

  diff = values.max - values.min
  sum += diff
end
puts sum



