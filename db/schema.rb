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

ActiveRecord::Schema.define(version: 2021_05_30_152753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "conditions", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "timestamp"
    t.float "wind_strength"
    t.float "wind_direction"
    t.float "wind_gust"
    t.float "wind_optimal_score"
    t.float "waves_surf_min"
    t.float "waves_surf_max"
    t.float "waves_optimal_score"
    t.float "waves_swell_height"
    t.float "waves_swell_period"
    t.float "waves_swell_direction"
    t.float "waves_swell_direction_min"
    t.float "waves_swell_optimal_score"
    t.string "tide_type"
    t.float "tide_height"
    t.datetime "time_at"
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
    t.integer "utc_offset"
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
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "conditions", "spots"
  add_foreign_key "preferences", "users"
  add_foreign_key "user_spots", "spots"
  add_foreign_key "user_spots", "users"
end
