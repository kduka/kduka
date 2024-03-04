# == Schema Information
#
# Table name: iipns
#
#  id             :integer          not null, primary key
#  afd            :string
#  agt            :string
#  card_mask      :string
#  channel        :string
#  hsh            :string
#  ifd            :string
#  ivm            :string
#  mc             :string
#  msisdn_custnum :string
#  msisdn_idnum   :string
#  p1             :string
#  p2             :string
#  p3             :string
#  p4             :string
#  poi            :string
#  qwh            :string
#  status         :string
#  tokenemail     :string
#  tokenid        :string
#  txncd          :string
#  uyt            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  msisdn_id      :string
#  trans_id       :string
#
class Iipn < ApplicationRecord
end
