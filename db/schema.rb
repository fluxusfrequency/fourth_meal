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

ActiveRecord::Schema.define(version: 20131217163850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "title",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
    t.string   "slug"
  end

  create_table "contacts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "comment"
  end

  create_table "item_categories", force: true do |t|
    t.integer  "item_id",     null: false
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_categories", ["category_id"], name: "index_item_categories_on_category_id", using: :btree
  add_index "item_categories", ["item_id"], name: "index_item_categories_on_item_id", using: :btree

  create_table "items", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",              precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "slug"
    t.boolean  "retired",                                     default: false
    t.integer  "restaurant_id"
  end

  add_index "items", ["restaurant_id"], name: "index_items_on_restaurant_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.text     "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "restaurant_users", force: true do |t|
    t.integer "restaurant_id"
    t.integer "user_id"
    t.string  "role",          default: "customer"
  end

  add_index "restaurant_users", ["user_id"], name: "index_restaurant_users_on_user_id", using: :btree

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      default: false
    t.string   "status",      default: "pending"
    t.string   "slug"
    t.integer  "location_id"
    t.string   "theme",       default: "application"
  end

  add_index "restaurants", ["location_id"], name: "index_restaurants_on_location_id", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.string   "stripe_token"
  end

  add_index "transactions", ["order_id"], name: "index_transactions_on_order_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "full_name"
    t.string   "display_name"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "super",         default: false
  end

end
