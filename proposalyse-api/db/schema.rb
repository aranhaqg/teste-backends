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

ActiveRecord::Schema.define(version: 2020_03_11_165813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "id_hash", null: false
    t.string "schema", null: false
    t.integer "schema_id"
    t.string "action", null: false
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proponents", force: :cascade do |t|
    t.string "id_hash", null: false
    t.string "name", null: false
    t.decimal "monthly_income", precision: 10, scale: 2, null: false
    t.integer "age", null: false
    t.boolean "is_main", null: false
    t.bigint "proposal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposal_id"], name: "index_proponents_on_proposal_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "id_hash", null: false
    t.decimal "loan_value", precision: 10, scale: 2, null: false
    t.integer "number_of_monthly_installments", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "warranties", force: :cascade do |t|
    t.string "id_hash"
    t.decimal "value", precision: 20, scale: 2
    t.string "province"
    t.bigint "proposal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposal_id"], name: "index_warranties_on_proposal_id"
  end

  add_foreign_key "proponents", "proposals"
  add_foreign_key "warranties", "proposals"
end
