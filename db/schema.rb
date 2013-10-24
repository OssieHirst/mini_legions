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

ActiveRecord::Schema.define(version: 20131024151223) do

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
  end

  add_index "collections", ["miniature_id"], name: "index_collections_on_miniature_id"
  add_index "collections", ["progress"], name: "index_collections_on_progress"
  add_index "collections", ["status"], name: "index_collections_on_status"
  add_index "collections", ["user_id", "miniature_id"], name: "index_collections_on_user_id_and_miniature_id"
  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "manufacturers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "productions", force: true do |t|
    t.integer  "miniature_id"
    t.integer  "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "productions", ["manufacturer_id"], name: "index_productions_on_manufacturer_id"
  add_index "productions", ["miniature_id", "manufacturer_id"], name: "index_productions_on_miniature_id_and_manufacturer_id", unique: true
  add_index "productions", ["miniature_id"], name: "index_productions_on_miniature_id"

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
  end

  add_index "sculptings", ["miniature_id", "sculptor_id"], name: "index_sculptings_on_miniature_id_and_sculptor_id", unique: true
  add_index "sculptings", ["miniature_id"], name: "index_sculptings_on_miniature_id"
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
  end

  add_index "sizes", ["miniature_id"], name: "index_sizes_on_miniature_id"
  add_index "sizes", ["scale_id"], name: "index_sizes_on_scale_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
