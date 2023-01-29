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

ActiveRecord::Schema[7.0].define(version: 2023_01_27_113949) do
  create_table "conjugations", force: :cascade do |t|
    t.string "present_i"
    t.string "present_you"
    t.string "present_hesheit"
    t.string "present_we"
    t.string "present_youall"
    t.string "present_they"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "translation_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "language_name"
  end

  create_table "translations", force: :cascade do |t|
    t.string "word"
    t.string "word_type"
    t.text "example"
    t.string "word_translation"
    t.integer "votes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "language_id"
  end

  add_foreign_key "conjugations", "translations"
  add_foreign_key "translations", "languages"
end
