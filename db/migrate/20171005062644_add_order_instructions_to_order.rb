class AddOrderInstructionsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_instructions, :text
  end
end
