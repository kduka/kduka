class ChangePagesstringsToText < ActiveRecord::Migration[5.0]
  def change
    change_column :stores, :homepage_text, :text
    change_column :stores, :aboutpage_text, :text
  end
end
