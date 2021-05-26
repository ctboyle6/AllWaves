# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_26_153143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.jsonb "conditions_json"
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_conditions_on_spot_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.string "name"
    t.string "pref_unit"
    t.string "pref_tide_position"
    t.float "pref_tide_range"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "swell_hgt_min"
    t.float "swell_hgt_max"
    t.float "swell_int_min"
    t.float "swell_int_max"
    t.float "swell_dir_min"
    t.float "swell_dir_max"
    t.float "wind_str_min"
    t.float "wind_str_max"
    t.float "wind_dir_min"
    t.float "wind_dir_max"
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "surfline_spot"
    t.string "surfline_subregion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_spots", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_user_spots_on_spot_id"
    t.index ["user_id"], name: "index_user_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "location"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "conditions", "spots"
  add_foreign_key "preferences", "users"
  add_foreign_key "user_spots", "spots"
  add_foreign_key "user_spots", "users"
end
