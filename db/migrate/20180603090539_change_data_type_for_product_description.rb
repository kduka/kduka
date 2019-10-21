class ChangeDataTypeForProductDescription < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :description, :text
  end
end
