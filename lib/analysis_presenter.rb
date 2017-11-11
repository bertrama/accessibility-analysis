class AnalysisPresenter
  attr_reader :analysis

  def initialize(analysis)
    @analysis = analysis
  end

  def message_count(type = :all)
    return analysis.messages.length if type == :all
    analysis.messages.select do |message|
      MessagePresenter.new(message).send("#{type}?")
    end.length
  end

  def created
    analysis.created_at
  end

  def title
    analysis.title
  end

  def label
    "Analysis #{analysis.id}"
  end

  def messages?
    analysis.messages.count > 0
  end

  def date
    analysis.created_at
  end

  def to_model
    analysis.to_model
  end

  def url
    analysis.url
  end

  def page_label
    PagePresenter.new(analysis.page).label
  end

  def page
    PagePresenter.new(analysis.page)
  end

  def screenshot
    analysis.screenshot
  end

  def screenshot?
    analysis.screenshot && !analysis.screenshot.blank?
  end

  def each_message
    analysis.messages.each do |message|
      yield MessagePresenter.new(message)
    end
  end
end