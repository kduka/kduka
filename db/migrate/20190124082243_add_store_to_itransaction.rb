class AddStoreToItransaction < ActiveRecord::Migration[5.0]
  def change
    add_reference :itransactions, :store, foreign_key: true
  end
end
