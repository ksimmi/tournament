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

ActiveRecord::Schema.define(version: 2019_10_02_165123) do

  create_table "goals", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "team_id", null: false
    t.string "type", default: "goal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_goals_on_match_id"
    t.index ["team_id"], name: "index_goals_on_team_id"
    t.index ["type"], name: "index_goals_on_type"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["tournament_id"], name: "index_groups_on_tournament_id"
  end

  create_table "groups_teams", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "team_id", null: false
    t.index ["group_id"], name: "index_groups_teams_on_group_id"
    t.index ["team_id"], name: "index_groups_teams_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_matches_on_group_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams_tournaments", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "team_id", null: false
    t.index ["team_id"], name: "index_teams_tournaments_on_team_id"
    t.index ["tournament_id"], name: "index_teams_tournaments_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
