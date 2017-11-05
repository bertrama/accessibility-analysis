class CreateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :elements do |t|
      t.string :visibility
      t.string :display
      t.string :tag
      t.string :path
      t.text :html
      t.integer :top
      t.integer :left
      t.integer :bottom
      t.integer :right
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height
      t.belongs_to :message

      t.timestamps
    end
  end
end
