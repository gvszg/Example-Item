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

ActiveRecord::Schema.define(version: 20160321083224) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.integer  "status",     limit: 4,   default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "categories", ["deleted_at"], name: "index_categories_on_deleted_at", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_id",           limit: 255, null: false
    t.string   "data_filename",     limit: 255, null: false
    t.integer  "data_size",         limit: 4
    t.string   "data_content_type", limit: 255
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "counties", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.integer  "item_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "item_categories", ["category_id"], name: "index_item_categories_on_category_id", using: :btree
  add_index "item_categories", ["deleted_at"], name: "index_item_categories_on_deleted_at", using: :btree
  add_index "item_categories", ["item_id"], name: "index_item_categories_on_item_id", using: :btree

  create_table "item_specs", force: :cascade do |t|
    t.integer  "item_id",      limit: 4
    t.string   "style",        limit: 255
    t.integer  "style_amount", limit: 4
    t.string   "style_pic",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_specs", ["item_id"], name: "index_item_specs_on_item_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name",        limit: 255,               null: false
    t.integer  "price",       limit: 4,                 null: false
    t.string   "slug",        limit: 255
    t.integer  "status",      limit: 4,     default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "description", limit: 65535
  end

  add_index "items", ["deleted_at"], name: "index_items_on_deleted_at", using: :btree

  create_table "order_infos", force: :cascade do |t|
    t.integer  "order_id",        limit: 4
    t.string   "ship_name",       limit: 255
    t.string   "ship_address",    limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "ship_store_code", limit: 4
    t.string   "ship_phone",      limit: 255
    t.integer  "ship_store_id",   limit: 4
  end

  add_index "order_infos", ["order_id"], name: "index_order_infos_on_order_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",      limit: 4
    t.integer  "item_quantity", limit: 4
    t.string   "item_name",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "item_price",    limit: 4
    t.string   "item_style",    limit: 255
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "total",          limit: 4,   default: 0
    t.boolean  "is_paid",                    default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "status",         limit: 4,   default: 0
    t.string   "payment_method", limit: 255
    t.string   "token",          limit: 255
    t.string   "uid",            limit: 255
    t.integer  "ship_fee",       limit: 4
    t.integer  "items_price",    limit: 4
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "item_id",     limit: 4
    t.string   "image",       limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_intro", limit: 255
  end

  add_index "photos", ["deleted_at"], name: "index_photos_on_deleted_at", using: :btree

  create_table "roads", force: :cascade do |t|
    t.integer  "town_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "county_id",  limit: 4
    t.integer  "town_id",    limit: 4
    t.integer  "road_id",    limit: 4
    t.integer  "store_type", limit: 4
    t.string   "store_code", limit: 255
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
  end

  create_table "towns", force: :cascade do |t|
    t.integer  "county_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name",  limit: 255
    t.string   "real_name",  limit: 255
    t.string   "gender",     limit: 255
    t.string   "address",    limit: 255
    t.string   "uid",        limit: 255
    t.string   "phone",      limit: 255
    t.integer  "status",     limit: 4,   default: 1
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree

end
