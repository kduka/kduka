class CreateSubCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.boolean :active
      t.references :category, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
