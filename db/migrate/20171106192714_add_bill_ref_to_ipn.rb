class AddBillRefToIpn < ActiveRecord::Migration[5.0]
  def change
    add_column :ipns, :bill_ref_no, :string
  end
end
