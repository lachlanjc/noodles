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

ActiveRecord::Schema.define(version: 20_171_124_044_323) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'announcements', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.text 'body'
    t.text 'body_rendered'
    t.integer 'author_id'
    t.boolean 'mail'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'collections', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.string 'photo_file_name'
    t.string 'photo_content_type'
    t.integer 'photo_file_size'
    t.datetime 'photo_updated_at'
    t.integer 'user_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'shared_id'
    t.index ['user_id'], name: 'index_collections_on_user_id'
  end

  create_table 'delayed_jobs', id: :serial, force: :cascade do |t|
    t.integer 'priority', default: 0, null: false
    t.integer 'attempts', default: 0, null: false
    t.text 'handler', null: false
    t.text 'last_error'
    t.datetime 'run_at'
    t.datetime 'locked_at'
    t.datetime 'failed_at'
    t.string 'locked_by'
    t.string 'queue'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w[priority run_at], name: 'delayed_jobs_priority'
  end

  create_table 'groceries', force: :cascade do |t|
    t.text 'name'
    t.datetime 'completed_at'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_groceries_on_user_id'
  end

  create_table 'recipes', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.text 'ingredients'
    t.text 'instructions'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'user_id'
    t.boolean 'favorite'
    t.string 'img_file_name'
    t.string 'img_content_type'
    t.integer 'img_file_size'
    t.datetime 'img_updated_at'
    t.text 'instructions_rendered'
    t.boolean 'shared'
    t.string 'source'
    t.text 'notes'
    t.string 'serves'
    t.string 'shared_id'
    t.text 'collections', default: [], array: true
    t.string 'author'
    t.datetime 'last_cooked_at'
    t.integer 'cooks_count', default: 0
  end

  create_table 'users', id: :serial, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.text 'referring_url'
    t.text 'landing_url'
    t.string 'first_name'
    t.boolean 'newsletter_sent'
    t.boolean 'want_newsletter'
    t.string 'stripe_customer'
    t.string 'stripe_subscription'
    t.datetime 'subscribed_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'groceries', 'users'
end
