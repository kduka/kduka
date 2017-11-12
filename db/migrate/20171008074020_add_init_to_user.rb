class AddInitToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :init, :boolean
  end
end
