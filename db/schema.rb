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

ActiveRecord::Schema[7.0].define(version: 2023_03_31_081136) do
  create_table "glossaries", force: :cascade do |t|
    t.string "source_language_code"
    t.string "target_language_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_language_code", "target_language_code"], name: "source_target_code", unique: true
  end

  create_table "language_codes", force: :cascade do |t|
    t.string "code"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string "source_term", null: false
    t.string "target_term", null: false
    t.integer "glossary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["glossary_id"], name: "index_terms_on_glossary_id"
    t.index ["source_term", "target_term"], name: "index_terms_on_source_term_and_target_term", unique: true
  end

  create_table "translations", force: :cascade do |t|
    t.text "source_text", null: false
    t.integer "glossary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["glossary_id"], name: "index_translations_on_glossary_id"
  end

end
