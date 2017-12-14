ARGF.each do |line|
  values = line.chomp.chars.collect(&:to_i)
  length = values.length
  sum = 0
  values.each_with_index do |v, i|
    next_value = values[(i + 1) % length ]
    if next_value == v
      sum += v
    end
  end
  puts sum
end
