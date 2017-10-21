class AddDetailsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :email, :string
    add_column :orders, :phone, :string
    add_column :orders, :name, :string
  end
end
