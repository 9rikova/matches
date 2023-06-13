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

ActiveRecord::Schema[7.0].define(version: 2023_06_11_112626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "indicator_performances", force: :cascade do |t|
    t.bigint "indicator_id", null: false
    t.bigint "player_id", null: false
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["indicator_id"], name: "index_indicator_performances_on_indicator_id"
    t.index ["match_id"], name: "index_indicator_performances_on_match_id"
    t.index ["player_id"], name: "index_indicator_performances_on_player_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "first_team_id", null: false
    t.bigint "second_team_id", null: false
    t.integer "first_team_score"
    t.integer "second_team_score"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_team_id"], name: "index_matches_on_first_team_id"
    t.index ["second_team_id"], name: "index_matches_on_second_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "indicator_performances", "indicators"
  add_foreign_key "indicator_performances", "matches"
  add_foreign_key "indicator_performances", "players"
  add_foreign_key "matches", "teams", column: "first_team_id"
  add_foreign_key "matches", "teams", column: "second_team_id"
  add_foreign_key "players", "teams"
end
