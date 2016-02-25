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

ActiveRecord::Schema.define(version: 20160225221530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "twitter_mbs", force: :cascade do |t|
    t.integer  "twittersearch_id"
    t.string   "personality_type"
    t.float    "value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "twitter_mbs", ["twittersearch_id"], name: "index_twitter_mbs_on_twittersearch_id", using: :btree

  create_table "twittersearches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "tweeter"
    t.float    "sentiment"
    t.float    "personality_agreeableness"
    t.float    "personality_conscientiousness"
    t.float    "personality_extraversion"
    t.float    "personality_openness"
    t.float    "political_conservative"
    t.float    "political_green"
    t.float    "political_liberal"
    t.float    "political_libertarian"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "twittersearches", ["user_id"], name: "index_twittersearches_on_user_id", using: :btree

  create_table "twittertopics", force: :cascade do |t|
    t.integer  "twittersearch_id"
    t.string   "topic"
    t.float    "value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "twittertopics", ["twittersearch_id"], name: "index_twittertopics_on_twittersearch_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "fname"
    t.string   "lname"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "twitter_mbs", "twittersearches"
  add_foreign_key "twittersearches", "users"
  add_foreign_key "twittertopics", "twittersearches"
end
