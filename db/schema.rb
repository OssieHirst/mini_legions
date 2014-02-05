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

ActiveRecord::Schema.define(version: 20140205120206) do

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.integer  "miniature_id"
    t.string   "status"
    t.string   "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "name"
    t.string   "notes"
    t.string   "video"
  end

  add_index "collections", ["miniature_id"], name: "index_collections_on_miniature_id"
  add_index "collections", ["progress"], name: "index_collections_on_progress"
  add_index "collections", ["status"], name: "index_collections_on_status"
  add_index "collections", ["user_id", "miniature_id"], name: "index_collections_on_user_id_and_miniature_id"
  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "lines", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manufacturer_id"
    t.string   "slug"
  end

  add_index "lines", ["ancestry"], name: "index_lines_on_ancestry"
  add_index "lines", ["manufacturer_id"], name: "index_lines_on_manufacturer_id"
  add_index "lines", ["slug"], name: "index_lines_on_slug"

  create_table "manufacturers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "manufacturers", ["slug"], name: "index_manufacturers_on_slug"

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to"
  end

  add_index "microposts", ["reply_to"], name: "index_microposts_on_reply_to"
  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "miniatures", force: true do |t|
    t.string   "name"
    t.string   "material"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pcode"
    t.string   "notes"
  end

  add_index "miniatures", ["created_at"], name: "index_miniatures_on_created_at"
  add_index "miniatures", ["release_date"], name: "index_miniatures_on_release_date"

  create_table "minilines", force: true do |t|
    t.integer  "miniature_id"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "minilines", ["line_id"], name: "index_minilines_on_line_id"
  add_index "minilines", ["miniature_id", "line_id"], name: "index_minilines_on_miniature_id_and_line_id", unique: true
  add_index "minilines", ["miniature_id"], name: "index_minilines_on_miniature_id"

  create_table "minisets", force: true do |t|
    t.text     "name"
    t.string   "material"
    t.date     "release_date"
    t.string   "pcode"
    t.text     "notes"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "random",       default: false
  end

  add_index "minisets", ["created_at"], name: "index_minisets_on_created_at"
  add_index "minisets", ["quantity"], name: "index_minisets_on_quantity"
  add_index "minisets", ["release_date"], name: "index_minisets_on_release_date"

  create_table "paintingvotes", force: true do |t|
    t.integer  "miniature_id"
    t.integer  "set_id"
    t.integer  "collection_id"
    t.integer  "voter_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paintingvotes", ["collection_id"], name: "index_paintingvotes_on_collection_id"
  add_index "paintingvotes", ["miniature_id", "voter_id"], name: "index_paintingvotes_on_miniature_id_and_voter_id", unique: true
  add_index "paintingvotes", ["miniature_id"], name: "index_paintingvotes_on_miniature_id"
  add_index "paintingvotes", ["recipient_id"], name: "index_paintingvotes_on_recipient_id"
  add_index "paintingvotes", ["set_id"], name: "index_paintingvotes_on_set_id"
  add_index "paintingvotes", ["voter_id"], name: "index_paintingvotes_on_voter_id"

  create_table "productions", force: true do |t|
    t.integer  "miniature_id"
    t.integer  "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "miniset_id"
  end

  add_index "productions", ["manufacturer_id"], name: "index_productions_on_manufacturer_id"
  add_index "productions", ["miniature_id", "manufacturer_id"], name: "index_productions_on_miniature_id_and_manufacturer_id", unique: true
  add_index "productions", ["miniature_id"], name: "index_productions_on_miniature_id"
  add_index "productions", ["miniset_id", "manufacturer_id"], name: "index_productions_on_miniset_id_and_manufacturer_id", unique: true
  add_index "productions", ["miniset_id"], name: "index_productions_on_miniset_id"

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id"

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "scales", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sculptings", force: true do |t|
    t.integer  "sculptor_id"
    t.integer  "miniature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "miniset_id"
  end

  add_index "sculptings", ["miniature_id", "sculptor_id"], name: "index_sculptings_on_miniature_id_and_sculptor_id", unique: true
  add_index "sculptings", ["miniature_id"], name: "index_sculptings_on_miniature_id"
  add_index "sculptings", ["miniset_id", "sculptor_id"], name: "index_sculptings_on_miniset_id_and_sculptor_id", unique: true
  add_index "sculptings", ["miniset_id"], name: "index_sculptings_on_miniset_id"
  add_index "sculptings", ["sculptor_id"], name: "index_sculptings_on_sculptor_id"

  create_table "sculptors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "biog"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.integer  "miniature_id"
    t.integer  "scale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "miniset_id"
  end

  add_index "sizes", ["miniature_id"], name: "index_sizes_on_miniature_id"
  add_index "sizes", ["miniset_id", "scale_id"], name: "index_sizes_on_miniset_id_and_scale_id", unique: true
  add_index "sizes", ["miniset_id"], name: "index_sizes_on_miniset_id"
  add_index "sizes", ["scale_id"], name: "index_sizes_on_scale_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "username"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
