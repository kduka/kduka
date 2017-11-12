class AddStoreFontToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :store_font, :string
  end
end
