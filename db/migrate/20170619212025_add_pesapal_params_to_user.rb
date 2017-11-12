class AddPesapalParamsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :callback_url, :string
    add_column :users, :consumer_key, :string
    add_column :users, :consumer_secret, :string
  end
end
