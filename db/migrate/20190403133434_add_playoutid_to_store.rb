class AddPlayoutidToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :p_layout_id, :integer
  end
end
