class AddRemarkToBusinessToConsumer < ActiveRecord::Migration[5.0]
  def change
    add_column :business_to_consumers, :Remark, :string
  end
end
