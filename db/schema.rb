# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20240307082058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.json     "properties"
    t.datetime "time"
    t.integer  "store_id"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time", using: :btree
    t.index ["store_id"], name: "index_ahoy_events_on_store_id", using: :btree
    t.index ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.integer  "user_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.string   "referring_domain"
    t.text     "landing_page"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
    t.integer  "store_id"
    t.index ["store_id"], name: "index_ahoy_visits_on_store_id", using: :btree
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id", using: :btree
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true, using: :btree
  end

  create_table "business_to_consumers", force: :cascade do |t|
    t.string   "Trans_Id"
    t.string   "Type"
    t.string   "CompanyId"
    t.string   "CompanyDesc"
    t.string   "Remarks"
    t.string   "CallbackURL"
    t.string   "IPNEnabled"
    t.string   "IPNDataFormat"
    t.string   "IPNDataFormatDesc"
    t.string   "IsDelivered"
    t.string   "TypeDesc"
    t.string   "Payee"
    t.string   "PrimaryAccountNumber"
    t.string   "Amount"
    t.string   "BankCode"
    t.string   "MCCMNC"
    t.string   "MCCMNCDesc"
    t.string   "Reference"
    t.string   "SystemTraceAuditNumber"
    t.string   "Status"
    t.string   "StatusDesc"
    t.string   "B2MResponseCode"
    t.string   "B2MResponseDesc"
    t.string   "B2MResultCode"
    t.string   "B2MResultDesc"
    t.string   "B2MTransactionID"
    t.string   "TransactionDateTime"
    t.string   "WorkingAccountAvailableFunds"
    t.string   "UtilityAccountAvailableFunds"
    t.string   "ChargePaidAccountAvailableFunds"
    t.string   "WalletAccountAvailableFunds"
    t.string   "TransactionCreditParty"
    t.string   "IPNStatus"
    t.string   "IPNStatusDesc"
    t.string   "IPNResponse"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "o_Type"
    t.string   "o_TypeDesc"
    t.string   "Remark"
    t.string   "RemitterName"
    t.string   "RemitterAddress"
    t.string   "RemitterPhoneNumber"
    t.string   "RemitterIDType"
    t.string   "RemitterIDNumber"
    t.string   "RemitterCountry"
    t.string   "RemitterCCY"
    t.string   "RemitterFinancialInstitution"
    t.string   "RemitterSourceOfFunds"
    t.string   "RecipientName"
    t.string   "RecipientAddress"
    t.string   "RecipientPhoneNumber"
    t.string   "RecipientIDType"
    t.string   "RecipientIDNumber"
    t.string   "PaymentPurpose"
    t.string   "RemitterPrincipalActivity"
    t.string   "PayeeAddress"
    t.string   "PayeeIDNumber"
    t.string   "ResponseCode"
    t.string   "ResponseDesc"
    t.string   "ResultCode"
    t.string   "ResultDesc"
    t.string   "TransactionID"
    t.string   "TransactionReceipt"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "store_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.boolean  "featured"
    t.index ["store_id"], name: "index_categories_on_store_id", using: :btree
  end

  create_table "cats", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "code"
    t.integer  "number_of_use"
    t.integer  "percentage"
    t.date     "expiry"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "active"
    t.integer  "amount"
    t.string   "coupon_type"
    t.index ["store_id"], name: "index_coupons_on_store_id", using: :btree
  end

  create_table "earnings", force: :cascade do |t|
    t.string   "trans_id"
    t.integer  "store_id"
    t.integer  "amount"
    t.string   "ref"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
    t.index ["store_id"], name: "index_earnings_on_store_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "store_id"
    t.text     "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_feedbacks_on_store_id", using: :btree
  end

  create_table "fonts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "iipns", force: :cascade do |t|
    t.string   "txncd"
    t.string   "qwh"
    t.string   "afd"
    t.string   "poi"
    t.string   "uyt"
    t.string   "ifd"
    t.string   "agt"
    t.string   "trans_id"
    t.string   "status"
    t.string   "ivm"
    t.string   "mc"
    t.string   "p1"
    t.string   "p2"
    t.string   "p3"
    t.string   "p4"
    t.string   "msisdn_id"
    t.string   "msisdn_idnum"
    t.string   "msisdn_custnum"
    t.string   "channel"
    t.string   "tokenid"
    t.string   "tokenemail"
    t.string   "card_mask"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "hsh"
  end

  create_table "invoices", force: :cascade do |t|
    t.date     "from"
    t.date     "to"
    t.string   "uid"
    t.integer  "store_id"
    t.integer  "amount"
    t.date     "issued"
    t.date     "due"
    t.integer  "tax"
    t.integer  "subtotal"
    t.string   "currency"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "subscription_id"
    t.string   "i_id"
    t.string   "invoice"
    t.boolean  "deliveries"
    t.boolean  "firt_del"
    t.boolean  "second_del"
    t.string   "url"
    t.string   "name"
    t.integer  "status",          default: 0
    t.index ["store_id"], name: "index_invoices_on_store_id", using: :btree
    t.index ["subscription_id"], name: "index_invoices_on_subscription_id", using: :btree
  end

  create_table "ipns", force: :cascade do |t|
    t.string   "MSISDN"
    t.string   "BusinessShortCode"
    t.string   "InvoiceNumber"
    t.string   "TransID"
    t.integer  "TransAmount"
    t.string   "ThirdPartyTransID"
    t.string   "TransTime"
    t.string   "KYCName"
    t.string   "KYCValue"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "bill_ref_no"
  end

  create_table "itransactions", force: :cascade do |t|
    t.string   "status"
    t.string   "text"
    t.string   "reference"
    t.string   "timestamp"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "amount"
    t.string   "balance_as_of_now"
    t.integer  "store_id"
    t.index ["store_id"], name: "index_itransactions_on_store_id", using: :btree
  end

  create_table "layouts", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "d_name"
    t.string   "preview"
    t.boolean  "premium",     default: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 12, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "variants"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 0
  end
  
  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",               precision: 12, scale: 3
    t.decimal  "tax",                    precision: 12, scale: 3
    t.decimal  "shipping",               precision: 12, scale: 3
    t.decimal  "total",                  precision: 12, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref"
    t.integer  "store_id"
    t.text     "order_instructions"
    t.integer  "amount_received"
    t.string   "email"
    t.string   "phone"
    t.string   "name"
    t.integer  "number_of_transactions"
    t.string   "delivery_type"
    t.string   "delivery_order"
    t.string   "del_location"
    t.string   "del_lat"
    t.string   "del_long"
    t.string   "coupon"
    t.boolean  "coupon_status",                                   default: false
    t.string   "address"
    t.integer  "discount",                                        default: 0
    t.boolean  "read",                                            default: false
    t.datetime "date_placed"
    t.string   "delivery_code"
    t.datetime "ship_date"
    t.datetime "complete_date"
    t.date     "date_placed2"
    t.integer  "status",                                          default: 0
    t.index ["store_id"], name: "index_orders_on_store_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",            precision: 12, scale: 3
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "category_id"
    t.string   "image"
    t.integer  "quantity"
    t.string   "sku"
    t.text     "description"
    t.string   "additional_info"
    t.string   "img1"
    t.integer  "width"
    t.integer  "length"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "number_sold"
    t.integer  "viewed"
    t.string   "img2"
    t.string   "img3"
    t.string   "img4"
    t.integer  "discount_price"
    t.boolean  "discount_status",                           default: false
    t.text     "long_description"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["store_id"], name: "index_products_on_store_id", using: :btree
  end

  create_table "shop_categories", force: :cascade do |t|
    t.string   "shop_category"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["shop_category"], name: "index_shop_categories_on_shop_category", unique: true, using: :btree
  end

  create_table "store_amounts", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "amount",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "actual",            default: 0
    t.integer  "lifetime_earnings", default: 0
    t.index ["store_id"], name: "index_store_amounts_on_store_id", using: :btree
  end

  create_table "store_deliveries", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "delivery_areas"
    t.integer  "price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["store_id"], name: "index_store_deliveries_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "email",                        default: "",    null: false
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_id"
    t.boolean  "active"
    t.string   "username"
    t.string   "name"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "subdomain"
    t.string   "phone"
    t.string   "display_email"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "pinterest"
    t.string   "vimeo"
    t.string   "youtube"
    t.string   "slogan"
    t.integer  "layout_id"
    t.boolean  "auto_delivery_status"
    t.string   "collection_point"
    t.string   "sendy_username"
    t.string   "sendy_key"
    t.boolean  "homepage_status"
    t.boolean  "aboutpage_status"
    t.text     "aboutpage_text"
    t.boolean  "contactpage_status"
    t.string   "banner"
    t.string   "logo"
    t.text     "business_location"
    t.boolean  "logo_status"
    t.string   "store_color"
    t.boolean  "manual_delivery_status"
    t.text     "manual_delivery_instructions"
    t.boolean  "collection_point_status"
    t.string   "auto_delivery_location"
    t.string   "lat"
    t.string   "lng"
    t.boolean  "init"
    t.boolean  "important"
    t.string   "store_font"
    t.string   "domain"
    t.boolean  "own_domain",                   default: false
    t.string   "c_subdomain"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "gtag"
    t.boolean  "premium"
    t.date     "premiumexpiry"
    t.integer  "cat_id"
    t.integer  "shop_category_id"
    t.boolean  "explore"
    t.string   "explore_image"
    t.boolean  "trial"
    t.date     "trial_start"
    t.date     "trial_end"
    t.integer  "p_layout_id"
    t.boolean  "p_active"
    t.boolean  "activatable"
    t.integer  "plan_id"
    t.boolean  "p_explore"
    t.index ["cat_id"], name: "index_stores_on_cat_id", using: :btree
    t.index ["confirmation_token"], name: "index_stores_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_stores_on_email", unique: true, using: :btree
    t.index ["layout_id"], name: "index_stores_on_layout_id", using: :btree
    t.index ["plan_id"], name: "index_stores_on_plan_id", using: :btree
    t.index ["reset_password_token"], name: "index_stores_on_reset_password_token", unique: true, using: :btree
    t.index ["shop_category_id"], name: "index_stores_on_shop_category_id", using: :btree
    t.index ["subdomain"], name: "index_stores_on_subdomain", unique: true, using: :btree
    t.index ["user_id"], name: "index_stores_on_user_id", using: :btree
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "category_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id", using: :btree
  end

  create_table "subscription_records", force: :cascade do |t|
    t.integer  "store_id"
    t.date     "start"
    t.date     "expire"
    t.integer  "subscription_id"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["store_id"], name: "index_subscription_records_on_store_id", using: :btree
    t.index ["subscription_id"], name: "index_subscription_records_on_subscription_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "amount"
    t.string   "ref"
    t.string   "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "received",               default: 0
    t.integer  "number_of_transactions", default: 0
    t.integer  "status",                 default: 0
    t.index ["store_id"], name: "index_subscriptions_on_store_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "store_id"
    t.integer  "balance"
    t.string   "trans_type"
    t.string   "name"
    t.string   "ref"
    t.string   "account"
    t.string   "bankcode"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "foreign_ref"
    t.integer  "status",      default: 0
    t.index ["store_id"], name: "index_transactions_on_store_id", using: :btree
  end

  create_table "unresolveds", force: :cascade do |t|
    t.string   "transid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "callback_url"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "name"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "init"
    t.datetime "confirm_without_store"
    t.datetime "store_not_active"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "variants", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ref"
    t.index ["product_id"], name: "index_variants_on_product_id", using: :btree
  end

  add_foreign_key "ahoy_events", "stores"
  add_foreign_key "ahoy_visits", "stores"
  add_foreign_key "categories", "stores"
  add_foreign_key "coupons", "stores"
  add_foreign_key "earnings", "stores"
  add_foreign_key "feedbacks", "stores"
  add_foreign_key "invoices", "stores"
  add_foreign_key "invoices", "subscriptions"
  add_foreign_key "itransactions", "stores"
  add_foreign_key "orders", "stores"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "stores"
  add_foreign_key "store_amounts", "stores"
  add_foreign_key "store_deliveries", "stores"
  add_foreign_key "stores", "cats"
  add_foreign_key "stores", "layouts"
  add_foreign_key "stores", "plans"
  add_foreign_key "stores", "shop_categories"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "subscription_records", "stores"
  add_foreign_key "subscription_records", "subscriptions"
  add_foreign_key "subscriptions", "stores"
  add_foreign_key "transactions", "stores"
  add_foreign_key "variants", "products"
end
