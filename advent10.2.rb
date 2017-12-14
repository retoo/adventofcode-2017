l = 256

def extract_sub_list(list, index, length)
  result = []
  length.times do |i|
    result << list[(index + i) % list.size ]
  end
  return result
end

def set_sub_list(list, index, to_replace)
  to_replace.each_with_index do |v, i|
    list[(index + i) % list.size ] = v
  end
end

ARGF.each do |line|
  input = []
  line.chomp.each_byte do |b|
    input << b
  end

  input += [17, 31, 73, 47, 23]

  string = []
  l.times do |i|
    string << i
  end

  skip_size = 0
  cursor = 0

  64.times do
    input.each do |length|
      sub = extract_sub_list(string, cursor, length)
      set_sub_list(string, cursor, sub.reverse)
      cursor = (cursor + skip_size + length) % string.length
      skip_size += 1
    end
  end

  out = []
  string.each_slice(16) do |sub|
    out << "%02x" % sub.inject(0){|s, e| s ^ e}
  end
  puts out.join
end
