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

ActiveRecord::Schema.define(version: 20180107183351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hikes", force: :cascade do |t|
    t.string "name"
    t.float "start_lat"
    t.float "start_lng"
    t.string "region"
    t.string "description"
    t.string "notes"
    t.date "start_date"
    t.date "end_date"
    t.float "num_days"
    t.float "miles"
    t.float "elevation_gain"
    t.float "max_elevation"
    t.boolean "coast"
    t.boolean "rivers"
    t.boolean "lakes"
    t.boolean "waterfalls"
    t.boolean "fall_foliage"
    t.boolean "wildflowers"
    t.boolean "meadows"
    t.boolean "mountain_views"
    t.boolean "summits"
    t.boolean "established_campsites"
    t.boolean "day_hike"
    t.boolean "overnight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "old_growth"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hike_id"
  end

  create_table "trackpoints", force: :cascade do |t|
    t.integer "trackpoint_number"
    t.float "lat"
    t.float "lng"
    t.float "elevation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hike_id"
  end

  create_table "waypoints", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.datetime "time"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hike_id"
  end

  add_foreign_key "points", "hikes"
  add_foreign_key "trackpoints", "hikes"
  add_foreign_key "waypoints", "hikes"
end
