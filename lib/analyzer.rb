class Analyzer
  attr_reader :url, :id

  def self.for(page)
    new(id: page.id, url: page.url)
  end

  def initialize(id: nil, url: nil)
    @id = id
    @url = url
  end

  def run
    puts "analyzer.run: #{url}"
  end
end
