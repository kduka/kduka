class AddStatusEnumToEarnings < ActiveRecord::Migration[5.0]
  def change
    add_column :earnings, :status, :integer, default: 0
  end
end
