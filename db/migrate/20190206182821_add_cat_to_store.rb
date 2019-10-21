class AddCatToStore < ActiveRecord::Migration[5.0]
  def change
    add_reference :stores, :cat, foreign_key: true
  end
end
