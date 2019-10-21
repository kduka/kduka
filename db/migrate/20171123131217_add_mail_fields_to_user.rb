class AddMailFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :confirm_without_store, :datetime
    add_column :users, :store_not_active, :datetime
  end
end
