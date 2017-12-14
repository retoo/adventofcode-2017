
class StateMachine
  class Group
    attr_reader :children
    def initialize(parent)
      @parent = parent
      @children = []
      unless parent.nil?
        parent.children << self
      end
    end

    def score
      if @parent.nil?
        return 1
      else
        @parent.score + 1
      end
    end
  end

  attr_reader :groups
  def initialize
    @groups = []
    @stack = []
    @ignore_next = false
  end

  def consume(c)
    if @ignore_next
      @ignore_next = false
      return
    end

    if @trash_mode && (c != ">" && c != "!")
      return
    end

    case c
      when "{"
        current_group = @stack.last
        group = Group.new(current_group)
        @stack << group
        @groups << group
      when "}"
        raise "invalid" unless @stack.length > 0
        @stack.pop
      when ","
      when "<"
        @trash_mode = true
      when ">"
        @trash_mode = false
      when "!"
        @ignore_next = true
      else
        raise "invalid: #{c}"
    end
  end
end

ARGF.each do |line|
  machine = StateMachine.new

  line.chomp.chars.each do |c|
    machine.consume(c)
  end
  s = 0
  machine.groups.each do |g|
    s += g.score
  end
  puts s
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
