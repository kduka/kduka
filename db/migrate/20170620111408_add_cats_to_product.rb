class AddCatsToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :category, foreign_key: true
  end
end
