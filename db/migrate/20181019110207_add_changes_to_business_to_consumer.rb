class AddChangesToBusinessToConsumer < ActiveRecord::Migration[5.0]
  def change
    add_column :business_to_consumers, :RemitterName, :string
    add_column :business_to_consumers, :RemitterAddress, :string
    add_column :business_to_consumers, :RemitterPhoneNumber, :string
    add_column :business_to_consumers, :RemitterIDType, :string
    add_column :business_to_consumers, :RemitterIDNumber, :string
    add_column :business_to_consumers, :RemitterCountry, :string
    add_column :business_to_consumers, :RemitterCCY, :string
    add_column :business_to_consumers, :RemitterFinancialInstitution, :string
    add_column :business_to_consumers, :RemitterSourceOfFunds, :string
    add_column :business_to_consumers, :RecipientName, :string
    add_column :business_to_consumers, :RecipientAddress, :string
    add_column :business_to_consumers, :RecipientPhoneNumber, :string
    add_column :business_to_consumers, :RecipientIDType, :string
    add_column :business_to_consumers, :RecipientIDNumber, :string
    add_column :business_to_consumers, :PaymentPurpose, :string
    add_column :business_to_consumers, :RemitterPrincipalActivity, :string
    add_column :business_to_consumers, :PayeeAddress, :string
    add_column :business_to_consumers, :PayeeIDNumber, :string
  end
end
