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

ActiveRecord::Schema.define(version: 20171005185642) do

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
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "store_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
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
    t.index ["store_id"], name: "index_coupons_on_store_id", using: :btree
  end

  create_table "deliveries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "layouts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "d_name"
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
    t.decimal  "subtotal",                         precision: 12, scale: 3
    t.decimal  "tax",                              precision: 12, scale: 3
    t.decimal  "shipping",                         precision: 12, scale: 3
    t.decimal  "total",                            precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref"
    t.integer  "store_id"
    t.text     "order_instructions", limit: 65535
    t.index ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
    t.index ["store_id"], name: "index_orders_on_store_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.decimal  "price",           precision: 12, scale: 3
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "category_id"
    t.string   "image"
    t.integer  "quantity"
    t.string   "sku"
    t.string   "description"
    t.string   "additional_info"
    t.string   "img1"
    t.integer  "width"
    t.integer  "length"
    t.integer  "height"
    t.integer  "weight"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["store_id"], name: "index_products_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                      default: "", null: false
    t.string   "encrypted_password",                         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_id"
    t.boolean  "active"
    t.string   "username"
    t.string   "name"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
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
    t.string   "auto_delivery_location"
    t.string   "lat"
    t.string   "lng"
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
    t.integer  "delivery_id"
    t.boolean  "collection_point_status"
    t.index ["delivery_id"], name: "index_stores_on_delivery_id", using: :btree
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "categories", "stores"
  add_foreign_key "coupons", "stores"
  add_foreign_key "orders", "stores"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "stores"
  add_foreign_key "stores", "deliveries"
  add_foreign_key "stores", "layouts"
  add_foreign_key "sub_categories", "categories"
end
