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

ActiveRecord::Schema.define(version: 20171104160851) do

  create_table "analyses", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "content"
    t.integer "pages_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "screenshot_file_name"
    t.string "screenshot_content_type"
    t.integer "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.index ["pages_id"], name: "index_analyses_on_pages_id"
  end

  create_table "elements", force: :cascade do |t|
    t.string "visibility"
    t.string "display"
    t.string "tag"
    t.string "path"
    t.text "html"
    t.integer "top"
    t.integer "left"
    t.integer "bottom"
    t.integer "right"
    t.integer "x"
    t.integer "y"
    t.integer "width"
    t.integer "height"
    t.integer "messages_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["messages_id"], name: "index_elements_on_messages_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "identifier"
    t.string "type"
    t.text "description"
    t.integer "analyses_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fingerprint"
    t.index ["analyses_id"], name: "index_messages_on_analyses_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
