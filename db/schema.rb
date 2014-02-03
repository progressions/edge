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

ActiveRecord::Schema.define(version: 20140203003449) do

  create_table "characters", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "player_name"
    t.string   "gender"
    t.string   "age"
    t.string   "height"
    t.string   "build"
    t.string   "hair"
    t.string   "eyes"
    t.text     "notable_features"
    t.integer  "credits"
  end

  create_table "ranks", force: true do |t|
    t.integer  "value"
    t.string   "source"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "guest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
