class AddSocialMediaToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :facebook, :string
    add_column :stores, :instagram, :string
    add_column :stores, :linkedin, :string
    add_column :stores, :twitter, :string
  end
end
