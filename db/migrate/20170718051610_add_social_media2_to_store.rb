class AddSocialMedia2ToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :pinterest, :string
    add_column :stores, :vimeo, :string
    add_column :stores, :youtube, :string
  end
end
