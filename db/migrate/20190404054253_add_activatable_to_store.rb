class AddActivatableToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :activatable, :boolean
  end
end
