# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120310131041) do

  create_table "holidays", :force => true do |t|
    t.date     "date"
    t.text     "note"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_templates", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "no_shows", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
    t.integer  "position"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "press_id"
    t.date     "date"
    t.integer  "hour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cancelled",  :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "perishable_token",  :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "work_days", :force => true do |t|
    t.integer  "start_hour"
    t.integer  "end_hour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_number"
  end

end
