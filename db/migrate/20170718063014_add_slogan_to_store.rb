class AddSloganToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :slogan, :string
  end
end
