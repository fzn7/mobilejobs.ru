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

ActiveRecord::Schema.define(version: 20150927163357) do

  create_table "entries", force: :cascade do |t|
    t.string   "entry_id"
    t.integer  "feed_id"
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.text     "description_html"
    t.datetime "published_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "entries", ["entry_id"], name: "index_entries_on_entry_id"
  add_index "entries", ["feed_id"], name: "index_entries_on_feed_id"

  create_table "feeds", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vacancies", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "company"
    t.string   "url"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "owner_token"
    t.date     "expire_at"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_token"
    t.text     "excerpt_html"
    t.text     "description_html"
    t.string   "location"
  end

  add_index "vacancies", ["admin_token"], name: "index_vacancies_on_admin_token"
  add_index "vacancies", ["approved_at"], name: "index_vacancies_on_approved_at"
  add_index "vacancies", ["created_at"], name: "index_vacancies_on_created_at"
  add_index "vacancies", ["expire_at"], name: "index_vacancies_on_expire_at"
  add_index "vacancies", ["owner_token"], name: "index_vacancies_on_owner_token"

end
