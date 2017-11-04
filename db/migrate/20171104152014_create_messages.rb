class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :identifier
      t.string :type
      t.text :description
      t.belongs_to :analysis, index: true

      t.timestamps
    end
  end
end
