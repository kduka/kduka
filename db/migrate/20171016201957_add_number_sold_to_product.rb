class AddNumberSoldToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :number_sold, :integer
  end
end
