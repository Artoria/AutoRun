module MyFileType
  @os = {
    'i386-mingw32' => "win32"
  }[RUBY_PLATFORM]

  module_function
  def win32ftype(x)
    ext = File.extname(x)
    y = `assoc #{ext}`
    z = `ftype #{y[/=(.*)/, 1]}`
    s = z[/=(.*)/, 1]
    if s
      MyVerbose.puts(s.gsub(/%1/){x})
      lambda{system(s.gsub(/%1/){x})}
    else
      nil
    end
  end

  def detect(x)
    out = nil
    out ||= win32ftype(x) if @os == "win32"
     
     
  end
 

end

