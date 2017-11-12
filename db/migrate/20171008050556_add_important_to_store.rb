class AddImportantToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :important, :boolean
  end
end
