class AddImag1ToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :img1, :string
  end
end
