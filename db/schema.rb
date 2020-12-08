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

ActiveRecord::Schema.define(version: 2020_12_07_215439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charge_moves", force: :cascade do |t|
    t.string "name"
    t.integer "damage"
    t.integer "energy"
    t.string "effect"
    t.integer "pve_damage"
    t.integer "pve_energy"
    t.float "pve_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_id"
    t.index ["type_id"], name: "index_charge_moves_on_type_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fast_moves", force: :cascade do |t|
    t.string "name"
    t.integer "turns"
    t.integer "damage"
    t.integer "energy"
    t.integer "pve_damage"
    t.integer "pve_energy"
    t.float "pve_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_id"
    t.index ["type_id"], name: "index_fast_moves_on_type_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name"
    t.integer "attack"
    t.integer "defence"
    t.integer "stamina"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.bigint "evolves_from_id"
    t.bigint "primary_type_id"
    t.bigint "secondary_type_id"
    t.index ["evolves_from_id"], name: "index_forms_on_evolves_from_id"
    t.index ["pokemon_id"], name: "index_forms_on_pokemon_id"
    t.index ["primary_type_id"], name: "index_forms_on_primary_type_id"
    t.index ["secondary_type_id"], name: "index_forms_on_secondary_type_id"
  end

  create_table "generations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medals", force: :cascade do |t|
    t.string "name"
    t.integer "bronze"
    t.integer "silver"
    t.integer "gold"
    t.integer "platinum"
    t.string "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_charge_moves", force: :cascade do |t|
    t.boolean "legacy"
    t.boolean "elite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.bigint "charge_move_id"
    t.index ["charge_move_id"], name: "index_pokemon_charge_moves_on_charge_move_id"
    t.index ["pokemon_id"], name: "index_pokemon_charge_moves_on_pokemon_id"
  end

  create_table "pokemon_fast_moves", force: :cascade do |t|
    t.boolean "legacy"
    t.boolean "elite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.bigint "fast_move_id"
    t.index ["fast_move_id"], name: "index_pokemon_fast_moves_on_fast_move_id"
    t.index ["pokemon_id"], name: "index_pokemon_fast_moves_on_pokemon_id"
  end

  create_table "pokemon_levels", force: :cascade do |t|
    t.float "level"
    t.integer "stardust"
    t.integer "candy"
    t.integer "candy_xl"
    t.float "cp_multiplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.integer "attack"
    t.integer "defence"
    t.integer "stamina"
    t.integer "buddy_distance"
    t.integer "evolve_candy"
    t.boolean "trade_discount"
    t.string "evolve_requirement"
    t.boolean "gender_variant"
    t.boolean "legendary"
    t.boolean "mythical"
    t.string "gendered"
    t.string "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "evolves_from_id"
    t.bigint "generation_id"
    t.bigint "family_id"
    t.bigint "primary_type_id"
    t.bigint "secondary_type_id"
    t.index ["evolves_from_id"], name: "index_pokemons_on_evolves_from_id"
    t.index ["family_id"], name: "index_pokemons_on_family_id"
    t.index ["generation_id"], name: "index_pokemons_on_generation_id"
    t.index ["primary_type_id"], name: "index_pokemons_on_primary_type_id"
    t.index ["secondary_type_id"], name: "index_pokemons_on_secondary_type_id"
  end

  create_table "type_interactions", force: :cascade do |t|
    t.float "multiplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "attacking_type_id"
    t.bigint "defending_type_id"
    t.index ["attacking_type_id"], name: "index_type_interactions_on_attacking_type_id"
    t.index ["defending_type_id"], name: "index_type_interactions_on_defending_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.text "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "charge_moves", "types"
  add_foreign_key "fast_moves", "types"
  add_foreign_key "forms", "pokemons"
  add_foreign_key "pokemon_charge_moves", "charge_moves"
  add_foreign_key "pokemon_charge_moves", "pokemons"
  add_foreign_key "pokemon_fast_moves", "fast_moves"
  add_foreign_key "pokemon_fast_moves", "pokemons"
  add_foreign_key "pokemons", "families"
  add_foreign_key "pokemons", "generations"
end
