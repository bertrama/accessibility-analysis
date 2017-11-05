
class ActiveRecordAnalysisPersister
  def save(page_id, info, image)
    page = Page.find(page_id)
    page.analyses << (analysis = Analysis.new(
      screenshot: File.new(image,'r'),
      title: info['title'],
      url: info['url'],
    ))
    url = URI(info['url'])
    origin = "#{url.scheme}://#{url.host}"
    info['issues'].each do |issue|
      e = issue['element']
      analysis.messages << (message = Message.new(
        identifier: issue['code'],
        description: issue['msg'],
        severity: issue['type'],
        fingerprint: [origin, issue['code'], e['path']].join('|'),
      ))
      message.element = (element = Element.new(
        tag: e['tag'],
        path: e['path'],
        visibility: e['visibility'],
        display: e['display'],
        html: e['html'],
        top: e['top'],
        left: e['left'],
        bottom: e['bottom'],
        right: e['right'],
        x: e['x'],
        y: e['y'],
        width: e['width'],
        height: e['height']
      ))
    end
    page.save
  end
end