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

ActiveRecord::Schema.define(version: 20140208170902) do

  create_table "backgrounds", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

  create_table "careers", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "skill_keys"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizables", force: true do |t|
    t.integer  "category_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_careers", force: true do |t|
    t.integer  "character_id"
    t.integer  "career_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_duties", force: true do |t|
    t.integer  "character_id"
    t.integer  "duty_id"
    t.integer  "size"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_obligations", force: true do |t|
    t.integer  "character_id"
    t.integer  "obligation_id"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  create_table "character_skills", force: true do |t|
    t.integer  "character_id"
    t.integer  "skill_id"
    t.boolean  "career"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_specializations", force: true do |t|
    t.integer  "character_id"
    t.integer  "specialization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_species", force: true do |t|
    t.integer  "character_id"
    t.integer  "species_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characteristics", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.integer  "character_id"
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
    t.integer  "first_specialization_id"
  end

  create_table "duties", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duty_options", force: true do |t|
    t.integer  "character_id"
    t.integer  "starting_size"
    t.boolean  "plus_five_xp"
    t.boolean  "plus_ten_xp"
    t.boolean  "plus_thousand_credits"
    t.boolean  "plus_two_thousand_five_hundred_credits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "obligation_options", force: true do |t|
    t.integer  "character_id"
    t.integer  "starting_size"
    t.boolean  "plus_five_xp"
    t.boolean  "plus_ten_xp"
    t.boolean  "plus_thousand_credits"
    t.boolean  "plus_two_thousand_five_hundred_credits"
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

  create_table "rankables", force: true do |t|
    t.integer  "rank_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: true do |t|
    t.integer  "amount"
    t.string   "source"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parent_type"
  end

  create_table "skills", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.string   "source"
    t.string   "char_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "skill_type"
  end

  create_table "social_classes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specializations", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.string   "source"
    t.boolean  "universal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "career_id"
    t.string   "skill_keys"
  end

  create_table "species", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.integer  "brawn"
    t.integer  "agility"
    t.integer  "intellect"
    t.integer  "cunning"
    t.integer  "willpower"
    t.integer  "presence"
    t.integer  "wound_threshold"
    t.integer  "strain_threshold"
    t.integer  "starting_xp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "guest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", force: true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "navicomputer"
    t.string   "sensor_range"
    t.string   "crew"
    t.integer  "encumbrance_capacity"
    t.integer  "passengers"
    t.string   "consummables"
    t.integer  "silhouette"
    t.integer  "speed"
    t.integer  "handling"
    t.integer  "def_fore"
    t.integer  "def_aft"
    t.integer  "def_port"
    t.integer  "def_starboard"
    t.integer  "armor"
    t.integer  "hull_trauma"
    t.integer  "system_strain"
    t.integer  "hp"
    t.integer  "price"
    t.integer  "rarity"
    t.string   "source"
    t.string   "vehicle_type"
  end

  create_table "weapons", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.string   "skill_key"
    t.integer  "damage"
    t.integer  "crit"
    t.string   "range"
    t.integer  "encumbrance"
    t.integer  "hp"
    t.integer  "price"
    t.integer  "rarity"
    t.string   "weapon_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "damage_add"
    t.string   "source"
  end

end
