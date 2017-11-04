class AddScreenshotToAnalyses < ActiveRecord::Migration[5.1]
  def change
    add_attachment :analyses, :screenshot
  end
end
