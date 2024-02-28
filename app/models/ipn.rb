# == Schema Information
#
# Table name: ipns
#
#  id                :integer          not null, primary key
#  BusinessShortCode :string
#  InvoiceNumber     :string
#  KYCName           :string
#  KYCValue          :string
#  MSISDN            :string
#  ThirdPartyTransID :string
#  TransAmount       :integer
#  TransID           :string
#  TransTime         :string
#  bill_ref_no       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Ipn < ApplicationRecord
end
