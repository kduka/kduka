class AddDatePlaced2ToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :date_placed2, :date
  end
end
