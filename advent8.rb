
RE = /^(\S+) (inc|dec) (-?\d+) if (\S+) (<|>|<=|>=|==|!=) (-?\d+)$/

max_value = -1

registry = Hash.new(0)
ARGF.each do |line|
  m = RE.match(line)

  raise "invalid line: #{line.inspect}" unless m

  register = m[1]
  op = m[2]
  value = m[3].to_i
  cond_register = m[4]
  cond_op = m[5]
  cond_value = m[6].to_i

  # evaluate condition
  if registry[cond_register].send(cond_op, cond_value)
    case op
      when "inc"
        registry[register] += value
      when "dec"
        registry[register] -= value
      else
        raise "invalid op: #{op.inspect}"
    end
  end
  max_value = [registry.values.max, max_value].max
end
puts registry.values.max
puts max_value


