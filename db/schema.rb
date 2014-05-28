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

ActiveRecord::Schema.define(version: 20140527235022) do

  create_table "admins", force: true do |t|
    t.integer  "user_id"
    t.integer  "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bann_lists", force: true do |t|
    t.integer "user_id"
  end

  create_table "battles", force: true do |t|
    t.string  "winner"
    t.integer "oponent_id"
    t.string  "oponent_type"
    t.integer "robot_id"
    t.string  "combat_log"
  end

  create_table "items", force: true do |t|
    t.string  "name"
    t.integer "price"
  end

  create_table "messages", force: true do |t|
    t.string   "from_user"
    t.string   "to_user"
    t.string   "title"
    t.text     "content"
    t.datetime "published_at"
    t.boolean  "unread"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobs", force: true do |t|
    t.integer "talent_points"
    t.string  "name"
    t.integer "level"
    t.integer "robot_id"
    t.string  "picture"
    t.boolean "lost",          default: false
  end

  create_table "pictures", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "resources", force: true do |t|
    t.integer "gold",        default: 200
    t.integer "electricity", default: 600
    t.integer "oil",         default: 150
    t.integer "cristals",    default: 3
    t.integer "user_id"
  end

  create_table "robots", force: true do |t|
    t.integer "level",                default: 1
    t.integer "current_experience",   default: 1
    t.integer "max_experience",       default: 200
    t.integer "user_id"
    t.integer "unused_talent_points", default: 10
    t.integer "used_talent_points",   default: 0
    t.integer "max_health",           default: 1000
    t.boolean "in_fight",             default: false
    t.integer "current_health",       default: 1000
    t.string  "name"
  end

  create_table "stats", force: true do |t|
    t.integer "strength",      default: 23
    t.integer "agility",       default: 18
    t.integer "intelligence",  default: 20
    t.integer "stamina",       default: 33
    t.integer "defence",       default: 100
    t.integer "armor",         default: 100
    t.integer "attack",        default: 200
    t.integer "statable_id"
    t.string  "statable_type"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",                null: false
    t.string   "username",               default: "",                null: false
    t.string   "encrypted_password",     default: "",                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                 null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture",                default: "profile-img.png"
    t.datetime "last_request_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
