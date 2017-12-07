class AddDomainParamsToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :domain, :string
    add_column :stores, :own_domain, :boolean, :default => false
  end
end
