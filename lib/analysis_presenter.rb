class AnalysisPresenter
  attr_reader :analysis

  def initialize(analysis)
    @analysis = analysis
  end

  def message_count(type)
    return analysis.messages.length if type == :all
    analysis.messages.select do |message|
      MessagePresenter.new(message).send("#{type}?")
    end.length
  end

  def title
    analysis.title
  end

  def url
    analysis.url
  end

  def screenshot
    analysis.screenshot
  end

  def each_message
    analysis.messages.each do |message|
      yield MessagePresenter.new(message)
    end
  end
end