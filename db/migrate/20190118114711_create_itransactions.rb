class CreateItransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :itransactions do |t|
      t.string :status
      t.string :text
      t.string :reference
      t.string :timestamp

      t.timestamps
    end
  end
end
