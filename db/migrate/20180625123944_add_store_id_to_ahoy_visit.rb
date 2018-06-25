class AddStoreIdToAhoyVisit < ActiveRecord::Migration[5.0]
  def change
    add_reference :ahoy_visits, :store, foreign_key: true, :default=>nil
  end
end
