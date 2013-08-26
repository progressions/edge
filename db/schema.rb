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

ActiveRecord::Schema.define(version: 20130826034206) do

  create_table "characters", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brawn",       default: 0, null: false
    t.integer  "agility",     default: 0, null: false
    t.integer  "intellect",   default: 0, null: false
    t.integer  "cunning",     default: 0, null: false
    t.integer  "presence",    default: 0, null: false
    t.integer  "unused_xp"
    t.integer  "used_xp"
  end

  create_table "obligations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "amount"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "guest"
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

end
