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

ActiveRecord::Schema.define(version: 20150820173638) do

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  add_index "categories_products", ["category_id"], name: "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], name: "index_categories_products_on_product_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.string   "shipping"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status",                default: "pending"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.integer  "cc4",         limit: 8
    t.datetime "expiry_date"
    t.integer  "zipcode"
    t.string   "city"
    t.string   "state"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "description"
    t.integer  "stock",       default: 0
    t.string   "photo_url"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "status"
    t.string   "weight"
    t.string   "dimensions"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.string   "text_review"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
  end

end
