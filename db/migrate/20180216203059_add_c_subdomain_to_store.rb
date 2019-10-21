class AddCSubdomainToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :c_subdomain, :string
  end
end
