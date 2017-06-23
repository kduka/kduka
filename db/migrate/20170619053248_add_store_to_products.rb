class AddStoreToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :store, foreign_key: true
  end
end
