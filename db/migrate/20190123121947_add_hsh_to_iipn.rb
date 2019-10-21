class AddHshToIipn < ActiveRecord::Migration[5.0]
  def change
    add_column :iipns, :hsh, :string
  end
end
