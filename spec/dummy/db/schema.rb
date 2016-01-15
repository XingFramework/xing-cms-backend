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

ActiveRecord::Schema.define(version: 20160115014524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "xing_cms_backend_content_blocks", force: :cascade do |t|
    t.string   "content_type"
    t.text     "body"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "xing_cms_backend_menu_items", force: :cascade do |t|
    t.string   "name"
    t.string   "path"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xing_cms_backend_page_contents", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "content_block_id"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "xing_cms_backend_page_contents", ["content_block_id"], name: "index_page_contents_on_content_block_id", using: :btree
  add_index "xing_cms_backend_page_contents", ["page_id"], name: "index_page_contents_on_page_id", using: :btree

  create_table "xing_cms_backend_pages", force: :cascade do |t|
    t.string   "title"
    t.boolean  "published",        default: true, null: false
    t.text     "keywords"
    t.text     "description"
    t.datetime "edited_at"
    t.string   "type"
    t.datetime "publish_start"
    t.datetime "publish_end"
    t.hstore   "metadata"
    t.string   "url_slug"
    t.datetime "publication_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "xing_cms_backend_pages", ["url_slug"], name: "index_pages_on_url_slug", using: :btree

end
