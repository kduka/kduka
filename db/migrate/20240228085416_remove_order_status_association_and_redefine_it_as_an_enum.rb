class RemoveOrderStatusAssociationAndRedefineItAsAnEnum < ActiveRecord::Migration[5.0]
  def change
    remove_reference :orders, :order_status, index: true
    add_column :orders, :status, :integer, default: 0
  end
end
