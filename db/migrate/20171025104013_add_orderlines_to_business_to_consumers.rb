class AddOrderlinesToBusinessToConsumers < ActiveRecord::Migration[5.0]
  def change
    add_column :business_to_consumers, :o_Type, :string
    add_column :business_to_consumers, :o_TypeDesc, :string
  end
end
