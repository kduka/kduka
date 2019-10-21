class AddPremiumExpiryToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :premiumexpiry, :date
  end
end
