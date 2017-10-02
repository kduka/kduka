class AddLogoStatusToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :logo_status, :boolean
  end
end
