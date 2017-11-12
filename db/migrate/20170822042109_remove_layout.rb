class RemoveLayout < ActiveRecord::Migration[5.0]
  def change
    remove_column :stores, :layout
  end
end
