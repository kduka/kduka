# == Schema Information
#
# Table name: stores
#
#  id                           :integer          not null, primary key
#  aboutpage_status             :boolean
#  aboutpage_text               :text
#  activatable                  :boolean
#  active                       :boolean
#  auto_delivery_location       :string
#  auto_delivery_status         :boolean
#  banner                       :string
#  business_location            :text
#  c_subdomain                  :string
#  collection_point             :string
#  collection_point_status      :boolean
#  confirmation_sent_at         :datetime
#  confirmation_token           :string
#  confirmed_at                 :datetime
#  contactpage_status           :boolean
#  current_sign_in_at           :datetime
#  current_sign_in_ip           :string
#  display_email                :string
#  domain                       :string
#  email                        :string           default(""), not null
#  encrypted_password           :string           default(""), not null
#  explore                      :boolean
#  explore_image                :string
#  facebook                     :string
#  gtag                         :text
#  homepage_status              :boolean
#  important                    :boolean
#  init                         :boolean
#  instagram                    :string
#  last_sign_in_at              :datetime
#  last_sign_in_ip              :string
#  lat                          :string
#  linkedin                     :string
#  lng                          :string
#  logo                         :string
#  logo_status                  :boolean
#  manual_delivery_instructions :text
#  manual_delivery_status       :boolean
#  name                         :string
#  own_domain                   :boolean          default(FALSE)
#  p_active                     :boolean
#  p_explore                    :boolean
#  phone                        :string
#  pinterest                    :string
#  premium                      :boolean
#  premiumexpiry                :date
#  remember_created_at          :datetime
#  reset_password_sent_at       :datetime
#  reset_password_token         :string
#  sendy_key                    :string
#  sendy_username               :string
#  sign_in_count                :integer          default(0), not null
#  slogan                       :string
#  store_color                  :string
#  store_font                   :string
#  subdomain                    :string
#  trial                        :boolean
#  trial_end                    :date
#  trial_start                  :date
#  twitter                      :string
#  username                     :string
#  vimeo                        :string
#  youtube                      :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  cat_id                       :integer
#  layout_id                    :integer
#  p_layout_id                  :integer
#  plan_id                      :integer
#  shop_category_id             :integer
#  user_id                      :integer
#
# Indexes
#
#  index_stores_on_cat_id                (cat_id)
#  index_stores_on_confirmation_token    (confirmation_token) UNIQUE
#  index_stores_on_email                 (email) UNIQUE
#  index_stores_on_layout_id             (layout_id)
#  index_stores_on_plan_id               (plan_id)
#  index_stores_on_reset_password_token  (reset_password_token) UNIQUE
#  index_stores_on_shop_category_id      (shop_category_id)
#  index_stores_on_subdomain             (subdomain) UNIQUE
#  index_stores_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (cat_id => cats.id)
#  fk_rails_...  (layout_id => layouts.id)
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (shop_category_id => shop_categories.id)
#
require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
