require 'set'

state = []
ARGF.each do |line|
  state << line.to_i
end
steps = 0
cursor = 0
while true
  diff = state[cursor]
  break if diff.nil?

  steps += 1
  state[cursor] += diff >= 3 ? -1 : 1

  cursor += diff
end
puts "steps: #{steps}"



