class Analyzer
  attr_reader :url, :id, :options, :persister

  def self.for(page, persister)
    new(id: page.id, url: page.url, persister: persister)
  end

  def initialize(id: nil, url: nil, persister: nil)
    @id = id
    @url = url
    @persister = persister
    @options = default_options
  end

  def run(path = nil)
    uuid = SecureRandom.uuid
    driver = chrome_driver(options)
    driver.get(url)
    wait.until { driver.execute_script( "return document.readyState;" ) == 'complete' }
    sleep(5)
    width, height = get_body_size(driver)
    driver.manage.window.resize_to(width, height)
    image_path = File.join([path, uuid + '.png'].compact)
    driver.save_screenshot(image_path)
    inject_htmlcs(driver)
    wait.until { driver.execute_script( "return 'HTMLCS' in window" ) }
    inject_find_path(driver)
    analysis = run_htmlcs(driver)
    persister.save(id, analysis, image_path)
    driver.close
  end

  private

  def inject_find_path(driver)
    driver.execute_script(
      "window.fullPath = function (el) {
  var names = [];
  while (el.parentNode) {
    if (el.id) {
      names.unshift('#'+el.id);
      break;
    } else {
      if (el==el.ownerDocument.documentElement) {
        names.unshift(el.tagName);
      } else {
        for (var c=1,e=el;e.previousElementSibling;e=e.previousElementSibling,c++);
        names.unshift(el.tagName+':nth-child('+c+')');
      }
      el=el.parentNode;
    }
  }
  return names.join(' > ');
}
"
    )
  end

  def run_htmlcs(driver)
    standard = 'WCAG2AA'
    driver.execute_script(
      "
      window.HTMLCS.process('WCAG2AA', window.document);
      return {
        title: window.document.title,
        url: window.location.href,
        issues: window.HTMLCS.getMessages().map((i) => {
          var style = getComputedStyle(i.element);
          var rectangle = i.element.getBoundingClientRect();
          i.element = {
            visibility: style.getPropertyValue('visible'),
            display: style.getPropertyValue('display'),
            path: fullPath(i.element),
            x: rectangle.x,
            y: rectangle.y,
            height: rectangle.height,
            width: rectangle.width,
            top: rectangle.top,
            bottom: rectangle.bottom,
            left: rectangle.left,
            right: rectangle.right,
            html: i.element.outerHTML
          };
          return i;
        })
      }
      ", standard)
  end

  def inject_htmlcs(driver)
    driver.execute_script(
      "
        var s = document.createElement('script');
        s.src = 'https://squizlabs.github.io/HTML_CodeSniffer/build/HTMLCS.js'
        document.head.appendChild(s);
      "
    )
  end

  def get_body_size(driver)
    rectangle = driver.execute_script("return document.body.getClientRects();").first
    [rectangle['width'].to_f.ceil, rectangle['height'].to_f.ceil]
  end

  def wait(time = 30)
    Selenium::WebDriver::Wait.new(timeout: time)
  end
  def default_options
    Selenium::WebDriver::Chrome::Options.new(args:['headless'])
  end

  def chrome_driver(options)
    Selenium::WebDriver.for(:chrome, options: options)
  end
end
