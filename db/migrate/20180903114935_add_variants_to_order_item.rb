class AddVariantsToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :variants, :text
  end
end
