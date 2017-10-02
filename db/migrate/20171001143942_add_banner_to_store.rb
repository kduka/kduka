class AddBannerToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :banner, :string
  end
end
