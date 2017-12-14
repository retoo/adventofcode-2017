DIR = [
      [:right, 1, 0],
      [:up, 0, -1],
      [:left, -1, 0],
      [:down, 0, 1]]

ARGF.each do |line|
  index = line.to_i

  x = 0
  y = 0
  i = 0
  square_id = 1
  while true
    dir, dx, dy = DIR[i % 4]
    steps = i / 2 + 1
    steps.times do
      ox = x
      oy = y
      distance_to_root = x.abs + y.abs
      x += dx
      y += dy

      if square_id == index
        puts "##{square_id} #{ox}:#{oy} (#{distance_to_root} to root)  #{steps} #{dir} => #{x} #{y}"
        exit
      end
      square_id += 1

    end
    i += 1
  end
end



