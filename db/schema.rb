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

ActiveRecord::Schema.define(version: 20170114204604) do

  create_table "assignments", force: :cascade do |t|
    t.string   "notes"
    t.string   "person_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "ordinance_id"
    t.integer  "status_id"
    t.index ["contact_id"], name: "index_assignments_on_contact_id"
    t.index ["ordinance_id"], name: "index_assignments_on_ordinance_id"
    t.index ["status_id"], name: "index_assignments_on_status_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "person_id",  null: false
    t.string   "comments",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_nm",   null: false
    t.string   "last_nm",    null: false
    t.string   "email"
    t.string   "phone"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "ordinances", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "url"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.string "url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",        null: false
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
