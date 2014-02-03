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

ActiveRecord::Schema.define(version: 20140203181121) do

  create_table "backgrounds", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

  create_table "character_obligations", force: true do |t|
    t.integer  "character_id"
    t.integer  "obligation_id"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "used_experience"
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.text     "story"
    t.integer  "social_class_id"
    t.integer  "background_id"
  end

  create_table "experience_ranks", force: true do |t|
    t.integer  "character_id"
    t.integer  "amount"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "obligations", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_classes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "key"
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
