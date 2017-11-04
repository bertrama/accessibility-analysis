class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analysis do |t|
      t.string :title
      t.string :url
      t.text :content
      t.belongs_to :pages, index: true

      t.timestamps
    end
  end
end
