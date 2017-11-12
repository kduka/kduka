class AddPhoneToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :phone, :string
  end
end
