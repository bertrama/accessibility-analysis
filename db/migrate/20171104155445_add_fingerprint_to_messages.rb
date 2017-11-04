class AddFingerprintToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :fingerprint, :string
  end
end
