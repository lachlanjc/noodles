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

ActiveRecord::Schema.define(version: 20151107162129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "announcements", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "body"
    t.text     "body_rendered"
    t.integer  "author_id"
    t.boolean  "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shared_id",          limit: 255
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "pages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.text     "content_raw"
    t.string   "shared_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "pages", ["shared_id"], name: "index_pages_on_shared_id", using: :btree
  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.text     "description"
    t.text     "ingredients"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "favorite"
    t.string   "img_file_name",         limit: 255
    t.string   "img_content_type",      limit: 255
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.text     "instructions_rendered"
    t.boolean  "shared"
    t.string   "source",                limit: 255
    t.text     "notes"
    t.string   "serves",                limit: 255
    t.string   "shared_id",             limit: 255
    t.text     "collections",                       default: [], array: true
    t.string   "author",                limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "referring_url"
    t.text     "landing_url"
    t.string   "first_name",             limit: 255
    t.boolean  "newsletter_sent"
    t.boolean  "want_newsletter"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "pages", "users"
end
