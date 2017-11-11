class MessagePresenter
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def id
    message.id
  end

  def severity
    message.severity
  end

  def roles
    "severity-#{severity_string.downcase} #{shown? ? 'shown' : 'not-shown'}"
  end

  def severity_string
    [ "", "Error", "Warning", "Info" ][severity.to_i]
  end

  def severity_class
    [ "", "danger", "warning", "info" ][severity.to_i]
  end

  def identifier
    message.identifier
  end

  def success_criteria
    return unless identifier
    standard, _, _, criteria, *_ = identifier.split(/\./)
    criteria = criteria.gsub(/_\D.*/, '')
    url = case standard
    when 'WCAG2AA'
      'http://squizlabs.github.io/HTML_CodeSniffer/Standards/WCAG2/' + criteria
    end
    yield OpenStruct.new(label: "Success Criteria: " + criteria, url: url )
  end

  def each_technique
    techniques.each do |technique|
      yield technique
    end
  end

  def techniques
    return [] unless identifier
    standard, _, _, _, techniques, *_ = identifier.split(/\./)
    base_url = case standard
      when 'WCAG2AA'
        'http://www.w3.org/TR/WCAG20-TECHS/'
    end
    techniques.split(',').map { |tech| OpenStruct.new(label: "Technique " + tech, url: base_url + tech) }
  end

  def description
    message.description
  end

  def tag
    element.tag
  end

  def path
    element.path
  end

  def pretty_code
    Nokogiri::XML(code,&:noblanks).to_xhtml(indent: 2).gsub(/src="data:image[^"]*"/, 'src="[inlined image]"')
  end

  def code
    element.html
  end

  def outline_style
    "margin-top: #{element.top}px; margin-left: #{element.left}px; width: #{element.width}px; height: #{element.height}px;"
  end

  def pointer_style
    "margin-left: #{element.left}px; width: #{element.width}px; height: 1rem;"
  end

  def shown?
    element.width &&
      element.height &&
      element.visibility &&
      element.display &&
      element.width > 0 &&
      element.height > 0 &&
      element.visibility != 'hidden' &&
      element.display != 'none'
  end

  def error?
    message.severity == "1"
  end

  def warning?
    message.severity == "2"
  end

  def info?
    message.severity == "3"
  end

  private
  def element
    message.element
  end
end