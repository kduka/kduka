class AddPreviewToLayout < ActiveRecord::Migration[5.0]
  def change
    add_column :layouts, :preview, :string
  end
end
