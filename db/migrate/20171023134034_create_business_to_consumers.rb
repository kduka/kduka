class CreateBusinessToConsumers < ActiveRecord::Migration[5.0]
  def change
    create_table :business_to_consumers do |t|
      t.string :Trans_Id
      t.string :Type
      t.string :CompanyId
      t.string :CompanyDesc
      t.string :Remarks
      t.string :CallbackURL
      t.string :IPNEnabled
      t.string :IPNDataFormat
      t.string :IPNDataFormatDesc
      t.string :IsDelivered
      t.string :Type
      t.string :TypeDesc
      t.string :Payee
      t.string :PrimaryAccountNumber
      t.string :Amount
      t.string :BankCode
      t.string :MCCMNC
      t.string :MCCMNCDesc
      t.string :Reference
      t.string :SystemTraceAuditNUmber
      t.string :Status
      t.string :StatusDesc
      t.string :B2MResponseCode
      t.string :B2MResponseDesc
      t.string :B2MResultCode
      t.string :B2MResultDesc
      t.string :B2MTransactionID
      t.string :TransactionDateTime
      t.string :WorkingAccountAvailableFunds
      t.string :UtilityAccountAvailableFunds
      t.string :ChargePaidAccountAvailableFunds
      t.string :WalletAccountAvailableFunds
      t.string :TransactionCreditParty
      t.string :IPNStatus
      t.string :IPNStatusDesc
      t.string :IPNResponse

      t.timestamps
    end
  end
end
