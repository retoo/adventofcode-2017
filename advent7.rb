require 'set'

class Node
  attr_reader :name, :children_names, :parent
  def initialize(name, weight, children_names)
    @name = name
    @weight = weight
    @children_names = children_names
    @parent = nil
    @children = []
  end

  def register_child(child)
    @children << child
    child.register_parent(self)
  end

  def register_parent(parent)
    @parent = parent
  end

  def root
    n = self
    until n.parent.nil?
      n = n.parent
    end
    return n
  end

end

NODE_RE = /^(\S+) \((\d+)\)(?: -> (.*))?$/

node_by_name = {}
nodes = []

ARGF.each do |line|
  m = NODE_RE.match(line.chomp)
  raise "invalid node name: #{line.inspect}" unless m

  node_name = m[1]
  node_weight = m[2].to_i
  node_children_raw = m[3]

  if node_children_raw
    children_names = node_children_raw.split(",").collect(&:strip)
  else
    children_names = []
  end

  node = Node.new(node_name, node_weight, children_names)
  node_by_name[node.name] = node
  nodes << node
end

nodes.each do |n|
  n.children_names.each do |child|
    child = node_by_name[child]
    n.register_child(child)
  end
end

puts nodes.first.root.name


