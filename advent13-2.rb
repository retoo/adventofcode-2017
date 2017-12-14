
class Slot
  attr_reader :slot, :depth
  def initialize(slot, depth)
    @slot = slot
    @depth = depth
    @stripe_width = [2 * depth - 2, 1].max
  end

  def occupied?(delay)
    current = (delay + @slot) % @stripe_width
    if current >= depth
      current = @stripe_width - current
    end
    return current == 0
  end
end

slots = []
all_slots = []

ARGF.each do |line|
  slot, depth = line.split(":").collect(&:to_i)
  s = Slot.new(slot, depth)
  slots[slot] = s
  all_slots << s
end

all_slots = all_slots.sort_by{|s| s.depth}

overall = Time.now
# run 10 times for benchmarking
10.times do
  this = Time.now
  delay = 10
  while true
    found = true
    all_slots.each do |slot|
      if slot.occupied?(delay)
        found = false
        break
      end
    end

    if found
      puts "solution: #{delay}"
      break
    else
      delay += 1
    end
  end
  puts "duration: %.2fms" % [(Time.now - this) * 1000]
end

puts "overall: %.2fs" % [Time.now - overall]
