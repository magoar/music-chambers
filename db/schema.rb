# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_09_101350) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "festivals", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.integer "slots_per_day"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rehearsals_per_group"
    t.index ["user_id"], name: "index_festivals_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "festival_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["festival_id"], name: "index_groups_on_festival_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "musician_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["musician_id"], name: "index_members_on_musician_id"
  end

  create_table "musician_requirements", force: :cascade do |t|
    t.bigint "musician_id", null: false
    t.bigint "requirement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musician_id"], name: "index_musician_requirements_on_musician_id"
    t.index ["requirement_id"], name: "index_musician_requirements_on_requirement_id"
  end

  create_table "musicians", force: :cascade do |t|
    t.string "name"
    t.string "instrument"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "festival_id", null: false
    t.index ["festival_id"], name: "index_musicians_on_festival_id"
  end

  create_table "rehearsals", force: :cascade do |t|
    t.date "rehearsal_date"
    t.time "start_time"
    t.bigint "festival_id", null: false
    t.bigint "room_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["festival_id"], name: "index_rehearsals_on_festival_id"
    t.index ["group_id"], name: "index_rehearsals_on_group_id"
    t.index ["room_id"], name: "index_rehearsals_on_room_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_requirements", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "requirement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_id"], name: "index_room_requirements_on_requirement_id"
    t.index ["room_id"], name: "index_room_requirements_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.bigint "festival_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["festival_id"], name: "index_rooms_on_festival_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "festivals", "users"
  add_foreign_key "groups", "festivals"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "musicians"
  add_foreign_key "musician_requirements", "musicians"
  add_foreign_key "musician_requirements", "requirements"
  add_foreign_key "musicians", "festivals"
  add_foreign_key "rehearsals", "festivals"
  add_foreign_key "rehearsals", "groups"
  add_foreign_key "rehearsals", "rooms"
  add_foreign_key "room_requirements", "requirements"
  add_foreign_key "room_requirements", "rooms"
  add_foreign_key "rooms", "festivals"
end
