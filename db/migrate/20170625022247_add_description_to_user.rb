class AddDescriptionToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :string
  end
end
