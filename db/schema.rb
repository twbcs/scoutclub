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

ActiveRecord::Schema.define(version: 20140915155512) do

  create_table "boards", force: true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doing_types", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_types", force: true do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", force: true do |t|
    t.string   "title",                   null: false
    t.text     "description"
    t.integer  "forum_type_id"
    t.integer  "see_level",     limit: 1, null: false
    t.integer  "create_level",  limit: 1, null: false
    t.integer  "manage_level",  limit: 1, null: false
    t.integer  "school_level",  limit: 2, null: false
    t.boolean  "lock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "th"
    t.string   "name",                 null: false
    t.string   "nname"
    t.string   "fname"
    t.boolean  "sex"
    t.integer  "year",       limit: 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "forum_id",   null: false
    t.string   "subject",    null: false
    t.text     "body",       null: false
    t.integer  "post_id"
    t.integer  "user_id"
    t.boolean  "lock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_attends", force: true do |t|
    t.integer  "user_id"
    t.integer  "schedule_id"
    t.integer  "level",       limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "title",                   null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "public_at"
    t.string   "local"
    t.integer  "number",        limit: 2
    t.integer  "doing_type_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "title_ths", force: true do |t|
    t.integer  "member_id",  null: false
    t.integer  "title_id",   null: false
    t.integer  "title_year", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", force: true do |t|
    t.string   "title",                 null: false
    t.text     "description"
    t.integer  "level",       limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
