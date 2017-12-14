require 'set'

class MNode
  attr_accessor :name, :pipes_raw, :pipes, :group

  def initialize(name, pipes_raw)
    @pipes = Set.new

    @pipes_raw = pipes_raw
    @name = name
    @group = nil
  end

  def link(lookup)
    @pipes_raw.each do |pipe_raw|
      neighbour = lookup[pipe_raw]
      raise if neighbour.nil?
      @pipes << neighbour
      neighbour.pipes << self
    end
    @pipes_raw = nil
  end

  def walk_all
    seen = Set.new
    to_do = []
    to_do << self
    seen << self
    until to_do.empty?
      node = to_do.pop
      yield(node)
      node.pipes.each do |neighbour|
        next if seen.include?(neighbour)
        seen << neighbour
        to_do << neighbour
      end
    end
  end

  def to_s
    "Node(#{@name})"
  end
end

nodes = []
node_by_name = {}
RE = /(\d+) <-> (.*)/
ARGF.each do |line|
  m = RE.match(line.chomp)
  raise unless m
  name = m[1].to_i
  pipes_raw = m[2].split(",").collect(&:to_i)

  node = MNode.new(name, pipes_raw)
  nodes << node
  node_by_name[node.name] = node
end


nodes.each do |node|
  node.link(node_by_name)
end

root = node_by_name[0]
count = 0
root.walk_all do |n|
  count += 1
end
puts count

group = 0
nodes.each do |node|
  next if node.group
  node.walk_all do |n|
    n.group = group
  end
  group += 1
end

#nodes.each do |node|
#  raise node.inspect if node.group.nil?
#end

puts group
