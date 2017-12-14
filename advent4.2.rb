require 'set'
valid_count = 0
ARGF.each do |line|
  seen = Set.new
  valid = true
  line.chomp.split.map{|w| w.chars.sort.join("") }.each do |word|
    if seen.include?(word)
      valid = false
      break
    end
    seen << word
  end

  if valid
    valid_count += 1
  end

end
puts valid_count



