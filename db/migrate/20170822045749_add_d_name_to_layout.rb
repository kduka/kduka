class AddDNameToLayout < ActiveRecord::Migration[5.0]
  def change
    add_column :layouts, :d_name, :string
  end
end
