class AddReceivedToSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :received, :integer, :default => 0
  end
end
