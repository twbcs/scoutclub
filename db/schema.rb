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

ActiveRecord::Schema.define(version: 20150420084830) do

  create_table "albums", force: :cascade do |t|
    t.string   "title",        limit: 255,               null: false
    t.text     "description",  limit: 65535
    t.integer  "view_count",   limit: 4,     default: 0, null: false
    t.datetime "public_at"
    t.datetime "add_photo_to"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "art_kinds", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",       limit: 255,   null: false
    t.text     "content",     limit: 65535, null: false
    t.integer  "user_id",     limit: 4
    t.integer  "art_kind_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "articles", ["art_kind_id"], name: "index_articles_on_art_kind_id", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "boards", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "subject",    limit: 255
    t.text     "content",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "boards", ["user_id"], name: "index_boards_on_user_id", using: :btree

  create_table "campings", force: :cascade do |t|
    t.string   "name",         limit: 255,   null: false
    t.string   "address",      limit: 255
    t.string   "area",         limit: 255,   null: false
    t.text     "description",  limit: 65535
    t.boolean  "water",        limit: 1
    t.boolean  "electric",     limit: 1
    t.boolean  "canopy",       limit: 1
    t.boolean  "check",        limit: 1
    t.boolean  "expense",      limit: 1
    t.boolean  "camping_area", limit: 1
    t.string   "url",          limit: 255
    t.string   "gmap",         limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",    limit: 65535, null: false
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "doing_kinds", force: :cascade do |t|
    t.string "title", limit: 255, null: false
  end

  create_table "forum_kinds", force: :cascade do |t|
    t.string "title",       limit: 255,   null: false
    t.text   "description", limit: 65535
  end

  create_table "forums", force: :cascade do |t|
    t.string   "title",         limit: 255,                  null: false
    t.text     "description",   limit: 65535
    t.integer  "forum_kind_id", limit: 4
    t.boolean  "lock",          limit: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "public_at",     limit: 1,     default: true
    t.date     "closing_date"
  end

  add_index "forums", ["forum_kind_id"], name: "index_forums_on_forum_kind_id", using: :btree

  create_table "group_forums", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "forum_id",   limit: 4
    t.integer  "level",      limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "group_forums", ["forum_id"], name: "index_group_forums_on_forum_id", using: :btree
  add_index "group_forums", ["group_id"], name: "index_group_forums_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string  "name",  limit: 255, null: false
    t.boolean "admin", limit: 1
  end

  create_table "members", force: :cascade do |t|
    t.integer  "th",         limit: 4
    t.string   "name",       limit: 255, null: false
    t.string   "nname",      limit: 255
    t.string   "fname",      limit: 255
    t.boolean  "sex",        limit: 1
    t.integer  "year",       limit: 2,                unsigned: true
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "modifies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "user_rule",  limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "modifies", ["user_id"], name: "index_modifies_on_user_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 255
    t.integer  "user_id",     limit: 4
    t.boolean  "public_is",   limit: 1
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "movies", ["user_id"], name: "index_movies_on_user_id", using: :btree

  create_table "musics", force: :cascade do |t|
    t.string   "file",        limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "musics", ["user_id"], name: "index_musics_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "album_id",   limit: 4
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "forum_id",    limit: 4,                 null: false
    t.string   "subject",     limit: 255,               null: false
    t.text     "body",        limit: 65535,             null: false
    t.integer  "reply_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "lock_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "type",        limit: 255
    t.integer  "view_count",  limit: 4,     default: 0, null: false
    t.datetime "update_post"
    t.boolean  "first_post",  limit: 1
  end

  add_index "posts", ["forum_id"], name: "index_posts_on_forum_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "schedule_attends", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "schedule_id", limit: 4
    t.integer  "level",       limit: 1
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "schedule_attends", ["schedule_id"], name: "index_schedule_attends_on_schedule_id", using: :btree
  add_index "schedule_attends", ["user_id"], name: "index_schedule_attends_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.string   "title",         limit: 255,   null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "public_at"
    t.string   "local",         limit: 255
    t.integer  "number",        limit: 2,                  unsigned: true
    t.integer  "doing_kind_id", limit: 4
    t.text     "description",   limit: 65535, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "schedules", ["doing_kind_id"], name: "index_schedules_on_doing_kind_id", using: :btree

  create_table "title_ths", force: :cascade do |t|
    t.integer  "member_id",  limit: 4, null: false
    t.integer  "title_id",   limit: 4, null: false
    t.integer  "title_year", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "title_ths", ["member_id"], name: "index_title_ths_on_member_id", using: :btree
  add_index "title_ths", ["title_id"], name: "index_title_ths_on_title_id", using: :btree

  create_table "titles", force: :cascade do |t|
    t.string   "title",       limit: 255,   null: false
    t.text     "description", limit: 65535
    t.integer  "level",       limit: 1,                  unsigned: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "uid",                    limit: 255, default: "", null: false
    t.string   "provider",               limit: 255, default: "", null: false
    t.string   "name",                   limit: 255,              null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
