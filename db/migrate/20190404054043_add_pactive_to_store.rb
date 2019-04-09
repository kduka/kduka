class AddPactiveToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :p_active, :boolean
  end
end
