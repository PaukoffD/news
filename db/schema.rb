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

ActiveRecord::Schema.define(version: 20160421180104) do

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
    t.string   "tagtitle"
  end

  add_index "pages", ["ref"], name: "index_pages_on_ref", unique: true

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

  create_table "tagexcepts", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tagoverlaps", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "name"
    t.integer  "tagtarget_id"
    t.string   "nametarget"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
