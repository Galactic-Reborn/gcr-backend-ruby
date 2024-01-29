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

ActiveRecord::Schema[7.1].define(version: 2024_01_28_104537) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "planets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name", default: ""
    t.datetime "last_updated"
    t.integer "planet_type"
    t.string "planet_image"
    t.integer "planet_diameter"
    t.integer "fields_current"
    t.integer "fields_max"
    t.integer "temp_min"
    t.integer "temp_max"
    t.integer "titanium"
    t.integer "auronium"
    t.integer "hydrogen"
    t.integer "energy"
    t.integer "energy_used"
    t.integer "energy_max"
    t.integer "stardust"
    t.integer "titanium_mine_percentage"
    t.integer "auronium_mine_percentage"
    t.integer "hydrogen_mine_percentage"
    t.integer "building_id"
    t.integer "building_end_time"
    t.boolean "building_demolition"
    t.json "hangar_queue"
    t.datetime "hangar_start_time"
    t.boolean "hangar_plus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_planets_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "address", default: "", null: false
    t.string "nonce"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "tech_id"
    t.integer "tech_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_users_on_address", unique: true
  end

  add_foreign_key "planets", "users"
end
