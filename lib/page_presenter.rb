class PagePresenter
  attr_reader :page

  def initialize page
    @page = page
  end

  def label
    page.url
  end

  def analyses?
    page.analyses.length > 0
  end

  def analysis_count
    page.analyses.length
  end

  def analyses
    page.analyses
  end

  def url
    page.url
  end

  def to_model
    page.to_model
  end

  def update(properties)
    page.update(properties)
  end

  def each_analysis
    page.analyses.each do |analysis|
      yield AnalysisPresenter.new(analysis)
    end
  end
end