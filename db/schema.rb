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

ActiveRecord::Schema.define(version: 20170504031917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string   "start_date"
    t.integer  "camper_id"
    t.integer  "host_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "end_date"
    t.boolean  "is_accepted"
    t.boolean  "is_answered"
    t.integer  "group_size"
    t.boolean  "pets_or_kids"
    t.index ["camper_id"], name: "index_bookings_on_camper_id", using: :btree
    t.index ["host_id"], name: "index_bookings_on_host_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "yard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body"
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
    t.index ["yard_id"], name: "index_comments_on_yard_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "message"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
    t.index ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.integer  "age"
    t.text     "bio"
    t.boolean  "is_hosting"
    t.boolean  "is_traveling"
    t.text     "gear"
    t.string   "password_digest"
  end

  create_table "yards", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "zipcode"
    t.text     "description"
    t.integer  "rating"
    t.integer  "r_count"
    t.integer  "safety"
    t.boolean  "kid_and_pet_friendly"
    t.index ["user_id"], name: "index_yards_on_user_id", using: :btree
  end

  add_foreign_key "comments", "users"
  add_foreign_key "comments", "yards"
  add_foreign_key "yards", "users"
end
