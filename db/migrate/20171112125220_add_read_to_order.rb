class AddReadToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :read, :boolean, :default => false
  end
end
