require 'set'

def find_largest_bin(state)
  result = nil
  max = nil
  state.each_with_index do |v, i|
    if max.nil? || v > max
      result = i
      max = v
    elsif max == v
      # ignore, we take the bin with the lowest id
    end
  end

  return result
end

ARGF.each do |line|
  state = line.chomp.split.collect(&:to_i)
  state_size = state.size
  seen = Set.new
  steps = 0
  while true

    # puts "#{steps}: #{state.join(" ")}"
    if seen.include?(state)
      break
    end
    steps += 1
    seen << state

    distribute_index = find_largest_bin(state)
    distribute_value = state[distribute_index]
    state[distribute_index] = 0
    distribute_value.times do |i|
      target_index = (i + 1 + distribute_index) % state_size
      state[target_index] += 1
    end
  end

  puts steps

end


