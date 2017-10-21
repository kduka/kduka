class AddViewedToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :viewed, :integer
  end
end
