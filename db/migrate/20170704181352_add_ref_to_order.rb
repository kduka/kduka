class AddRefToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ref, :string
  end
end
