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

ActiveRecord::Schema.define(version: 20170625022733) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "store_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.index ["store_id"], name: "index_categories_on_store_id", using: :btree
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
    t.decimal  "subtotal",        precision: 12, scale: 3
    t.decimal  "tax",             precision: 12, scale: 3
    t.decimal  "shipping",        precision: 12, scale: 3
    t.decimal  "total",           precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.decimal  "price",       precision: 12, scale: 3
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "category_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["store_id"], name: "index_products_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.integer  "user_id"
    t.boolean  "active"
    t.string   "username"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_stores_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_stores_on_reset_password_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_stores_on_user_id", using: :btree
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "categories", "stores"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "stores"
end
