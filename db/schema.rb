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

ActiveRecord::Schema.define(version: 20160927175817) do

  create_table "issues", force: :cascade do |t|
    t.integer  "severity"
    t.string   "source"
    t.string   "description"
    t.text     "detail"
    t.string   "fingerprint"
    t.integer  "scan_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "repo_id"
    t.string   "scanner"
    t.string   "file"
    t.string   "line"
    t.string   "code"
  end

  add_index "issues", ["repo_id"], name: "index_issues_on_repo_id"
  add_index "issues", ["scan_id"], name: "index_issues_on_scan_id"

  create_table "repos", force: :cascade do |t|
    t.string   "name"
    t.string   "owner"
    t.string   "html_url"
    t.string   "description"
    t.string   "language"
    t.integer  "size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "scans", force: :cascade do |t|
    t.string   "status"
    t.integer  "repo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "scans", ["repo_id"], name: "index_scans_on_repo_id"

end
