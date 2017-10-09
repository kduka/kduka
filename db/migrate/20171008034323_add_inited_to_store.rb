class AddInitedToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :init, :boolean
  end
end
