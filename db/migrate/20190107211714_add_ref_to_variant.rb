class AddRefToVariant < ActiveRecord::Migration[5.0]
  def change
    add_column :variants, :ref, :string
  end
end
