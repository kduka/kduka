class AddStoreIdToAhoyEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :ahoy_events, :store, foreign_key: true, :default => nil
  end
end
