# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160511180112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "serial_number"
    t.boolean  "in_stock",      default: true
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["order_id"], name: "index_articles_on_order_id", using: :btree
    t.index ["product_id"], name: "index_articles_on_product_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.decimal  "account_balance", precision: 15, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "items", force: :cascade do |t|
    t.decimal  "unit_price", precision: 15, scale: 2
    t.integer  "quantity",                            default: 1
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["order_id"], name: "index_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_items_on_product_id", using: :btree
  end

  create_table "movements", force: :cascade do |t|
    t.decimal  "ammount",    precision: 15, scale: 2
    t.integer  "order_id"
    t.integer  "client_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["client_id"], name: "index_movements_on_client_id", using: :btree
    t.index ["order_id"], name: "index_movements_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.date     "date"
    t.integer  "client_id"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["client_id"], name: "index_orders_on_client_id", using: :btree
    t.index ["provider_id"], name: "index_orders_on_provider_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "image_uid"
    t.string   "status"
    t.text     "description"
    t.integer  "package_quantity"
    t.decimal  "price",            precision: 15, scale: 2
    t.decimal  "package_price",    precision: 15, scale: 2
    t.integer  "provider_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["provider_id"], name: "index_products_on_provider_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "articles", "products"
  add_foreign_key "items", "orders"
  add_foreign_key "items", "products"
  add_foreign_key "movements", "clients"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "providers"
  add_foreign_key "products", "providers"
end
