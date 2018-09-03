class CreateVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :variants do |t|
      t.references :product, foreign_key: true
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
