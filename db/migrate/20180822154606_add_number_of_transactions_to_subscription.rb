class AddNumberOfTransactionsToSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :number_of_transactions, :integer, :default => 0
  end
end
