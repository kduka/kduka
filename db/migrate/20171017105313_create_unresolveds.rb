class CreateUnresolveds < ActiveRecord::Migration[5.0]
  def change
    create_table :unresolveds do |t|
      t.string :transid

      t.timestamps
    end
  end
end
