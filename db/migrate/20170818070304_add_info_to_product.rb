class AddInfoToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :additional_info, :string
  end
end
