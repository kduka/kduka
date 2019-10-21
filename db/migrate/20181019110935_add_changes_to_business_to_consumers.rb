class AddChangesToBusinessToConsumers < ActiveRecord::Migration[5.0]
  def change
    add_column :business_to_consumers, :ResponseCode, :string
    add_column :business_to_consumers, :ResponseDesc, :string
    add_column :business_to_consumers, :ResultCode, :string
    add_column :business_to_consumers, :ResultDesc, :string
    add_column :business_to_consumers, :TransactionID, :string
    add_column :business_to_consumers, :TransactionReceipt, :string
  end
end
