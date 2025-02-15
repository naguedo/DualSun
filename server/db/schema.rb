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

ActiveRecord::Schema.define(version: 2023_03_16_193322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commissioning_reports", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "siren", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "street", null: false
    t.string "city", null: false
    t.bigint "zip", null: false
    t.date "installed_on", null: false
    t.integer "option", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "panels", force: :cascade do |t|
    t.string "identifier"
    t.bigint "commissioning_report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commissioning_report_id"], name: "index_panels_on_commissioning_report_id"
  end

  add_foreign_key "panels", "commissioning_reports"
end
