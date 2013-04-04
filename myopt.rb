class OptObject
  class X < Array
    attr_accessor :rel
    def init
      @marked = []
      @rel = 0
    end
    def mark_abs(x)
      @marked[x] = true
    end
    def mark(range)
      [*range].each{|x| mark_abs x + @rel}
    end    
    def [](obj)
      super obj + @rel
    end
    def unmarked
      length.times.reject{|x| @marked[x]}.map{|x| [x, self[x]]}
    end
  end
  def initialize &block
    instance_exec &block if block
  end

  def long(sym)
    send sym
  end

  attr_accessor :arg
  def parse(argv)
    @args = []
    @arg = X.new
    @arg.init
    @arg[0..-1]=argv
    argv.each_with_index{|x, i|
      if  x[/^--/]
        arg.mark_abs(i)
        arg.rel = i
        long(x[2..-1])
      elsif x[/^-/]
        arg.rel = i
        arg.mark_abs(i)
        send  x[1..-1]
      else
        @args << x
      end
    }
    last arg.unmarked
  end

  def last(args)
  end

  def mark(range)
    self.arg.mark(range)
  end
  
  def take(n = nil)
   if n  == nil
     mark 1
     self.arg[1]
   else  
      mark 1..n
      (1..n).map{|x|self.arg[x]}
    end
  end

end


=begin Cat
OptObject.new do
  def last(args)
    args.each{|x| puts File.read x[1]}
  end
end.parse(ARGV)
=end