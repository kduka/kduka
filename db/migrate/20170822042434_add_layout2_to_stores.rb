class AddLayout2ToStores < ActiveRecord::Migration[5.0]
  def change
    add_reference :stores, :layout, foreign_key: true
  end
end
