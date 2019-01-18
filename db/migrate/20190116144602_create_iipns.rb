class CreateIipns < ActiveRecord::Migration[5.0]
  def change
    create_table :iipns do |t|
      t.string :txncd
      t.string :qwh
      t.string :afd
      t.string :poi
      t.string :uyt
      t.string :ifd
      t.string :agt
      t.string :trans_id
      t.string :status
      t.string :ivm
      t.string :mc
      t.string :p1
      t.string :p2
      t.string :p3
      t.string :p4
      t.string :msisdn_id
      t.string :msisdn_idnum
      t.string :msisdn_custnum
      t.string :channel
      t.string :tokenid
      t.string :tokenemail
      t.string :card_mask

      t.timestamps
    end
  end
end
