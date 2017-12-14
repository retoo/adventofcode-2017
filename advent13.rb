
class Slot
  attr_reader :slot, :depth
  def initialize(slot, depth)
    @slot = slot
    @depth = depth
    @stripe_width = [2 * depth - 2, 1].max
  end

  def occupied?(tick)
    current = tick % (@stripe_width)
    if current >= depth
      current = @stripe_width - current
    end
    current_value = current

    return current_value == 0
  end
end

slots = []

ARGF.each do |line|
  slot, depth = line.split(":").collect(&:to_i)
  s = Slot.new(slot, depth)
  slots[slot] = s

end

cursor = -1
tick = 0
weight = 0
slots.each_with_index do |slot, tick|
  cursor +=1
  current_slot = slots[cursor]

  puts "C:#{cursor} "
  if current_slot.nil? || !current_slot.occupied?(tick)
  else
    weight += current_slot.slot * current_slot.depth
    puts "stuck at slot: #{cursor}"
  end
  tick += 1
end

puts weight

puts tick
