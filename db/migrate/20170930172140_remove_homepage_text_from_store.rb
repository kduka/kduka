class RemoveHomepageTextFromStore < ActiveRecord::Migration[5.0]
  def change
    remove_column :stores, :homepage_text
  end
end
