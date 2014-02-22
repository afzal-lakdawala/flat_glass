class Core < ActiveRecord::Migration
  def change
      
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

  end
end
