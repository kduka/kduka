class AddDatePlacedToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :date_placed, :datetime
  end
end
