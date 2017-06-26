class RemoveDescriptionToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :description, :string
  end
end
