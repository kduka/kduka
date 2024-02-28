# == Schema Information
#
# Table name: invoices
#
#  id              :integer          not null, primary key
#  amount          :integer
#  currency        :string
#  deliveries      :boolean
#  description     :text
#  due             :date
#  firt_del        :boolean
#  from            :date
#  invoice         :string
#  issued          :date
#  name            :string
#  second_del      :boolean
#  subtotal        :integer
#  tax             :integer
#  to              :date
#  uid             :string
#  url             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  i_id            :string
#  order_status_id :integer
#  store_id        :integer
#  subscription_id :integer
#
# Indexes
#
#  index_invoices_on_order_status_id  (order_status_id)
#  index_invoices_on_store_id         (store_id)
#  index_invoices_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (store_id => stores.id)
#  fk_rails_...  (subscription_id => subscriptions.id)
#
require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
