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

ActiveRecord::Schema[7.1].define(version: 2024_05_20_164440) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "planet_id", null: false
    t.integer "titanium_foundry", default: 0
    t.integer "auronium_synthesizer", default: 0
    t.integer "hydrogen_extractor", default: 0
    t.integer "solar_array", default: 0
    t.integer "fusion_power_plant", default: 0
    t.integer "lunar_mine", default: 0
    t.integer "advanced_research_institute", default: 0
    t.integer "aerospace_yard", default: 0
    t.integer "geomorphological_reshaper", default: 0
    t.integer "robotics_workshop", default: 0
    t.integer "nano_assembly_factory", default: 0
    t.integer "auronium_repository", default: 0
    t.integer "hydrogen_tank", default: 0
    t.integer "titanium_depot", default: 0
    t.integer "star_ship_hangar", default: 0
    t.integer "missile_silo", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_buildings_on_planet_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.string "address", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "name", default: ""
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
    t.integer "last_updated", default: 0
    t.json "building_queue", default: {"queue"=>[]}
    t.uuid "universe_field_id"
    t.index ["universe_field_id"], name: "index_planets_on_universe_field_id"
    t.index ["user_id"], name: "index_planets_on_user_id"
  end

  create_table "universe_fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "pos_galaxy"
    t.integer "pos_system"
    t.integer "pos_planet"
    t.uuid "planet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_universe_fields_on_planet_id"
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
    t.string "jti", null: false
    t.index ["address"], name: "index_users_on_address", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
  end

  add_foreign_key "buildings", "planets"
  add_foreign_key "planets", "universe_fields"
  add_foreign_key "planets", "users"
  add_foreign_key "universe_fields", "planets"
end
