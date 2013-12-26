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

ActiveRecord::Schema.define(:version => 20131226133553) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "license"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.text     "api_token"
    t.text     "domain"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "accounts", ["slug"], :name => "index_accounts_on_slug"

  create_table "api_accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "api_oauth_id"
    t.string   "name"
    t.string   "api_profile_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "api_account_id"
  end

  create_table "api_filzs", :force => true do |t|
    t.integer  "data_filz_id"
    t.integer  "api_account_id"
    t.string   "api_account_name"
    t.text     "error_string"
    t.string   "status"
    t.datetime "last_requested_at"
    t.integer  "last_requested_by"
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "data_query_id"
  end

  create_table "api_oauths", :force => true do |t|
    t.string   "app"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "token_expires_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
  end

  create_table "cms_articles", :force => true do |t|
    t.integer  "account_id"
    t.string   "title"
    t.text     "description"
    t.date     "published_at"
    t.boolean  "is_published"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "slug"
  end

  add_index "cms_articles", ["slug"], :name => "index_cms_articles_on_slug"

  create_table "cms_images", :force => true do |t|
    t.integer  "account_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.string   "slug"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "image_file"
    t.string   "title"
    t.text     "url"
  end

  create_table "core_alerts", :force => true do |t|
    t.integer  "account_id"
    t.integer  "alertable_id"
    t.string   "alertable_type"
    t.string   "action"
    t.text     "description"
    t.integer  "updated_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "core_tags", :force => true do |t|
    t.integer  "account_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.string   "genre"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

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

  create_table "data_filz_columns", :force => true do |t|
    t.integer  "data_filz_id"
    t.string   "name"
    t.string   "datatype"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "data_filzs", :force => true do |t|
    t.integer  "account_id"
    t.string   "genre"
    t.string   "slug"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.string   "file_file_size"
    t.boolean  "is_pending"
    t.text     "content"
    t.text     "error_log"
    t.string   "category"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "commit_message"
  end

  add_index "data_filzs", ["slug"], :name => "index_data_filzs_on_slug"

  create_table "data_queries", :force => true do |t|
    t.string   "name"
    t.string   "source"
    t.text     "description"
    t.text     "metrics"
    t.text     "dimensions"
    t.text     "header_row"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "role"
    t.string   "email"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "permissions", ["account_id"], :name => "index_permissions_on_account_id"
  add_index "permissions", ["user_id"], :name => "index_permissions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email",                  :default => "", :null => false
    t.string   "slug"
    t.text     "bio"
    t.string   "time_zone"
    t.text     "url"
    t.string   "company"
    t.string   "location"
    t.string   "gravatar_email"
    t.string   "public_email"
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

  create_table "viz_charts", :force => true do |t|
    t.string   "name"
    t.string   "genre"
    t.text     "img"
    t.text     "mapping"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "viz_vizs", :force => true do |t|
    t.string   "title"
    t.integer  "data_filz_id"
    t.integer  "viz_chart_id"
    t.text     "map"
    t.text     "mapped_output"
    t.text     "settings"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "account_id"
    t.string   "slug"
  end

end
