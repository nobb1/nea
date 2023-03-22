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

ActiveRecord::Schema[7.0].define(version: 2023_03_20_230642) do
  create_table "comments", force: :cascade do |t|
    t.text "text_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "translation_id", null: false
    t.integer "user_id", null: false
    t.integer "votes"
    t.index ["translation_id"], name: "index_comments_on_translation_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "comments_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_id", null: false
    t.integer "user_id", null: false
    t.index ["comment_id"], name: "index_comments_users_on_comment_id"
    t.index ["user_id"], name: "index_comments_users_on_user_id"
  end

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

  create_table "translations", force: :cascade do |t|
    t.string "word"
    t.string "word_type"
    t.text "example"
    t.string "word_translation"
    t.integer "votes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_translations_on_user_id"
  end

  create_table "translations_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "translation_id", null: false
    t.integer "user_id", null: false
    t.index ["translation_id"], name: "index_translations_users_on_translation_id"
    t.index ["user_id"], name: "index_translations_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "translations"
  add_foreign_key "comments_users", "comments"
  add_foreign_key "comments_users", "users"
  add_foreign_key "conjugations", "translations"
  add_foreign_key "translations", "users"
  add_foreign_key "translations_users", "translations"
  add_foreign_key "translations_users", "users"
end
