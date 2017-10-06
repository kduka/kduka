class AddUniqueIndexToStore < ActiveRecord::Migration[5.0]
  def change
    add_index :stores, :subdomain, unique: true
  end
end
