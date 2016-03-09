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

ActiveRecord::Schema.define(version: 20160309124617) do

  create_table "analyze_titles", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "word1"
    t.string   "word2"
    t.string   "word3"
    t.string   "word4"
    t.string   "word5"
    t.string   "word6"
    t.string   "word7"
    t.string   "word8"
    t.string   "word9"
    t.string   "word10"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "word11"
    t.string   "word12"
  end

  create_table "archives", force: :cascade do |t|
    t.string   "title"
    t.string   "ref"
    t.time     "time"
    t.integer  "source_id",   default: 0
    t.string   "summary"
    t.integer  "category_id", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levenstein_pages", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "count",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "levpages", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "count",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "newslasts", force: :cascade do |t|
    t.integer  "source_id"
    t.integer  "page_id"
    t.string   "title"
    t.string   "ref"
    t.time     "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "ref"
    t.time     "time"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "source_id",   default: 0
    t.string   "summary"
    t.integer  "category_id", default: 0
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.string   "ref"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
