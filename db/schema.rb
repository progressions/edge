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

ActiveRecord::Schema.define(version: 20130914174526) do

  create_table "career_joins", force: true do |t|
    t.integer  "career_id"
    t.string   "career_skills"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "careers", force: true do |t|
    t.string   "name"
    t.string   "career_skills"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brawn",            default: 0, null: false
    t.integer  "agility",          default: 0, null: false
    t.integer  "intellect",        default: 0, null: false
    t.integer  "cunning",          default: 0, null: false
    t.integer  "willpower",        default: 0, null: false
    t.integer  "presence",         default: 0, null: false
    t.integer  "unused_xp",        default: 0, null: false
    t.integer  "used_xp",          default: 0, null: false
    t.integer  "party_size"
    t.integer  "base_obligation"
    t.integer  "wound_threshold"
    t.integer  "strain_threshold"
    t.integer  "career_join_id"
    t.integer  "species_join_id"
  end

  create_table "obligations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "amount"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "character_id"
    t.string   "name"
    t.integer  "rank"
    t.boolean  "career"
    t.boolean  "species"
    t.string   "characteristic"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specialization_joins", force: true do |t|
    t.integer  "character_id"
    t.integer  "specialization_id"
    t.string   "career_skills"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specialization_joins", ["character_id"], name: "index_specialization_joins_on_character_id", using: :btree
  add_index "specialization_joins", ["specialization_id"], name: "index_specialization_joins_on_specialization_id", using: :btree

  create_table "specializations", force: true do |t|
    t.string   "name"
    t.string   "career_skills"
    t.integer  "career_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species", force: true do |t|
    t.string   "name"
    t.integer  "brawn"
    t.integer  "agility"
    t.integer  "intellect"
    t.integer  "cunning"
    t.integer  "willpower"
    t.integer  "presence"
    t.integer  "unused_xp"
    t.integer  "wound_threshold_modifier"
    t.integer  "strain_threshold_modifier"
    t.integer  "optional_skills_count"
    t.string   "starting_skills"
    t.string   "optional_skills"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species_joins", force: true do |t|
    t.integer  "species_id"
    t.string   "species_skills"
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
