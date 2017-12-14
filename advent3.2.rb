# map from xy to square_id
class SpiralMapper
  DIR = [
      [:right, 1, 0],
      [:up, 0, -1],
      [:left, -1, 0],
      [:down, 0, 1]]

  def initialize
    @lookup_xy = {}
    @lookup_sqi = {}
    @x = 0
    @y = 0
    @i = 0
    @square_id = 1
  end

  def xy_to_sqi(ident)
    sqi = @lookup_xy[ident]
    unless sqi
      continue_to(:xy, ident)
      sql = @lookup_xy[ident]
    end
    return sqi
  end

  def sqi_to_xy(sqid)
    xy = @lookup_sqi[sqid]
    unless xy
      continue_to(:sqi, sqid)
      xy = @lookup_sqi[sqid]
    end
    return xy
  end

  def continue_to(mode, desired_ident)
    while true
      dir, dx, dy = DIR[@i % 4]
      steps = @i / 2 + 1
      found = false
      steps.times do
        ident = [@x, @y]
        @lookup_xy[ident] = @square_id
        @lookup_sqi[@square_id] = ident
        osqi = @square_id
        @x += dx
        @y += dy
        @square_id += 1
        if mode == :sqi && osqi == desired_ident
          found = true
        elsif mode == :xy && ident == desired_ident
          found = true
        end
      end
      @i += 1
      break if found
    end
  end

end



XY_NEIGHBOURS = [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0],          [1,  0],
    [-1,  1], [0,  1], [1,  1]
]

spiral = SpiralMapper.new
field_values = {1 => 1}
square_id = 2
while true
  x, y = spiral.sqi_to_xy(square_id)

  sum = 0
  XY_NEIGHBOURS.each do |dx, dy|
    neighbour = [x + dx, y + dy]
    n_sqid = spiral.xy_to_sqi(neighbour)
    n_value = field_values[n_sqid]
    v = n_value
    if v
      sum += v
    end
  end
  field_values[square_id] = sum

  puts "#{square_id} => #{sum}"
  square_id += 1
  if sum > 265149
    puts sum
    exit
  end
end
