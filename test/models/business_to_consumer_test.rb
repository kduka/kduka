# == Schema Information
#
# Table name: business_to_consumers
#
#  id                              :integer          not null, primary key
#  Amount                          :string
#  B2MResponseCode                 :string
#  B2MResponseDesc                 :string
#  B2MResultCode                   :string
#  B2MResultDesc                   :string
#  B2MTransactionID                :string
#  BankCode                        :string
#  CallbackURL                     :string
#  ChargePaidAccountAvailableFunds :string
#  CompanyDesc                     :string
#  CompanyId                       :string
#  IPNDataFormat                   :string
#  IPNDataFormatDesc               :string
#  IPNEnabled                      :string
#  IPNResponse                     :string
#  IPNStatus                       :string
#  IPNStatusDesc                   :string
#  IsDelivered                     :string
#  MCCMNC                          :string
#  MCCMNCDesc                      :string
#  Payee                           :string
#  PayeeAddress                    :string
#  PayeeIDNumber                   :string
#  PaymentPurpose                  :string
#  PrimaryAccountNumber            :string
#  RecipientAddress                :string
#  RecipientIDNumber               :string
#  RecipientIDType                 :string
#  RecipientName                   :string
#  RecipientPhoneNumber            :string
#  Reference                       :string
#  Remark                          :string
#  Remarks                         :string
#  RemitterAddress                 :string
#  RemitterCCY                     :string
#  RemitterCountry                 :string
#  RemitterFinancialInstitution    :string
#  RemitterIDNumber                :string
#  RemitterIDType                  :string
#  RemitterName                    :string
#  RemitterPhoneNumber             :string
#  RemitterPrincipalActivity       :string
#  RemitterSourceOfFunds           :string
#  ResponseCode                    :string
#  ResponseDesc                    :string
#  ResultCode                      :string
#  ResultDesc                      :string
#  Status                          :string
#  StatusDesc                      :string
#  SystemTraceAuditNumber          :string
#  Trans_Id                        :string
#  TransactionCreditParty          :string
#  TransactionDateTime             :string
#  TransactionID                   :string
#  TransactionReceipt              :string
#  Type                            :string
#  TypeDesc                        :string
#  UtilityAccountAvailableFunds    :string
#  WalletAccountAvailableFunds     :string
#  WorkingAccountAvailableFunds    :string
#  o_Type                          :string
#  o_TypeDesc                      :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
require 'test_helper'

class BusinessToConsumerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
