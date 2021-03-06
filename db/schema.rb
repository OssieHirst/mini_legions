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

ActiveRecord::Schema.define(version: 20150212173754) do

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.integer  "miniature_id"
    t.string   "status"
    t.string   "progress"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "name"
    t.string   "notes"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imagevotes_count",    default: 0
    t.boolean  "is_gold",             default: false
    t.boolean  "is_silver",           default: false
    t.boolean  "conversion",          default: false
    t.string   "painter",             default: "owner"
    t.integer  "ml_painter_id"
    t.string   "non_ml_painter_name"
  end

  add_index "collections", ["imagevotes_count"], name: "index_collections_on_imagevotes_count"
  add_index "collections", ["is_gold"], name: "index_collections_on_is_gold"
  add_index "collections", ["is_silver"], name: "index_collections_on_is_silver"
  add_index "collections", ["miniature_id"], name: "index_collections_on_miniature_id"
  add_index "collections", ["ml_painter_id"], name: "index_collections_on_ml_painter_id"
  add_index "collections", ["progress"], name: "index_collections_on_progress"
  add_index "collections", ["status"], name: "index_collections_on_status"
  add_index "collections", ["user_id", "miniature_id"], name: "index_collections_on_user_id_and_miniature_id"
  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "contents", force: true do |t|
    t.integer  "miniset_id"
    t.integer  "setmini_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["miniset_id", "setmini_id"], name: "index_contents_on_miniset_id_and_setmini_id", unique: true
  add_index "contents", ["miniset_id"], name: "index_contents_on_miniset_id"
  add_index "contents", ["setmini_id"], name: "index_contents_on_setmini_id"

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.string   "nature"
    t.string   "content"
    t.string   "url"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "imagevotes", force: true do |t|
    t.integer  "collection_id"
    t.integer  "voter_id"
    t.integer  "voted_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "miniature_id"
  end

  add_index "imagevotes", ["collection_id"], name: "index_imagevotes_on_collection_id"
  add_index "imagevotes", ["miniature_id", "voter_id"], name: "index_imagevotes_on_miniature_id_and_voter_id", unique: true
  add_index "imagevotes", ["miniature_id"], name: "index_imagevotes_on_miniature_id"
  add_index "imagevotes", ["voted_id"], name: "index_imagevotes_on_voted_id"
  add_index "imagevotes", ["voter_id"], name: "index_imagevotes_on_voter_id"

  create_table "lines", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manufacturer_id"
  end

  add_index "lines", ["ancestry"], name: "index_lines_on_ancestry"
  add_index "lines", ["manufacturer_id"], name: "index_lines_on_manufacturer_id"

  create_table "manufacturers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "description"
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
    t.text     "notes"
    t.boolean  "set",                    default: false
    t.boolean  "random",                 default: false
    t.integer  "quantity"
    t.integer  "date_mask",              default: 0
    t.boolean  "multipart",              default: false
    t.string   "unpainted_file_name"
    t.string   "unpainted_content_type"
    t.integer  "unpainted_file_size"
    t.datetime "unpainted_updated_at"
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
    t.text     "biog",       limit: 255
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
    t.boolean  "contributor",            default: false
    t.boolean  "superadmin",             default: false
    t.integer  "voted_count",            default: 0
    t.integer  "vote_count",             default: 0
    t.datetime "last_seen"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["vote_count"], name: "index_users_on_vote_count"
  add_index "users", ["voted_count"], name: "index_users_on_voted_count"

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.text     "comment"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
