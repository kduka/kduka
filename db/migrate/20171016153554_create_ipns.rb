class CreateIpns < ActiveRecord::Migration[5.0]
  def change
    create_table :ipns do |t|
      t.string :MSISDN
      t.string :BusinessShortCode
      t.string :InvoiceNumber
      t.string :TransID
      t.integer :TransAmount
      t.string :ThirdPartyTransID
      t.string :TransTime
      t.string :KYCName
      t.string :KYCValue

      t.timestamps
    end
  end
end
