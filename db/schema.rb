# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160529004234) do

  create_table "accidents", force: true do |t|
    t.string   "latitude"
    t.string   "longitude"
    t.string   "federative_unity"
    t.integer  "kilometer"
    t.string   "highway_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "title"
    t.string   "text"
    t.string   "idBr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "highway_id"
  end

  add_index "comments", ["highway_id"], name: "index_comments_on_highway_id"

  create_table "highways", force: true do |t|
    t.string   "idBr"
    t.integer  "mileage"
    t.integer  "comments_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "accidentsRate"
    t.float    "accidentsRatePercent"
    t.integer  "rankingPosition"
  end

  create_table "routes", force: true do |t|
    t.string   "origin"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
  end

end
