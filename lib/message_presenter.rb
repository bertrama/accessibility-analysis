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

  def description
    message.description
  end

  def tag
    element.tag
  end

  def path
    element.path
  end

  def code
    element.html
  end

  def css_dimensions
    "margin-top: #{element.top}px; margin-left: #{element.left}px; width: #{element.width}px; height: #{element.height}px;"
  end

  def shown?
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