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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131001130537) do

  create_table "core_visits", :force => true do |t|
    t.integer  "current_user_id"
    t.string   "visitable_type"
    t.integer  "visitable_id"
    t.text     "path_from"
    t.text     "path_to"
    t.text     "http_method"
    t.string   "ip"
    t.string   "lang"
    t.text     "caller_host"
    t.boolean  "is_bot"
    t.text     "os"
    t.text     "os_version"
    t.text     "device_genre"
    t.text     "device_brand"
    t.text     "device_model"
    t.text     "browser"
    t.text     "browser_version"
    t.datetime "created_at",      :null => false
    t.text     "raw_user_agent"
    t.datetime "updated_at",      :null => false
    t.string   "browser_genre"
    t.string   "day_of_week"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.integer  "hour"
    t.integer  "account_id"
  end

  create_table "orders", :id => false, :force => true do |t|
    t.decimal "CUST_NR",      :precision => 20, :scale => 2
    t.decimal "NO_ORDERS",    :precision => 20, :scale => 2
    t.decimal "DAY",          :precision => 2,  :scale => 0
    t.decimal "MONTH",        :precision => 2,  :scale => 0
    t.decimal "YEAR",         :precision => 4,  :scale => 0
    t.decimal "AVG_MARGIN",   :precision => 5,  :scale => 2
    t.text    "SITE_CODE"
    t.text    "CUR_CODE"
    t.decimal "AVG_DEL_TIME", :precision => 20, :scale => 2
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email",                  :default => "", :null => false
    t.string   "slug"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.string   "authentication_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
