class AddDisplayEmailToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :display_email, :string
  end
end
