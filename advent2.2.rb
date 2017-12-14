sum = 0
ARGF.each do |line|
  values = line.split.collect(&:to_i)
  values.each_with_index do |a, ia|
    values.each_with_index do |b, ib|
      next if ia == ib
      if a % b == 0
        sum += a / b
      end
    end
  end
end
puts sum



