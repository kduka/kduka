class AddStoreIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :store, foreign_key: true
  end
end
