class AddSendyToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :sendy_username, :string
    add_column :stores, :sendy_key, :string
  end
end
