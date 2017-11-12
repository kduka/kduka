class AddLogolocationToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :logo, :string
    add_column :stores, :business_location, :text
  end
end
