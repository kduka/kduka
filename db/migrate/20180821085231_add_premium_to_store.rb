class AddPremiumToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :premium, :boolean
    Store.all.update_all premium: false
  end
end
