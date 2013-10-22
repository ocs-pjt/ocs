class Utils
  def self.filename(str)
    [str.downcase.gsub(/ +/, '_'),Time.now.strftime("%Y-%m-%d-%H%M%S")].join("_")
  end
end