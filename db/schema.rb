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

ActiveRecord::Schema.define(version: 20160627123359) do

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
    t.integer  "count"
  end

  create_table "infos", force: :cascade do |t|
    t.integer  "source_id"
    t.datetime "data"
    t.integer  "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "page_count"
    t.integer  "tag_count"
    t.integer  "tagging"
  end

  add_index "infos", ["source_id", "data"], name: "index_infos_on_source_id_and_data", unique: true

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
    t.datetime "time"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "source_id",   default: 0
    t.string   "summary"
    t.integer  "category_id", default: 0
    t.string   "tagtitle"
    t.string   "image"
  end

  create_table "sourcehtmls", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "url"
    t.string   "common1"
    t.string   "common2"
    t.string   "common3"
    t.string   "common4"
    t.string   "common5"
    t.string   "common6"
    t.string   "common7"
    t.string   "common8"
    t.string   "common9"
    t.string   "common10"
    t.string   "title"
    t.string   "ref"
    t.string   "time"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "summary"
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
    t.integer  "count"
    t.text     "type"
    t.boolean  "html"
  end

  create_table "tagexcepts", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tagexcepts", ["name"], name: "index_tagexcepts_on_name", unique: true

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

  add_index "tagoverlaps", ["name"], name: "index_tagoverlaps_on_name", unique: true
  add_index "tagoverlaps", ["nametarget"], name: "index_tagoverlaps_on_nametarget"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
