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
  input = line.split(',').collect(&:to_i)

  string = []
  l.times do |i|
    string << i
  end

  skip_size = 0
  cursor = 0
  #puts string.inspect + " " + cursor.inspect

  input.each do |length|
    #puts "input: #{length}"
    #puts "before: #{string.inspect} c:#{cursor} sZ: #{skip_size}"
    sub = extract_sub_list(string, cursor, length)
    #puts "sub: #{sub.inspect}"
    set_sub_list(string, cursor, sub.reverse)
    #puts "after: #{string.inspect}"
    cursor = (cursor + skip_size + length) % string.length
    skip_size += 1
  end
  puts string.shift * string.shift
end


__END__

{
  {
    {
      {
        {}
        ,
        { <>
          ,
            <u'!!!>,,}!>"
