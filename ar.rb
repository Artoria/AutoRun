require './myopt.rb'
require './myverbose.rb'
require './myfiletype.rb'

MyVerbose.verbose = true
OptObject.new do
  @mode = :open
  def open()  @mode = :open  end
  def last(args)
    args.map{|x| x[1]}.each{|filename|MyFileType.detect(filename).call}
  end
end.parse(ARGV)