class AddGtagToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :gtag, :text, :default => nil
    Store.all.update_all gtag: nil
  end
end
