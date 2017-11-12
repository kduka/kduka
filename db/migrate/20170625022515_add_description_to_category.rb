class AddDescriptionToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :description, :string
  end
end
