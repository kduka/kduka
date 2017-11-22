class AddDatesToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ship_date, :datetime
    add_column :orders, :complete_date, :datetime
  end
end
