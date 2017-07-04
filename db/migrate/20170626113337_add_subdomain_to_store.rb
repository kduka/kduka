class AddSubdomainToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :subdomain, :string
  end
end
