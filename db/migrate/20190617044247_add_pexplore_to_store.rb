class AddPexploreToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :p_explore, :boolean
  end
end
