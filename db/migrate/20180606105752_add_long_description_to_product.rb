class AddLongDescriptionToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :long_description, :text
  end
end
