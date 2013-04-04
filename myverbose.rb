module MyVerbose
  module_function
  def verbose=(v) @verbose = v end
  def verbose()   @verbose     end

  def self.method_missing(sym, *args)
    if @verbose
      self.class.superclass.instance_method(sym).bind(self).call(*args)
    end
  end
end