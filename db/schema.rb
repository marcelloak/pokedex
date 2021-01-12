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

ActiveRecord::Schema.define(version: 2021_01_12_201209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breakthrough_timelines", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_breakthrough_timelines_on_pokemon_id"
  end

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

  create_table "costume_caught_timelines", force: :cascade do |t|
    t.datetime "caught"
    t.integer "attack"
    t.integer "defence"
    t.integer "stamina"
    t.float "current_level"
    t.float "target_level"
    t.string "gender"
    t.boolean "shadow"
    t.boolean "purified"
    t.boolean "shiny"
    t.boolean "lucky"
    t.boolean "charge_move_unlocked"
    t.datetime "transferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_costume_id"
    t.bigint "target_costume_id"
    t.bigint "fast_move_id"
    t.bigint "first_charge_move_id"
    t.bigint "second_charge_move_id"
    t.bigint "original_owner_id"
    t.bigint "current_owner_id"
    t.bigint "current_level_id"
    t.bigint "target_level_id"
    t.boolean "high_iv"
    t.index ["current_costume_id"], name: "index_costume_caught_timelines_on_current_costume_id"
    t.index ["current_level_id"], name: "index_costume_caught_timelines_on_current_level_id"
    t.index ["current_owner_id"], name: "index_costume_caught_timelines_on_current_owner_id"
    t.index ["fast_move_id"], name: "index_costume_caught_timelines_on_fast_move_id"
    t.index ["first_charge_move_id"], name: "index_costume_caught_timelines_on_first_charge_move_id"
    t.index ["original_owner_id"], name: "index_costume_caught_timelines_on_original_owner_id"
    t.index ["second_charge_move_id"], name: "index_costume_caught_timelines_on_second_charge_move_id"
    t.index ["target_costume_id"], name: "index_costume_caught_timelines_on_target_costume_id"
    t.index ["target_level_id"], name: "index_costume_caught_timelines_on_target_level_id"
  end

  create_table "costume_event_pokemons", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "costume_id"
    t.bigint "event_timeline_id"
    t.index ["costume_id"], name: "index_costume_event_pokemons_on_costume_id"
    t.index ["event_timeline_id"], name: "index_costume_event_pokemons_on_event_timeline_id"
  end

  create_table "costume_raid_timelines", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "costume_id"
    t.index ["costume_id"], name: "index_costume_raid_timelines_on_costume_id"
  end

  create_table "costume_special_days", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "special_day_type_id"
    t.bigint "costume_id"
    t.index ["costume_id"], name: "index_costume_special_days_on_costume_id"
    t.index ["special_day_type_id"], name: "index_costume_special_days_on_special_day_type_id"
  end

  create_table "costume_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "costume_id"
    t.index ["costume_id"], name: "index_costume_timelines_on_costume_id"
  end

  create_table "costumes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.boolean "gender_variant"
    t.index ["pokemon_id"], name: "index_costumes_on_pokemon_id"
  end

  create_table "event_pokemons", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.bigint "event_timeline_id"
    t.index ["event_timeline_id"], name: "index_event_pokemons_on_event_timeline_id"
    t.index ["pokemon_id"], name: "index_event_pokemons_on_pokemon_id"
  end

  create_table "event_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buddy_distance"
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

  create_table "feature_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "released"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_caught_timelines", force: :cascade do |t|
    t.datetime "caught"
    t.integer "attack"
    t.integer "defence"
    t.integer "stamina"
    t.float "current_level"
    t.float "target_level"
    t.string "gender"
    t.boolean "shadow"
    t.boolean "purified"
    t.boolean "shiny"
    t.boolean "lucky"
    t.boolean "charge_move_unlocked"
    t.datetime "transferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_form_id"
    t.bigint "target_form_id"
    t.bigint "fast_move_id"
    t.bigint "first_charge_move_id"
    t.bigint "second_charge_move_id"
    t.bigint "original_owner_id"
    t.bigint "current_owner_id"
    t.bigint "current_level_id"
    t.bigint "target_level_id"
    t.boolean "high_iv"
    t.index ["current_form_id"], name: "index_form_caught_timelines_on_current_form_id"
    t.index ["current_level_id"], name: "index_form_caught_timelines_on_current_level_id"
    t.index ["current_owner_id"], name: "index_form_caught_timelines_on_current_owner_id"
    t.index ["fast_move_id"], name: "index_form_caught_timelines_on_fast_move_id"
    t.index ["first_charge_move_id"], name: "index_form_caught_timelines_on_first_charge_move_id"
    t.index ["original_owner_id"], name: "index_form_caught_timelines_on_original_owner_id"
    t.index ["second_charge_move_id"], name: "index_form_caught_timelines_on_second_charge_move_id"
    t.index ["target_form_id"], name: "index_form_caught_timelines_on_target_form_id"
    t.index ["target_level_id"], name: "index_form_caught_timelines_on_target_level_id"
  end

  create_table "form_event_pokemons", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "form_id"
    t.bigint "event_timeline_id"
    t.index ["event_timeline_id"], name: "index_form_event_pokemons_on_event_timeline_id"
    t.index ["form_id"], name: "index_form_event_pokemons_on_form_id"
  end

  create_table "form_raid_timelines", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "form_id"
    t.index ["form_id"], name: "index_form_raid_timelines_on_form_id"
  end

  create_table "form_special_days", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "special_day_type_id"
    t.bigint "form_id"
    t.index ["form_id"], name: "index_form_special_days_on_form_id"
    t.index ["special_day_type_id"], name: "index_form_special_days_on_special_day_type_id"
  end

  create_table "form_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "form_id"
    t.index ["form_id"], name: "index_form_timelines_on_form_id"
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
    t.boolean "default"
    t.index ["evolves_from_id"], name: "index_forms_on_evolves_from_id"
    t.index ["pokemon_id"], name: "index_forms_on_pokemon_id"
    t.index ["primary_type_id"], name: "index_forms_on_primary_type_id"
    t.index ["secondary_type_id"], name: "index_forms_on_secondary_type_id"
  end

  create_table "gbl_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "great_start"
    t.datetime "great_end"
    t.datetime "ultra_start"
    t.datetime "ultra_end"
    t.datetime "master_start"
    t.datetime "master_end"
    t.datetime "all_start"
    t.datetime "all_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "released"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medal_timelines", force: :cascade do |t|
    t.datetime "released"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "medal_id"
    t.index ["medal_id"], name: "index_medal_timelines_on_medal_id"
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

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "started"
    t.integer "level"
    t.float "stardust"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_caught_timelines", force: :cascade do |t|
    t.datetime "caught"
    t.integer "attack"
    t.integer "defence"
    t.integer "stamina"
    t.float "level"
    t.string "gender"
    t.boolean "shadow"
    t.boolean "purified"
    t.boolean "shiny"
    t.boolean "lucky"
    t.boolean "charge_move_unlocked"
    t.datetime "transferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_evolution_id"
    t.bigint "target_evolution_id"
    t.bigint "fast_move_id"
    t.bigint "first_charge_move_id"
    t.bigint "second_charge_move_id"
    t.bigint "original_owner_id"
    t.bigint "current_owner_id"
    t.bigint "current_level_id"
    t.bigint "target_level_id"
    t.boolean "high_iv"
    t.index ["current_evolution_id"], name: "index_pokemon_caught_timelines_on_current_evolution_id"
    t.index ["current_level_id"], name: "index_pokemon_caught_timelines_on_current_level_id"
    t.index ["current_owner_id"], name: "index_pokemon_caught_timelines_on_current_owner_id"
    t.index ["fast_move_id"], name: "index_pokemon_caught_timelines_on_fast_move_id"
    t.index ["first_charge_move_id"], name: "index_pokemon_caught_timelines_on_first_charge_move_id"
    t.index ["original_owner_id"], name: "index_pokemon_caught_timelines_on_original_owner_id"
    t.index ["second_charge_move_id"], name: "index_pokemon_caught_timelines_on_second_charge_move_id"
    t.index ["target_evolution_id"], name: "index_pokemon_caught_timelines_on_target_evolution_id"
    t.index ["target_level_id"], name: "index_pokemon_caught_timelines_on_target_level_id"
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
    t.float "name"
    t.integer "stardust"
    t.integer "candy"
    t.integer "candy_xl"
    t.float "cp_multiplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_pokemon_timelines_on_pokemon_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.integer "attack"
    t.integer "defence"
    t.integer "stamina"
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

  create_table "raid_timelines", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_raid_timelines_on_pokemon_id"
  end

  create_table "season_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shadow_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_shadow_timelines_on_pokemon_id"
  end

  create_table "shiny_costume_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "costume_id"
    t.index ["costume_id"], name: "index_shiny_costume_timelines_on_costume_id"
  end

  create_table "shiny_form_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "form_id"
    t.index ["form_id"], name: "index_shiny_form_timelines_on_form_id"
  end

  create_table "shiny_shadow_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_shiny_shadow_timelines_on_pokemon_id"
  end

  create_table "shiny_timelines", force: :cascade do |t|
    t.datetime "released"
    t.boolean "available"
    t.boolean "ignored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_shiny_timelines_on_pokemon_id"
  end

  create_table "special_day_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_days", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "special_day_type_id"
    t.bigint "pokemon_id"
    t.index ["pokemon_id"], name: "index_special_days_on_pokemon_id"
    t.index ["special_day_type_id"], name: "index_special_days_on_special_day_type_id"
  end

  create_table "special_league_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.datetime "end"
    t.integer "max_cp"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gbl_timeline_id"
    t.index ["gbl_timeline_id"], name: "index_special_league_timelines_on_gbl_timeline_id"
  end

  create_table "special_league_type_limits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "special_league_timeline_id"
    t.bigint "type_id"
    t.index ["special_league_timeline_id"], name: "index_special_league_type_limits_on_special_league_timeline_id"
    t.index ["type_id"], name: "index_special_league_type_limits_on_type_id"
  end

  create_table "special_research_timelines", force: :cascade do |t|
    t.string "name"
    t.datetime "released"
    t.boolean "timed"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "breakthrough_timelines", "pokemons"
  add_foreign_key "charge_moves", "types"
  add_foreign_key "costume_caught_timelines", "fast_moves"
  add_foreign_key "costume_caught_timelines", "pokemon_levels", column: "current_level_id"
  add_foreign_key "costume_caught_timelines", "pokemon_levels", column: "target_level_id"
  add_foreign_key "costume_event_pokemons", "costumes"
  add_foreign_key "costume_event_pokemons", "event_timelines"
  add_foreign_key "costume_raid_timelines", "costumes"
  add_foreign_key "costume_special_days", "costumes"
  add_foreign_key "costume_special_days", "special_day_types"
  add_foreign_key "costume_timelines", "costumes"
  add_foreign_key "costumes", "pokemons"
  add_foreign_key "event_pokemons", "event_timelines"
  add_foreign_key "event_pokemons", "pokemons"
  add_foreign_key "fast_moves", "types"
  add_foreign_key "form_caught_timelines", "fast_moves"
  add_foreign_key "form_caught_timelines", "pokemon_levels", column: "current_level_id"
  add_foreign_key "form_caught_timelines", "pokemon_levels", column: "target_level_id"
  add_foreign_key "form_event_pokemons", "event_timelines"
  add_foreign_key "form_event_pokemons", "forms"
  add_foreign_key "form_raid_timelines", "forms"
  add_foreign_key "form_special_days", "forms"
  add_foreign_key "form_special_days", "special_day_types"
  add_foreign_key "form_timelines", "forms"
  add_foreign_key "forms", "pokemons"
  add_foreign_key "medal_timelines", "medals"
  add_foreign_key "pokemon_caught_timelines", "fast_moves"
  add_foreign_key "pokemon_caught_timelines", "pokemon_levels", column: "current_level_id"
  add_foreign_key "pokemon_caught_timelines", "pokemon_levels", column: "target_level_id"
  add_foreign_key "pokemon_charge_moves", "charge_moves"
  add_foreign_key "pokemon_charge_moves", "pokemons"
  add_foreign_key "pokemon_fast_moves", "fast_moves"
  add_foreign_key "pokemon_fast_moves", "pokemons"
  add_foreign_key "pokemon_timelines", "pokemons"
  add_foreign_key "pokemons", "families"
  add_foreign_key "pokemons", "generations"
  add_foreign_key "raid_timelines", "pokemons"
  add_foreign_key "shadow_timelines", "pokemons"
  add_foreign_key "shiny_costume_timelines", "costumes"
  add_foreign_key "shiny_form_timelines", "forms"
  add_foreign_key "shiny_shadow_timelines", "pokemons"
  add_foreign_key "shiny_timelines", "pokemons"
  add_foreign_key "special_days", "pokemons"
  add_foreign_key "special_days", "special_day_types"
  add_foreign_key "special_league_timelines", "gbl_timelines"
  add_foreign_key "special_league_type_limits", "special_league_timelines"
  add_foreign_key "special_league_type_limits", "types"
end
