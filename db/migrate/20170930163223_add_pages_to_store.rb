class AddPagesToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :homepage_status, :boolean
    add_column :stores, :homepage_text, :string
    add_column :stores, :aboutpage_status, :boolean
    add_column :stores, :aboutpage_text, :string
    add_column :stores, :contactpage_status, :boolean
  end
end
