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

ActiveRecord::Schema.define(version: 20141124112741) do

  create_table "fish", force: true do |t|
    t.string   "name"
    t.string   "another_name"
    t.string   "group"
    t.string   "url"
    t.string   "url2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fish_spots", force: true do |t|
    t.integer "spot_id", null: false
    t.integer "fish_id", null: false
  end

  create_table "spots", force: true do |t|
    t.string   "name"
    t.string   "prefecture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
