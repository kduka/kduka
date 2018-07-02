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

ActiveRecord::Schema.define(version: 20180625123944) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "ahoy_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "ahoy_visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.integer  "user_id"
    t.string   "ip"
    t.text     "user_agent",       limit: 65535
    t.text     "referrer",         limit: 65535
    t.string   "referring_domain"
    t.text     "landing_page",     limit: 65535
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

  create_table "business_to_consumers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "store_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.boolean  "featured"
    t.index ["store_id"], name: "index_categories_on_store_id", using: :btree
  end

  create_table "coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "earnings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "trans_id"
    t.integer  "store_id"
    t.integer  "amount"
    t.string   "ref"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "transaction_status_id"
    t.index ["store_id"], name: "index_earnings_on_store_id", using: :btree
    t.index ["transaction_status_id"], name: "index_earnings_on_transaction_status_id", using: :btree
  end

  create_table "fonts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ipns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "layouts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "d_name"
    t.string   "preview"
  end

  create_table "order_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 12, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "order_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "subtotal",                             precision: 12, scale: 3
    t.decimal  "tax",                                  precision: 12, scale: 3
    t.decimal  "shipping",                             precision: 12, scale: 3
    t.decimal  "total",                                precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref"
    t.integer  "store_id"
    t.text     "order_instructions",     limit: 65535
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
    t.boolean  "coupon_status",                                                 default: false
    t.string   "address"
    t.integer  "discount",                                                      default: 0
    t.boolean  "read",                                                          default: false
    t.datetime "date_placed"
    t.string   "delivery_code"
    t.datetime "ship_date"
    t.datetime "complete_date"
    t.date     "date_placed2"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
    t.index ["store_id"], name: "index_orders_on_store_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.decimal  "price",                          precision: 12, scale: 3
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "category_id"
    t.string   "image"
    t.integer  "quantity"
    t.string   "sku"
    t.text     "description",      limit: 65535
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
    t.boolean  "discount_status",                                         default: false
    t.text     "long_description", limit: 65535
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["store_id"], name: "index_products_on_store_id", using: :btree
  end

  create_table "store_amounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "store_id"
    t.integer  "amount",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "actual",            default: 0
    t.integer  "lifetime_earnings", default: 0
    t.index ["store_id"], name: "index_store_amounts_on_store_id", using: :btree
  end

  create_table "store_deliveries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "store_id"
    t.string   "delivery_areas"
    t.integer  "price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["store_id"], name: "index_store_deliveries_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                      default: "",    null: false
    t.string   "encrypted_password",                         default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_id"
    t.boolean  "active"
    t.string   "username"
    t.string   "name"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
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
    t.text     "aboutpage_text",               limit: 65535
    t.boolean  "contactpage_status"
    t.string   "banner"
    t.string   "logo"
    t.text     "business_location",            limit: 65535
    t.boolean  "logo_status"
    t.string   "store_color"
    t.boolean  "manual_delivery_status"
    t.text     "manual_delivery_instructions", limit: 65535
    t.boolean  "collection_point_status"
    t.string   "auto_delivery_location"
    t.boolean  "init"
    t.boolean  "important"
    t.string   "store_font"
    t.string   "lat"
    t.string   "lng"
    t.string   "domain"
    t.boolean  "own_domain",                                 default: false
    t.string   "c_subdomain"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "gtag",                         limit: 65535
    t.index ["confirmation_token"], name: "index_stores_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_stores_on_email", unique: true, using: :btree
    t.index ["layout_id"], name: "index_stores_on_layout_id", using: :btree
    t.index ["reset_password_token"], name: "index_stores_on_reset_password_token", unique: true, using: :btree
    t.index ["subdomain"], name: "index_stores_on_subdomain", unique: true, using: :btree
    t.index ["user_id"], name: "index_stores_on_user_id", using: :btree
  end

  create_table "sub_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "category_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id", using: :btree
  end

  create_table "transaction_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "amount"
    t.integer  "store_id"
    t.integer  "balance"
    t.string   "trans_type"
    t.string   "name"
    t.string   "ref"
    t.string   "account"
    t.string   "bankcode"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "foreign_ref"
    t.integer  "transaction_status_id"
    t.index ["store_id"], name: "index_transactions_on_store_id", using: :btree
    t.index ["transaction_status_id"], name: "index_transactions_on_transaction_status_id", using: :btree
  end

  create_table "unresolveds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "transid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  add_foreign_key "ahoy_events", "stores"
  add_foreign_key "ahoy_visits", "stores"
  add_foreign_key "categories", "stores"
  add_foreign_key "coupons", "stores"
  add_foreign_key "earnings", "stores"
  add_foreign_key "earnings", "transaction_statuses"
  add_foreign_key "orders", "stores"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "stores"
  add_foreign_key "store_amounts", "stores"
  add_foreign_key "store_deliveries", "stores"
  add_foreign_key "stores", "layouts"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "transactions", "stores"
  add_foreign_key "transactions", "transaction_statuses"
end
