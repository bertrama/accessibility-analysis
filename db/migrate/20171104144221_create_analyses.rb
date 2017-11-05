class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|
      t.string :title
      t.string :url
      t.text :content
      t.belongs_to :page, index: true

      t.timestamps
    end
  end
end
