class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.references :store, foreign_key: true
      t.text :feedback

      t.timestamps
    end
  end
end
